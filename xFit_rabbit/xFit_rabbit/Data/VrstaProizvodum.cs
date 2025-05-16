using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class VrstaProizvodum
{
    public int VrstaProizvodaID { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Proizvod> Proizvods { get; } = new List<Proizvod>();
}
