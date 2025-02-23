using xFit_rabbit.Data;

namespace xFit_rabbit.Models
{
	public partial class KorisnikUloga
	{
		public int KorisnikUlogaId { get; set; }

		public int? KorisnikId { get; set; }

		public int? UlogaId { get; set; }

		public DateTime? DatumIzmjene { get; set; }


		public virtual Uloga? Uloga { get; set; }
	}
}
