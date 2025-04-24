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
	public class ClanskaKartaService : BaseCRUDService<Model.ClanskaKarta, Database.ClanskaKarta, ClanskaKartaSearchObject, ClanskaKartaInsertRequest, ClanskaKartaUpdateRequest>, IClanskaKartaService
	{
		public ClanskaKartaService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<ClanskaKarta> AddFilter(IQueryable<ClanskaKarta> query, ClanskaKartaSearchObject? search = null)
		{
			if (search?.KorisnikId != 0)
			{
				query = query.Where(x => x.KorisnikId == search.KorisnikId);
			}

			return base.AddFilter(query, search);
		}
	}
}
