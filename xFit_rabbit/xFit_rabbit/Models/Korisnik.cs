namespace xFit_rabbit.Models
{
	public class Korisnik
	{
		public int KorisnikId { get; set; }

		public string? Ime { get; set; }

		public string? Prezime { get; set; }

		public DateTime? DatumRodjenja { get; set; }

		public string? KorisnickoIme { get; set; }

		public int GradId { get; set; }

		public int SpolId { get; set; }
		public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();
	}
}
