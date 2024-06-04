using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public class Klijent
	{
		public int KlijentId { get; set; }

		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public DateTime? DatumRodjenja { get; set; }

		public int? KorisnikId { get; set; }

	}
}
