using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Services
{
     public interface IService<T>
	{
		Task<List<T>> Get();
	}
}
