using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Spol
{
    public int SpolID { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Korisnik> Korisniks { get; } = new List<Korisnik>();
}
