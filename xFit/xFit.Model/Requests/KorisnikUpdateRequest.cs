using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class KorisnikUpdateRequest
	{
		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public int? GradId { get; set; }

	}
}
