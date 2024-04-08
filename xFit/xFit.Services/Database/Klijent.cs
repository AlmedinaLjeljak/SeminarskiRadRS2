using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Klijent
{
    public int KlijentId { get; set; }

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public DateTime? DatumRodjenja { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual ICollection<Novost> Novosts { get; } = new List<Novost>();

    public virtual ICollection<OmiljeniProizvod> OmiljeniProizvods { get; } = new List<OmiljeniProizvod>();

    public virtual ICollection<Recenzija> Recenzijas { get; } = new List<Recenzija>();

    public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();
}
