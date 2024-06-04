using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class GradService : BaseCRUDService<Model.Grad, Database.Grad, BaseSearchObject, GradUpsertRequest, GradUpsertRequest>, IGradService
	{
		public GradService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public async Task<List<Model.Grad>> AddFilter(string name)
		{
			if (string.IsNullOrWhiteSpace(name))
			{
				return new List<Model.Grad>();
			}

			var query = _context.Grads.AsQueryable();

			if (!string.IsNullOrEmpty(name))
			{
				query = query.Where(g => g.Naziv.Contains(name));
			}

			var entities = await query.ToListAsync();
			return _mapper.Map<List<Model.Grad>>(entities);
		}
	}
}
