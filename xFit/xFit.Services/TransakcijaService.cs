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
	public class TransakcijaService : BaseCRUDService<Model.Transakcija, Database.Transakcija, BaseSearchObject, TransakcijaUpdateRequest, TransakcijaUpdateRequest>, ITransakcijaService
	{
		public TransakcijaService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
