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
	public class NarudzbaService : BaseCRUDService<Model.Narudzba, Database.Narudzba, NarudzbeSearchObject, NarudzbaInsertRequest, NarudzbaUpdateRequest>, INarudzbaService
	{
		public NarudzbaService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
