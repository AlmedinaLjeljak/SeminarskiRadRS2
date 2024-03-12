using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;

namespace xFit.Services
{
	public class ProizvodiService : IProizvodiService
	{
		List<Proizvodi> proizvodis = new List<Proizvodi>()
		{
			new Proizvodi()
			{
				ProizvodiId=1,
				Naziv="Oprema"
			}
		};
		public IList<Proizvodi> Get()
		{
			return proizvodis;
		}
	}
}
