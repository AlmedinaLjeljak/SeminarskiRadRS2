using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class TerminInsertRequest
	{
		public DateTime? DatumVrijeme { get; set; }
		public int? UposlenikId { get; set; }
		public int? KlijentId { get; set; }
	}
}
