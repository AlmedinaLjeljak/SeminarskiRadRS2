using System;
using System.Collections.Generic;

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

    public virtual ICollection<Klijent> Klijents { get; } = new List<Klijent>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();

    public virtual Spol Spol { get; set; }

    public virtual ICollection<Uposlenik> Uposleniks { get; } = new List<Uposlenik>();
}
