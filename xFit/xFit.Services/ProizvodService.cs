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
	public class ProizvodService : BaseCRUDService<Model.Proizvod, Database.Proizvod, ProizvodSearchObject, PorizvodInsertRequest, ProizvodUpdateRequest>, IProizvodService
	{
		public ProizvodService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
