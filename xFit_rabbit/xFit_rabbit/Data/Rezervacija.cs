using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Rezervacija
{
    public int RezervacijaID { get; set; }

    public DateTime? Datum { get; set; }

    public string? Email { get; set; }

    public int? UposlenikID { get; set; }

    public int? KlijentID { get; set; }

    public int? TerminID { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Termin? Termin { get; set; }

    public virtual Uposlenik? Uposlenik { get; set; }
}
