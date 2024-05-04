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
	public class NarudzbaController : BaseCRUDController<Narudzba, NarudzbeSearchObject, NarudzbaInsertRequest, NarudzbaUpdateRequest>
	{
		public NarudzbaController(ILogger<BaseController<Model.Narudzba, Model.SearchObjects.NarudzbeSearchObject>> logger, INarudzbaService service) : base(logger, service)
		{


		}
	}


}
