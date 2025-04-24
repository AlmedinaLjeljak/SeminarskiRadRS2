using System;
using System.Collections.Generic;
using xFit.Model;

namespace xFit.Services.Database;

public partial class Korisnik
{
    public int KorisnikId { get; set; }

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public DateTime? DatumRodjenja { get; set; }

    public string? KorisnickoIme { get; set; }

   public int? GradId { get; set; }

    public int? SpolId { get; set; }

    public string? LozinkaHash { get; set; }

    public string? LozinkaSalt { get; set; }

    public virtual  Grad Grad { get; set; }
	public virtual ICollection<Novost> Novosts { get; set; } = new List<Novost>();
	public virtual ICollection<Klijent> Klijents { get; } = new List<Klijent>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();
	public virtual ICollection<Termin> KorisnikIdUposlenikNavigate { get; set; } = new List<Termin>();

	public virtual ICollection<Termin> KorisnikIdKlijentNavigate { get; set; } = new List<Termin>();
    public virtual ICollection<OmiljeniProizvod> OmiljeniProizvodis { get; set; } = new List<OmiljeniProizvod>();
    public virtual ICollection<Recenzija> Recenzijas { get; set; } = new List<Recenzija>();
	public virtual Spol Spol { get; set; }
	public virtual ICollection<ClanskaKarta> ClanskaKartas { get; } = new List<ClanskaKarta>();

	public virtual ICollection<Uposlenik> Uposleniks { get; } = new List<Uposlenik>();
}
