using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Rezervacija
{
    public int RezervacijaId { get; set; }

    public DateTime? Datum { get; set; }

    public string? Email { get; set; }

    public int? UposlenikId { get; set; }

    public int? KlijentId { get; set; }

    public int? TerminId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Termin? Termin { get; set; }

    public virtual Uposlenik? Uposlenik { get; set; }
}
