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

	public class TerminController : BaseCRUDController<Model.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
	{
		public TerminController(ILogger<BaseController<Model.Termin, Model.SearchObjects.TerminSearchObject>> logger, ITerminService service) : base(logger, service)
		{


		}
	}
}
