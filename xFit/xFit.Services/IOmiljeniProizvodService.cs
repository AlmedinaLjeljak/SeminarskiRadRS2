using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;

namespace xFit.Services
{
	public interface  IOmiljeniProizvodService:ICRUDService<Model.OmiljeniProizvod,OmiljeniProizvodSearchObject,OmiljeniProizvodUpsertRequest,OmiljeniProizvodUpsertRequest>
	{
	}
}
