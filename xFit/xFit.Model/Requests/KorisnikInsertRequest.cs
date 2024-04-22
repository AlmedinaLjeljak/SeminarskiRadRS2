using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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

		[Compare("PasswordPotvrda",ErrorMessage ="Passwords do not match. ")]
		public string? Password { get; set; }

		[Compare("Password", ErrorMessage = "Passwords do not match. ")]
		public string? PasswordPotvrda { get; set; }
		public int? GradId { get; set; }
		public int? SpolId { get; set; }
	}
}
