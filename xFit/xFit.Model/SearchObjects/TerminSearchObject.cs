using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.SearchObjects
{
	public class TerminSearchObject:BaseSearchObject
	{
		public string? Uposlenik { get; set; }
		public string? Klijent { get; set; }
		public DateTime? DatumVrijeme { get; set; }
	}
}
