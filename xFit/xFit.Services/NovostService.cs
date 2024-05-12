using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class NovostService:BaseCRUDService<Model.Novost,Database.Novost,NovostSearchObject,NovostUpsertRequest,NovostUpsertRequest>,INovostService
	{
		
		public NovostService(XFitContext context, IMapper mapper)
			: base(context, mapper)
		{
			
		}

		public override IQueryable<Database.Novost> AddFilter(IQueryable<Database.Novost> query, NovostSearchObject search = null)
		{
			var filteredQuery = base.AddFilter(query, search);

			if (!string.IsNullOrWhiteSpace(search?.Naziv))
			{
				filteredQuery = filteredQuery.Where(x => x.Naziv.StartsWith(search.Naziv));
			}
			return filteredQuery;
		}

		
	}
}
