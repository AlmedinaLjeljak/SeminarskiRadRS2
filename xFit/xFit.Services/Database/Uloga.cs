using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Uloga
{
    public int UlogaId { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();
}
