using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public class Uposlenik
	{
		public int UposlenikId { get; set; }

		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public DateTime? DatumRodjenja { get; set; }

		public int? KorisnikId { get; set; }

		public virtual Korisnik? Korisnik { get; set; }
	}
}
