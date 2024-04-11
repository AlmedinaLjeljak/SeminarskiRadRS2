using Microsoft.AspNetCore.Mvc;
using xFit.Services;

namespace xFit.Controllers
{
	[Route("[controller]")]
	public class BaseController<T>:ControllerBase where T:class
	{
		private readonly IService<T> _service;
		private readonly ILogger<BaseController<T>> _logger;

		public BaseController(ILogger<BaseController<T>> logger,IService<T> service)
		{
			_logger = logger;
			_service = service;
		}
		[HttpGet()]
		public async Task<IEnumerable<T>> Get()
		{
			return await _service.Get();
		}
	}
}
