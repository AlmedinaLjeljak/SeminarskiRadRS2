using AutoMapper;
using Azure.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Services.Database;

namespace xFit.Services.ProizvodStateMachine
{
	public class DraftProductState : BaseState
	{
		public DraftProductState(IServiceProvider serviceProvider,Database.XFitContext context, IMapper mapper) : base(serviceProvider,context, mapper)
		{
		}

		public override async Task<Model.Proizvod> Update(int id, ProizvodUpdateRequest request)
		{
			var set = _context.Set<Database.Proizvod>();

			var entity = await set.FindAsync(id);
			_mapper.Map(request, entity);

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Proizvod>(entity);
		
		}

		public override async Task<Model.Proizvod> Activate(int id)
		{
			var set = _context.Set<Database.Proizvod>();

			var entity = await set.FindAsync(id);

			entity.StateMachine = "active";

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Proizvod>(entity);

		}
		public override async Task<List<string>> AllowedActions()
		{
			var list = await base.AllowedActions();

			list.Add("Update");
			list.Add("Activate");

			return list;
		}
	}
}
