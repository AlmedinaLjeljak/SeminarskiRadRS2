﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class NovostUpsertRequest
	{
		public string? Naziv { get; set; }

		public string? Sadzaj { get; set; }

		public DateTime? DatumObjave { get; set; }
	}
}
