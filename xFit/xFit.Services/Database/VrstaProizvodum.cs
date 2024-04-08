using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class VrstaProizvodum
{
    public int VrstaProizvodaId { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Proizvod> Proizvods { get; } = new List<Proizvod>();
}
