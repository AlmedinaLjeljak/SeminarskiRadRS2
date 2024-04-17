using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;

namespace xFit.Services
{
	public interface IProizvodService:ICRUDService<Proizvod,ProizvodSearchObject,PorizvodInsertRequest,ProizvodUpdateRequest>
	{
		Task<Proizvod> Activate(int id);

	}
}
