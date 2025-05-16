using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class StavkaNarudzbe
{
    public int StavkaNarudzbeID { get; set; }

    public int? Kolicina { get; set; }

    public int? NarudzbaID { get; set; }

    public int? ProizvodID { get; set; }

    public virtual Narudzba? Narudzba { get; set; }

    public virtual Proizvod? Proizvod { get; set; }
}
