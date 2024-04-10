using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Services.Database;

namespace xFit.Services
{
	public class ProizvodiService : IProizvodiService
	{
		XFitContext _context;
		public ProizvodiService(XFitContext context)
		{
			_context = context;
		}
		List<Model.Proizvodi> proizvodis = new List<Model.Proizvodi>()
		{
			new Proizvodi()
			{
				ProizvodiId=1,
				Naziv="Oprema"
			}
		};
		public IList<Model.Proizvodi> Get()
		{
			var list = _context.Proizvods.ToList();
			return proizvodis;
		}
	}
}
