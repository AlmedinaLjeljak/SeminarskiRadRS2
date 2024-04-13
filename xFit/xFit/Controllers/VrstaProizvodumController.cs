using Microsoft.AspNetCore.Mvc;
using xFit.Model.SearchObjects;
using xFit.Services;

namespace xFit.Controllers
{
	[ApiController]
	public class VrstaProizvodumController:BaseController<Model.VrstaProizvodum,BaseSearchObject>
	{
		public VrstaProizvodumController(ILogger<BaseController<Model.VrstaProizvodum,BaseSearchObject>> logger,IService<Model.VrstaProizvodum,BaseSearchObject> service):base(logger,service)
		{

		}
	}
}
