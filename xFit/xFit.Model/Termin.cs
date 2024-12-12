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

		public DateTime? DatumVrijeme { get; set; }
		public int? UposlenikId { get; set; }
		public virtual Uposlenik? Uposlenik { get; set; }
		public int? KlijentId { get; set; }
		public virtual Klijent? Klijent { get; set; }
	}
}
