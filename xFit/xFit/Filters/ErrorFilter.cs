using Microsoft.AspNetCore.Mvc.Filters;

namespace xFit.Filters
{
	public class ErrorFilter:ExceptionFilterAttribute
	{
		public override void OnException(ExceptionContext context)
		{
			context.ModelState.AddModelError("ERROR", "Server side error");



			base.OnException(context);
		}
	}
}
