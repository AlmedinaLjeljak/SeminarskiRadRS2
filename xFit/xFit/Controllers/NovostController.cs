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
	public class NovostController : BaseCRUDController<Model.Novost, NovostSearchObject, NovostUpsertRequest, NovostUpsertRequest>
	{
		public NovostController(ILogger<BaseController<Model.Novost, Model.SearchObjects.NovostSearchObject>> logger, INovostService service) : base(logger, service)
		{


		}
	}
}
