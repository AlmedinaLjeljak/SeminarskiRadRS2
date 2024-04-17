using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Services.Database;

namespace xFit.Services.ProizvodStateMachine
{
	public class ActiveProductState : BaseState
	{
		public ActiveProductState(IServiceProvider serviceProvider,Database.XFitContext context, IMapper mapper) : base(serviceProvider,context, mapper)
		{
		}
	}
}
