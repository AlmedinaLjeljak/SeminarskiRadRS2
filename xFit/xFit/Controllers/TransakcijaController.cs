using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services;

namespace xFit.Controllers
{
	[ApiController]
	[Route("[controller]")]
	[AllowAnonymous]
	public class TransakcijaController : BaseCRUDController<Model.Transakcija, BaseSearchObject, TransakcijaUpdateRequest, TransakcijaUpdateRequest>
	{
		public TransakcijaController(ILogger<BaseController<Model.Transakcija,BaseSearchObject>> logger, ITransakcijaService service) : base(logger, service)
		{


		}
	}
}
