using Microsoft.AspNetCore.Authorization;
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
	[AllowAnonymous]
	public class KorisniciController : BaseCRUDController<Model.Korisnik, Model.SearchObjects.KorisnikSearchObject,Model.Requests.KorisnikInsertRequest,Model.Requests.KorisnikUpdateRequest>
	{


		public KorisniciController(ILogger<BaseController<Model.Korisnik, Model.SearchObjects.KorisnikSearchObject>> logger, IKorisniciService service) : base(logger, service)
		{


		}

		[AllowAnonymous]
		public override Task<Model.Korisnik> Insert([FromBody]KorisnikInsertRequest insert)
		{
			return base.Insert(insert);
		}

		
	}
	} 