using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public class Termin
	{
		public int TerminId { get; set; }

		public DateTime? Datum { get; set; }
		public int? KorisnikIdUposlenik { get; set; }
		public virtual Korisnik? KorisnikIdUposlenikNavigation { get; set; }
		public int? KorisnikIdKlijent { get; set; }
		public virtual Korisnik? KorisnikIdKlijentNavigation { get; set; }
	}
}
