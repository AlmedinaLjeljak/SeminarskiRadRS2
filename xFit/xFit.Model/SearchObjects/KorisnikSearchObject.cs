﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.SearchObjects
{
	public class KorisnikSearchObject:BaseSearchObject
	{
		public string? Ime { get; set; }
		public string? FTS { get; set; }
		public int? KorisnikId { get; set; }
		public bool? isUlogeIncluded { get; set; }
	}
}
