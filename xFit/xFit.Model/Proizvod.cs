using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Model
{
	public partial class Proizvod
	{
		public int ProizvodId { get; set; }

		public string? Naziv { get; set; }

		public string? Sifra { get; set; }

		public decimal? Cijena { get; set; }

		public byte[]? Slika { get; set; }

		public int? VrstaProizvodaId { get; set; }

		public string? StateMachine { get; set; }
	}
}
