using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace xFit_rabbit.Services
{
	public interface IKorisniciService
	{
		Task<Models.Korisnik> GetKorisnik(int korisnikId);
		Task<Models.Korisnik> Login(string username, string password);
	}
}
