using Microsoft.AspNetCore.Mvc;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services;

namespace xFit.Controllers
{
	[ApiController]
	public class RecommendResultController : BaseCRUDController<Model.RecommendResult, BaseSearchObject, RecommendResultUpsertRequest, RecommendResultUpsertRequest>
	{
		public RecommendResultController(ILogger<BaseController<Model.RecommendResult, BaseSearchObject>> logger, IRecommendResultService service)
			: base(logger, service)
		{
		}

		[HttpPost("TrainModel")]
		public virtual async Task<IActionResult> TrainModel()
		{
			try
			{
				var dto = await (_service as IRecommendResultService).TrainProductsModel();
				return Ok(dto);
			}
			catch (Exception e)
			{
				return BadRequest(e.Message);
			}
		}

		[HttpDelete("ClearRecommendation")]
		public virtual async Task<IActionResult> ClearRecommendation()
		{
			await (_service as IRecommendResultService).DeleteAllRecommendation();
			return Ok();
		}

	}
}
