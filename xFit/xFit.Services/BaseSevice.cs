using AutoMapper;
using Azure;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class BaseSevice<T,TDb,TSearch>:IService<T,TSearch> where TDb:class where T:class where TSearch:BaseSearchObject
	{
		protected XFitContext _context;
		public IMapper _mapper { get; set; }
		public BaseSevice(XFitContext context,IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}

		public async Task<PagedResult<T>> Get(TSearch? search=null)
		{
			var query = _context.Set<TDb>().AsQueryable();

			PagedResult<T> result = new PagedResult<T>();
		

			query = AddFilter(query, search);
			query = AddInclude(query, search);
			result.Count = await query.CountAsync();

			if (search?.Page.HasValue==true && search?.PageSize.HasValue==true)
			{
				query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
			}

			var list = await query.ToListAsync();

			var tmp = _mapper.Map<List<T>>(list);
			result.Result = tmp;
			return result;
		}

		public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
		{
			return query;
		}
		public virtual IQueryable<TDb> AddFilter(IQueryable<TDb>query,TSearch? search=null)
		{
			return query;
		}

		public async Task<T> GetById(int id)
		{
			var entity = await _context.Set<TDb>().FindAsync(id);
			return _mapper.Map<T>(entity);
		}
	}
}
