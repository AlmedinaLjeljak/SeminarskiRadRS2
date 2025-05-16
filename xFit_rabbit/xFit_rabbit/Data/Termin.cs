using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Termin
{
    public int TerminID { get; set; }

    public DateTime? Datum { get; set; }

    public int? KorisnikIdKlijent { get; set; }

    public int? KorisnikIdUposlenik { get; set; }

    public virtual Korisnik? KorisnikIdKlijentNavigation { get; set; }

    public virtual Korisnik? KorisnikIdUposlenikNavigation { get; set; }

    public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();
}
