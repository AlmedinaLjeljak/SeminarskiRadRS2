using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class OmiljeniProizvod
{
    public int OmiljeniProizvodID { get; set; }

    public DateTime? DatumDodavanja { get; set; }

    public int? ProizvodID { get; set; }

    public int? KlijentID { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual Proizvod? Proizvod { get; set; }
}
