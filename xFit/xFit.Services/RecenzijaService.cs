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
	public class RecenzijaService:BaseCRUDService<Model.Recenzija,Database.Recenzija,RecenzijaSearchObject,RecenzijaInsertRequest,RecenzijaUpdateRequest>,IRecenzijaService
	{
		public RecenzijaService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Recenzija> AddFilter(IQueryable<Recenzija> query, RecenzijaSearchObject? search = null)
		{
			var filteredQuery = base.AddFilter(query, search);

			if (search.ProizvodId != null && search.ProizvodId != 0)
			{
				filteredQuery = filteredQuery.Where(x => x.ProizvodId == search.ProizvodId);
			}

			return filteredQuery;
		}
	}
}
