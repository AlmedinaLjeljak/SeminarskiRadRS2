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

namespace xFit.Services
{
	public class OmiljeniProizvodService : BaseCRUDService<Model.OmiljeniProizvod, Database.OmiljeniProizvod, OmiljeniProizvodSearchObject, OmiljeniProizvodUpsertRequest, OmiljeniProizvodUpsertRequest>, IOmiljeniProizvodService
	{
		public OmiljeniProizvodService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override IQueryable<Database.OmiljeniProizvod> AddFilter(IQueryable<Database.OmiljeniProizvod> query, OmiljeniProizvodSearchObject? search = null)
		{
			var filteredQuery = base.AddFilter(query, search);

			if (search.KlijentId != null && search.KlijentId != 0)
			{
				filteredQuery = filteredQuery.Where(x => x.KlijentId == search.KlijentId);
			}

			if (search.ProizvodId != null && search.ProizvodId != 0)
			{
				filteredQuery = filteredQuery.Where(x => x.ProizvodId == search.ProizvodId);
			}

			return filteredQuery;
		}
	}
}
