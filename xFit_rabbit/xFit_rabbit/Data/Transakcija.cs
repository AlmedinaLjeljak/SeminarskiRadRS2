using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Transakcija
{
    public int TransakcijaId { get; set; }

    public double? Iznos { get; set; }

    public int? NarudzbaId { get; set; }

    public virtual Narudzba? Narudzba { get; set; }
}
