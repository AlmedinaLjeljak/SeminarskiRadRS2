using Microsoft.AspNetCore.Mvc;
using xFit.Services;

namespace xFit.Controllers
{
	[ApiController]
	public class VrstaProizvodumController:BaseController<Model.VrstaProizvodum>
	{
		public VrstaProizvodumController(ILogger<BaseController<Model.VrstaProizvodum>> logger,IService<Model.VrstaProizvodum> service):base(logger,service)
		{

		}
	}
}
