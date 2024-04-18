using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Services.Database;

namespace xFit.Services.ProizvodStateMachine
{
	public class BaseState
	{
		protected XFitContext _context;
		public IMapper _mapper { get; set; }
		public IServiceProvider _serviceProvider { get; set; }
		public BaseState(IServiceProvider serviceProvider,XFitContext context, IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
			_serviceProvider = serviceProvider;
		}
		public virtual Task<Model.Proizvod> Insert(PorizvodInsertRequest request)
		{
			throw new Exception("Not allowed");
		}

		public virtual Task<Model.Proizvod> Update(int id,ProizvodUpdateRequest request)
		{
			throw new Exception("Not allowed");
		}
		public virtual Task<Model.Proizvod> Activate(int id)
		{
			throw new Exception("Not allowed");
		}
		public virtual Task<Model.Proizvod> Hide(int id )
		{
			throw new Exception("Not allowed");
		}
		public virtual Task<Model.Proizvod> Delete(int id)
		{
			throw new Exception("Not allowed");
		}

		public BaseState Createstate(string stateName)
		{
			switch(stateName)
			{
				case "initial":
				case null:
					return _serviceProvider.GetService<InitialProductState>();
					break;
				case "draft":
					return _serviceProvider.GetService<DraftProductState>();
					break;
				case "active":
					return _serviceProvider.GetService<ActiveProductState>();
					break;

				default:
					throw new Exception("Not allowed");
			}
		}
		public virtual async Task<List<string>> AllowedActions()
		{
			return new List<string>();
		}
	}
}
