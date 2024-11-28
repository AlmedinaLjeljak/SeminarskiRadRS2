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
	
	public class StavkaNarudzbeController : BaseCRUDController<Model.StavkaNarudzbe, StavkaNarudzbeSearchObject, StavkaNarudzbeInsertRequest, StavkaNarudzbeUpdateRequest>
	{
		public StavkaNarudzbeController(ILogger<BaseController<Model.StavkaNarudzbe, Model.SearchObjects.StavkaNarudzbeSearchObject>> logger, IStavkaNarudzbeService service) : base(logger, service)
		{


		}
	}


}
