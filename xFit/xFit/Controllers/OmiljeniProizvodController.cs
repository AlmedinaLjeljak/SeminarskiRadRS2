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
	public class OmiljeniProizvodController : BaseCRUDController<OmiljeniProizvod, OmiljeniProizvodSearchObject, OmiljeniProizvodUpsertRequest, OmiljeniProizvodUpsertRequest>
	{
		public OmiljeniProizvodController(ILogger<BaseController<Model.OmiljeniProizvod, Model.SearchObjects.OmiljeniProizvodSearchObject>> logger, IOmiljeniProizvodService service) : base(logger, service)
		{


		}
	}


}
