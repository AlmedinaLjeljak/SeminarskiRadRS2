﻿using AutoMapper;
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
	public class NarudzbaService : BaseCRUDService<Model.Narudzba, Database.Narudzba, NarudzbeSearchObject, NarudzbaInsertRequest, NarudzbaUpdateRequest>, INarudzbaService
	{
		public NarudzbaService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override async Task BeforeInsert(Database.Narudzba entity, NarudzbaInsertRequest insert)
		{
			double? _iznos = 0;
			foreach (var item in insert.Items)
			{
				var _artikal = _context.Proizvods.Where(x => x.ProizvodId == item.ProizvodId).FirstOrDefault();
				var x = _artikal.Cijena * item.Kolicina;
				double? y = (double?)x;
				_iznos += y;
			}
			entity.KorisnikId = insert.KorisnikId;
			entity.Datum = DateTime.Now;
			entity.BrojNarudzbe = "#" + (_context.Narudzbas.Count() + 1).ToString();
			entity.Iznos = _iznos;
			entity.Status = "Pending";
			entity.StavkaNarudzbes = insert.Items.Select(item => new Database.StavkaNarudzbe
			{
				Kolicina = item.Kolicina,
				ProizvodId = item.ProizvodId,
			}).ToList();
		}
		public override IQueryable<Database.Narudzba> AddFilter(IQueryable<Database.Narudzba> query, NarudzbeSearchObject? search = null)
		{
			if (search?.KorisnikId != 0)
			{
				query = query.Where(x => x.KorisnikId == search.KorisnikId);
			}

			return base.AddFilter(query, search);
		}

		public override async Task<Model.Narudzba> Update(int id, NarudzbaUpdateRequest update)
		{
			var entity = await _context.Narudzbas.FindAsync(id);

			if (!IsValidStatusTransition(entity.Status, update.Status))
			{
				throw new UserException("Invalid status transition");
			}
			else
			{
				return await base.Update(id, update);
			}

		}

		private bool IsValidStatusTransition(string? currentStatus, string? newStatus)
		{
			if (currentStatus == newStatus)
			{
				return true;
			}

			switch (currentStatus)
			{
				case "Pending":
					return newStatus == "Completed" || newStatus == "Cancelled";
				case "Cancelled":
					return newStatus == "Pending";
				default:
					throw new UserException("Invalid status transition");
			}
		}
	}
}
