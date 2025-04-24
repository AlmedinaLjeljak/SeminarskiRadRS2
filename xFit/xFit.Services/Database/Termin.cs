using System;
using System.Collections.Generic;

namespace xFit.Services.Database;

public partial class Termin
{
    public int TerminId { get; set; }

    public DateTime? Datum { get; set; }
    public int? KorisnikIdKlijent { get; set; }
    public virtual Korisnik? KorisnikIdKlijentNavigate { get; set; }
	public int? KorisnikIdUposlenik { get; set; }
	public virtual Korisnik? KorisnikIdUposlenikNavigate{ get; set; }

	public virtual ICollection<Rezervacija> Rezervacijas { get; } = new List<Rezervacija>();
}
