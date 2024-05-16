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
	
	public class ProizvodController : BaseCRUDController<Model.Proizvod, Model.SearchObjects.ProizvodSearchObject,Model.Requests.PorizvodInsertRequest,Model.Requests.ProizvodUpdateRequest>
	{


		public ProizvodController(ILogger<BaseController<Model.Proizvod, Model.SearchObjects.ProizvodSearchObject>> logger, IProizvodService service) : base(logger, service)
		{


		}
		[HttpPut("{id}/activate")]
		public virtual async Task<Model.Proizvod> Activate(int id)
		{
			return await (_service as IProizvodService).Activate(id);
		}

		[HttpPut("{id}/hide")]
		public virtual async Task<Model.Proizvod> Hide(int id)
		{
			return await (_service as IProizvodService).Hide(id);
		}

		[HttpGet("{id}/allowedActions")]
		public virtual async Task<List<string>> AllowedActions(int id)
		{
			return await (_service as IProizvodService).AllowedActions(id);
		}

		[HttpGet("{id}/recommend")]
		public virtual List<Model.Proizvod>Recommend(int id)
		{
			return  (_service as IProizvodService).Recommend(id);
		}

	}
} 