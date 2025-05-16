using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Transakcija
{
    public int TransakcijaID { get; set; }

    public double? Iznos { get; set; }

    public int? NarudzbaID { get; set; }

    public virtual Narudzba? Narudzba { get; set; }
}
