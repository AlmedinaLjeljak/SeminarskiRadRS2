using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Termin
{
    public int TerminId { get; set; }

    public DateTime? DatumVrijeme { get; set; }

    public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();
}
