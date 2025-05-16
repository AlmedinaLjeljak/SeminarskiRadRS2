using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Uposlenik
{
    public int UposlenikID { get; set; }

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public DateTime? DatumRodjenja { get; set; }

    public int? KorisnikID { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();
}
