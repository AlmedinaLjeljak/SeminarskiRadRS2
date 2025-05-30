﻿using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class KorisnikUloga
{
    public int KorisnikUlogaID { get; set; }

    public int? KorisnikID { get; set; }

    public int? UlogaID { get; set; }

    public DateTime? DatumIzmjene { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual Uloga? Uloga { get; set; }
}
