using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Korisnik
{
    public int KorisnikID { get; set; }

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public DateTime? DatumRodjenja { get; set; }

    public string? KorisnickoIme { get; set; }

    public int GradID { get; set; }

    public int SpolID { get; set; }

    public string? LozinkaHash { get; set; }

    public string? LozinkaSalt { get; set; }

    public virtual ICollection<ClanskaKarta> ClanskaKarta { get; } = new List<ClanskaKarta>();

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Klijent> Klijents { get; } = new List<Klijent>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();

    public virtual ICollection<Novost> Novosts { get; } = new List<Novost>();

    public virtual ICollection<OmiljeniProizvod> OmiljeniProizvods { get; } = new List<OmiljeniProizvod>();

    public virtual ICollection<Recenzija> Recenzijas { get; } = new List<Recenzija>();

    public virtual Spol Spol { get; set; } = null!;

    public virtual ICollection<Termin> TerminKorisnikIdKlijentNavigations { get; } = new List<Termin>();

    public virtual ICollection<Termin> TerminKorisnikIdUposlenikNavigations { get; } = new List<Termin>();

    public virtual ICollection<Uposlenik> Uposleniks { get; } = new List<Uposlenik>();
}
