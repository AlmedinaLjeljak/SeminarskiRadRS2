using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class OmiljeniProizvod
{
    public int OmiljeniProizvodId { get; set; }

    public DateTime? DatumDodavanja { get; set; }

    public int? ProizvodId { get; set; }

    public int? KlijentId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Proizvod? Proizvod { get; set; }
}
