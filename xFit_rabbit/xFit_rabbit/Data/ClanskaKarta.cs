using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class ClanskaKarta
{
    public int ClanskaKArtaId { get; set; }

    public string? Sadrzaj { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnik? Korisnik { get; set; }
}
