using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services;


namespace xFit.Controllers
{
	public class ClanskaKartaController : BaseCRUDController<Model.ClanskaKarta, ClanskaKartaSearchObject, ClanskaKartaInsertRequest, ClanskaKartaUpdateRequest>
	{
		public ClanskaKartaController(ILogger<BaseController<ClanskaKarta, ClanskaKartaSearchObject>> logger, IClanskaKartaService service)
			: base(logger, service)
		{
		}
	}
}
