using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;

namespace xFit.Services
{
	public interface IProizvodiService
	{
		IList<Proizvodi> Get();
	}
}
