using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class TerminInsertRequest
	{
		public DateTime? Datum { get; set; }
		public int? KorisnikIdUposlenik { get; set; }
		public int? KorisnikIdKlijent { get; set; }
	}
}
