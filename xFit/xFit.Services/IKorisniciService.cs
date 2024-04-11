using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;

namespace xFit.Services
{
	public interface IKorisniciService
	{
		Task<List<Model.Korisnik>> Get();
		Model.Korisnik Insert(KorisnikInsertRequest request);
		Model.Korisnik Update(int id, KorisnikUpdateRequest request);
	}
}
