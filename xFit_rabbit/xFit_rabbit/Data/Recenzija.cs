using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Recenzija
{
    public int RecenzijaId { get; set; }

    public string? Sadrzaj { get; set; }

    public DateTime? Datum { get; set; }

    public int? ProizvodId { get; set; }

    public int? KlijentId { get; set; }

    public virtual Klijent? Klijent { get; set; }

    public virtual Proizvod? Proizvod { get; set; }
}
