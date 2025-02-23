using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Termin
{
    public int TerminId { get; set; }

    public DateTime? DatumVrijeme { get; set; }

    public int? UposlenikId { get; set; }

    public int? KlijentId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();

    public virtual Uposlenik? Uposlenik { get; set; }
}
