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
	
	public class GradController : BaseCRUDController<Model.Grad, BaseSearchObject, GradUpsertRequest, GradUpsertRequest>
	{
		public GradController(ILogger<BaseController<Model.Grad, BaseSearchObject>> logger, IGradService service) : base(logger, service)
		{


		}
	}
}
