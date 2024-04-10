using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class KorisnikInsertRequest
	{
		
		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public DateTime? DatumRodjenja { get; set; }

		public string? KorisnickoIme { get; set; }
		public string? Password { get; set; }
		public string? PasswordPotvrda { get; set; }
		public int? GradId { get; set; }
		public int? SpolId { get; set; }
	}
}
