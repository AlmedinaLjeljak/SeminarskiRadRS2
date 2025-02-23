using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Narudzba
{
    public int NarudzbaId { get; set; }

    public string? BrojNarudzbe { get; set; }

    public DateTime? Datum { get; set; }

    public string? Status { get; set; }

    public double? Iznos { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual ICollection<StavkaNarudzbe> StavkaNarudzbes { get; } = new List<StavkaNarudzbe>();

    public virtual ICollection<Transakcija> Transakcijas { get; } = new List<Transakcija>();
}
