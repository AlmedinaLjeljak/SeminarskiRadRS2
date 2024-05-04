using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public partial class Transakcija
	{
		public int TransakcijaId { get; set; }

		public double? Iznos { get; set; }

		public int? NarudzbaId { get; set; }
	}
}
