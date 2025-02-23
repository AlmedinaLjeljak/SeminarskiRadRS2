using System;
using System.Collections.Generic;

namespace xFit_rabbit.Data;

public partial class RecommendResult
{
    public int Id { get; set; }

    public int? ProizvodId { get; set; }

    public int? PrviProizvodId { get; set; }

    public int? DrugiProizvodId { get; set; }

    public int? TreciProizvodId { get; set; }
}
