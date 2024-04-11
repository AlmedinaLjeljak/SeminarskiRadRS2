using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Services.Database;

namespace xFit.Services
{
	public class BaseSevice<T,TDb>:IService<T> where TDb:class where T:class
	{
		XFitContext _context;
		public IMapper _mapper { get; set; }
		public BaseSevice(XFitContext context,IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}

		public async Task<List<T>> Get()
		{
			var query = _context.Set<TDb>().AsQueryable();

			var list = await query.ToListAsync();
			return _mapper.Map<List<T>>(list);
		}

	}
}
