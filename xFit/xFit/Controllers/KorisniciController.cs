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
	public class KorisniciController : ControllerBase
	{

		private readonly IKorisniciService _service;
		private readonly ILogger<WeatherForecastController> _logger;

		public KorisniciController(ILogger<WeatherForecastController> logger, IKorisniciService service)
		{
			_logger = logger;
			_service = service;

		}
		[HttpGet()]
		  public IEnumerable<Model.Korisnik> Get()
			{
		       return _service.Get();

			}
		 [HttpPost]
		   public Model.Korisnik Insert(KorisnikInsertRequest request)
		    {
			return _service.Insert(request);
		    }
		[HttpPut("{id}")]
		public Model.Korisnik Update(int id,KorisnikUpdateRequest request)
		{
			return _service.Update(id, request);
		}

		}
	} 