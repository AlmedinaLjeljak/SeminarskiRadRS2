using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Novost
{
    public int NovostID { get; set; }

    public string? Naziv { get; set; }

    public string? Sadzaj { get; set; }

    public DateTime? DatumObjave { get; set; }

    public int? KorisnikId { get; set; }

    public int? KlijentId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Korisnik? Korisnik { get; set; }
}
