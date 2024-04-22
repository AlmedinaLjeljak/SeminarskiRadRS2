using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;

namespace xFit.Services
{
	public interface IKorisniciService:ICRUDService<Model.Korisnik,Model.SearchObjects.KorisnikSearchObject,Model.Requests.KorisnikInsertRequest,Model.Requests.KorisnikUpdateRequest>
	{
		public Task<Model.Korisnik> Login(string username, string password);
	
	}
}
