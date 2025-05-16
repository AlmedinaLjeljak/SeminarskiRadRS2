using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class Proizvod
{
    public int ProizvodID { get; set; }

    public string? Naziv { get; set; }

    public string? Sifra { get; set; }

    public decimal? Cijena { get; set; }

    public byte[]? Slika { get; set; }

    public int? VrstaProizvodaID { get; set; }

    public string? StateMachine { get; set; }

    public virtual ICollection<OmiljeniProizvod> OmiljeniProizvods { get; } = new List<OmiljeniProizvod>();

    public virtual ICollection<Recenzija> Recenzijas { get; } = new List<Recenzija>();

    public virtual ICollection<StavkaNarudzbe> StavkaNarudzbes { get; } = new List<StavkaNarudzbe>();

    public virtual VrstaProizvodum? VrstaProizvoda { get; set; }
}
