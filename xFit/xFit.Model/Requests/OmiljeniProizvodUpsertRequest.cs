using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class OmiljeniProizvodUpsertRequest
	{

		public DateTime? DatumDodavanja { get; set; }

		public int? ProizvodId { get; set; }

		public int? KlijentId { get; set; }

	
	}
}
