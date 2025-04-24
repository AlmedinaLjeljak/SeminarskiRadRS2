using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using Microsoft.AspNetCore.Http;
using xFit.Services.Database;

namespace xFit.Services
{
	public class NovostService:BaseCRUDService<Model.Novost,Database.Novost,NovostSearchObject,NovostUpsertRequest,NovostUpsertRequest>,INovostService
	{
		private readonly IHttpContextAccessor _httpContextAccessor;

		public NovostService(XFitContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor)
			: base(context, mapper)
		{
			_httpContextAccessor = httpContextAccessor;
		}

		public override IQueryable<Database.Novost> AddFilter(IQueryable<Database.Novost> query, NovostSearchObject search = null)
		{
			var filteredQuery = base.AddFilter(query, search);

			if (!string.IsNullOrWhiteSpace(search?.Naziv))
			{
				filteredQuery = filteredQuery.Where(x => x.Naziv.StartsWith(search.Naziv));
			}
			return filteredQuery;
		}
		public override async Task BeforeInsert(Database.Novost entity, NovostUpsertRequest insert)
		{
	
			if (string.IsNullOrWhiteSpace(insert.Naziv))
			{
				throw new ArgumentException("Naziv novosti je obavezan i ne može biti prazan.");
			}

			var loggedInUser = _httpContextAccessor.HttpContext.User;

			if (loggedInUser.Identity.IsAuthenticated)
			{
				string username = loggedInUser.Identity.Name;

				var user = await _context.Korisniks.FirstOrDefaultAsync(x => x.KorisnickoIme == username);

				if (user != null)
				{
					entity.KorisnikId = user.KorisnikId;
				}
			}
		}

		public override async Task BeforeUpdate(Database.Novost entity, NovostUpsertRequest update)
		{
		
			if (string.IsNullOrWhiteSpace(update.Naziv))
			{
				throw new ArgumentException("Naziv novosti je obavezan i ne može biti prazan.");
			}

			var loggedInUser = _httpContextAccessor.HttpContext.User;

			if (loggedInUser.Identity.IsAuthenticated)
			{
				string username = loggedInUser.Identity.Name;

				var user = await _context.Korisniks.FirstOrDefaultAsync(x => x.KorisnickoIme == username);
				if (user != null)
				{
					entity.KorisnikId = user.KorisnikId;
				}
			}
		}


	}
}
