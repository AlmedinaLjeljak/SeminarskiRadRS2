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
	public class KlijentController : BaseCRUDController<Model.Klijent, KlijentSearchObject, KlijentInsertRequest, KlijentUpdateRequest>
	{
		public KlijentController(ILogger<BaseController<Model.Klijent, KlijentSearchObject>> logger, IKlijentService service) : base(logger, service)
		{


		}
	}
}
