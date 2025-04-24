﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public class ClanskaKarta
	{
		public int ClanskaKartaId { get; set; }
		public string? Sadrzaj { get; set; }
		public int? KorisnikId { get; set; }
		public virtual Korisnik? Korisnik { get; set; }
	}
}
