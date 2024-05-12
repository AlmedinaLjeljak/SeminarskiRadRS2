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
	public class RecenzijaController : BaseCRUDController<Model.Recenzija, RecenzijaSearchObject, RecenzijaInsertRequest, RecenzijaUpdateRequest>
	{
		public RecenzijaController(ILogger<BaseController<Model.Recenzija, Model.SearchObjects.RecenzijaSearchObject>> logger, IRecenzijaService service) : base(logger, service)
		{


		}
	}
}
