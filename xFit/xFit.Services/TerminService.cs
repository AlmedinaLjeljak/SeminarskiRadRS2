﻿using AutoMapper;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class TerminService : BaseCRUDService<Model.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
	{
		private readonly IHttpContextAccessor _httpContextAccessor;

		public TerminService(XFitContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor)
			: base(context, mapper)
		{
			_httpContextAccessor = httpContextAccessor;
		}

		public override IQueryable<Database.Termin> AddFilter(IQueryable<Database.Termin> query, TerminSearchObject? search = null)
		{
			var filteredQuery = base.AddFilter(query, search);

			if (search.Uposlenik != null)
			{
				filteredQuery = filteredQuery.Where(x => x.KorisnikIdUposlenikNavigate.KorisnickoIme.StartsWith(search.Uposlenik.ToString()));
			}
			if (search.Klijent != null)
			{
				filteredQuery = filteredQuery.Where(x => x.KorisnikIdKlijentNavigate.KorisnickoIme.StartsWith(search.Klijent.ToString()));
			}
			if (search.Datum != null)
			{
				filteredQuery = filteredQuery.Where(x => x.Datum.Value.Day == search.Datum.Value.Day &&
														x.Datum.Value.Month == search.Datum.Value.Month &&
														x.Datum.Value.Year == search.Datum.Value.Year);
			}
			return filteredQuery;
		}
		/*
		
		public override Task<Model.Termin> Insert(TerminInsertRequest insert)
		{
			if (!insert.Datum.HasValue)
			{
				throw new ArgumentException("Datum ne smije biti null.");
			}

			if (insert.Datum.Value.Minute != 0)
			{
				throw new ArgumentException("Minute moraju biti 0.");
			}

			if (insert.Datum.Value.Hour < 8 || insert.Datum.Value.Hour > 20)
			{
				throw new ArgumentException("Sati moraju biti između 8 i 20.");
			}

			DateTime currentDate = DateTime.Now.Date;
			if (insert.Datum.Value.Date <= currentDate)
			{
				throw new ArgumentException("Ne možete zakazati termin za trenutni dan.");
			}

			return base.Insert(insert);
		}*/
	}
		


}
