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
	public class KlijentService : BaseCRUDService<Model.Klijent, Database.Klijent, KlijentSearchObject, KlijentInsertRequest, KlijentUpdateRequest>,IKlijentService
	{
		public KlijentService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Database.Klijent> AddFilter(IQueryable<Database.Klijent> query, KlijentSearchObject? search = null)
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
