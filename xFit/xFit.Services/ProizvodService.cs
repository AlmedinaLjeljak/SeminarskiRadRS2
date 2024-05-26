using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;
using xFit.Services.ProizvodStateMachine;

namespace xFit.Services
{
	public class ProizvodService : BaseCRUDService<Model.Proizvod, Database.Proizvod, ProizvodSearchObject, PorizvodInsertRequest, ProizvodUpdateRequest>, IProizvodService
	{
		public BaseState _BaseState { get; set; }
		public ProizvodService(BaseState baseState,XFitContext context, IMapper mapper) : base(context, mapper)
		{
			_BaseState = baseState;
		}

		public override IQueryable<Database.Proizvod> AddFilter(IQueryable<Database.Proizvod> query, ProizvodSearchObject? search = null)
		{
			var filterQuery = base.AddFilter(query, search);
			if(string.IsNullOrWhiteSpace(search?.FTS))
			{
				filterQuery = filterQuery.Where(x => x.Naziv.Contains(search.FTS) || x.Sifra.Contains(search.FTS));
			}
			if(!string.IsNullOrWhiteSpace(search?.Sifra))
			{
				filterQuery = filterQuery.Where(x => x.Sifra == search.Sifra);
			}
			return filterQuery;
		}

		public override Task<Model.Proizvod> Insert(PorizvodInsertRequest insert)
		{
			var state = _BaseState.Createstate("initial");

			return state.Insert(insert);
		}

		public override async Task<Model.Proizvod> Update(int id, ProizvodUpdateRequest update)
		{
			var entity =await _context.Proizvods.FindAsync(id);

			var state = _BaseState.Createstate(entity.StateMachine);
			return await state.Update(id,update);
		


		}
		public async Task<Model.Proizvod> Activate(int id)
		{
			var entity = await _context.Proizvods.FindAsync(id);

			var state = _BaseState.Createstate(entity.StateMachine);

			return await state.Activate(id);
		}
		public async Task<Model.Proizvod> Hide(int id)
		{
			var entity = await _context.Proizvods.FindAsync(id);

			var state = _BaseState.Createstate(entity.StateMachine);

			return await state.Hide(id);
		}

		public async Task<List<string>> AllowedActions(int id)
		{
			var entity = await _context.Proizvods.FindAsync(id);
			var state = _BaseState.Createstate(entity?.StateMachine ?? "initial");

			return await state.AllowedActions();
		}

		static MLContext mlContext = null;
		static object isLocked = new object();
		ITransformer model=null;

		public List<Model.Proizvod> Recommend(int id)
		{
			lock(isLocked)
			{
				if(mlContext==null)
				{
					mlContext = new MLContext();

					var tmpData = _context.Narudzbas.Include("StavkaNarudzbes").ToList();

					var data = new List<ProductEntry>();

					foreach (var x in tmpData)
					{
						if(x.StavkaNarudzbes.Count> 1)
						{
							var distinctItemId = x.StavkaNarudzbes.Select(y => y.ProizvodId).ToList();
							distinctItemId.ForEach(y =>
							{
								var relatedItems = x.StavkaNarudzbes.Where(z => z.ProizvodId != y);
								foreach (var z in relatedItems)
								{
									data.Add(new ProductEntry()
									{
										ProductID = (uint)y,
										CoPurchaseProductID = (uint)z.ProizvodId,

									});
								}
							});
						}
					}

					var traindata = mlContext.Data.LoadFromEnumerable(data);

					//STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
					//        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
					MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
					options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
					options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
					options.LabelColumnName = "Label";
					options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
					options.Alpha = 0.01;
					options.Lambda = 0.025;
					// For better results use the following parameters
					options.NumberOfIterations = 100;
					options.C = 0.00001;

					var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

					
					
					model = est.Fit(traindata);


				}
			}

			//prediction

			var products = _context.Proizvods.Where(x => x.ProizvodId != id);
			var predictionResult = new List<Tuple<Database.Proizvod, float>>();

			foreach (var product in products)
			{

				var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
				var prediction = predictionengine.Predict(
										 new ProductEntry()
										 {
											 ProductID = (uint)id,
											 CoPurchaseProductID = (uint)product.ProizvodId
										 });


				predictionResult.Add(new Tuple<Database.Proizvod, float>(product, prediction.Score));
			}

			var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).ToList();

			return _mapper.Map<List<Model.Proizvod>>(finalResult);
		}


	}

	public class Copurchase_prediction
	{
		public float Score { get; set; }
	}

	public class ProductEntry
	{
		[KeyType(count: 10)]
		public uint ProductID { get; set; }

		[KeyType(count: 10)]
		public uint CoPurchaseProductID { get; set; }

		public float Label { get; set; }
	}




}
