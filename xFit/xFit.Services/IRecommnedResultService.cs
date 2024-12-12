using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;

namespace xFit.Services
{
	public interface IRecommendResultService : ICRUDService<Model.RecommendResult, BaseSearchObject, RecommendResultUpsertRequest, RecommendResultUpsertRequest>
	{
		Task<List<Model.RecommendResult>> TrainProductsModel();
		Task DeleteAllRecommendation();
	}
}
