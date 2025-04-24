using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Novost
{
    public int NovostId { get; set; }

    public string? Naziv { get; set; }

    public string? Sadzaj { get; set; }

    public DateTime? DatumObjave { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnik? Korisnik { get; set; }
}
