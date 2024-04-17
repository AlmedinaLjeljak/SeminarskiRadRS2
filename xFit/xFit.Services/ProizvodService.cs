using AutoMapper;
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
		
	}
}
