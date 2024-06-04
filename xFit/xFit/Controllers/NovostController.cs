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
	public class UposlenikController : BaseCRUDController<Model.Uposlenik, UposlenikSearchObject, UposlenikInsertRequest, UposlenikUpdateRequest>
	{
		public UposlenikController(ILogger<BaseController<Model.Uposlenik, Model.SearchObjects.UposlenikSearchObject>> logger, IUposlenikService service) : base(logger, service)
		{


		}
	}
}
