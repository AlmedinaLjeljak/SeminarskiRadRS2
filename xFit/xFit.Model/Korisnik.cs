using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public class Korisnik
	{
		public int KorisnikId { get; set; }

		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public DateTime? DatumRodjenja { get; set; }
		public byte[]? Slika { get; set; }
		public string? Email { get; set; }
		public string? Telefon { get; set; }
		public string? Adresa { get; set; }


		public string? KorisnickoIme { get; set; }

		
		public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

		
	}
}
