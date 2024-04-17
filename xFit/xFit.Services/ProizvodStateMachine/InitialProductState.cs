using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.Requests;

namespace xFit.Services.ProizvodStateMachine
{
	public class InitialProductState:BaseState
	{
		public InitialProductState(IServiceProvider serviceProvider,Database.XFitContext context, IMapper mapper) : base(serviceProvider,context, mapper)
		{
		}

		public override async Task<Proizvod> Insert(PorizvodInsertRequest request)
		{
			var set = _context.Set<Database.Proizvod>();

			var entity = _mapper.Map<Database.Proizvod>(request);

			entity.StateMachine = "draft";
			
			set.Add(entity);

			await _context.SaveChangesAsync();
			return _mapper.Map<Proizvod>(entity);
		}
	}
}
