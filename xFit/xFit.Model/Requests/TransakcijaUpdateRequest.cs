using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model.Requests
{
	public class TransakcijaUpdateRequest
	{
		public double? Iznos { get; set; }

		public int? NarudzbaId { get; set; }
	}
}
