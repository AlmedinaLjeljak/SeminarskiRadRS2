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
	public class StavkaNarudzbeService : BaseCRUDService<Model.StavkaNarudzbe, Database.StavkaNarudzbe, StavkaNarudzbeSearchObject, StavkaNarudzbeInsertRequest, StavkaNarudzbeUpdateRequest>, IStavkaNarudzbeService
	{
		
		public StavkaNarudzbeService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}

		/*public override IQueryable<StavkaNarudzbe> AddFilter(IQueryable<StavkaNarudzbe> query, StavkaNarudzbeSearchObject? search = null)
		{
			if (search?.NarudzbaId != 0)
			{
				query = query.Where(x => x.NarudzbaId == search.NarudzbaId);
			}

			return base.AddFilter(query, search);
		}*/


	}
}
