using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Services;
using xFit.Services.Database;

namespace xFit.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class ProizvodController : BaseCRUDController<Model.Proizvod, Model.SearchObjects.ProizvodSearchObject,Model.Requests.PorizvodInsertRequest,Model.Requests.ProizvodUpdateRequest>
	{


		public ProizvodController(ILogger<BaseController<Model.Proizvod, Model.SearchObjects.ProizvodSearchObject>> logger, IProizvodService service) : base(logger, service)
		{


		}

		
	}
	} 