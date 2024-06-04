using AutoMapper;
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
	public class UposlenikService : BaseCRUDService<Model.Uposlenik, Database.Uposlenik, UposlenikSearchObject, UposlenikInsertRequest, UposlenikUpdateRequest>,IUposlenikService
	{
		public UposlenikService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override IQueryable<Database.Uposlenik> AddFilter(IQueryable<Database.Uposlenik> query, UposlenikSearchObject? search = null)
		{
			var filterQuery = base.AddFilter(query, search);

			if (!string.IsNullOrWhiteSpace(search?.Ime))
			{
				filterQuery = filterQuery.Where(x => x.Ime.Contains(search.Ime) || x.Prezime.Contains(search.Ime));
			}

			return filterQuery;
		}
	}
}
