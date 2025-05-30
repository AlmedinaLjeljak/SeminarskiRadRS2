﻿using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Services
{
	public class MappingProfile:Profile
	{
		public MappingProfile()
		{
			CreateMap<Database.Korisnik, Model.Korisnik>();
			CreateMap<Model.Requests.KorisnikInsertRequest, Database.Korisnik>();
			CreateMap<Model.Requests.KorisnikUpdateRequest, Database.Korisnik>();

			CreateMap<Database.Proizvod, Model.Proizvod>();
			CreateMap<Model.Requests.PorizvodInsertRequest, Database.Proizvod>();
			CreateMap<Model.Requests.ProizvodUpdateRequest, Database.Proizvod>();

			CreateMap<Database.Termin, Model.Termin>();
			CreateMap<Model.Requests.TerminInsertRequest, Database.Termin>();
			CreateMap<Model.Requests.TerminUpdateRequest, Database.Termin>();

			CreateMap<Database.ClanskaKarta, Model.ClanskaKarta>();
			CreateMap<Model.Requests.ClanskaKartaInsertRequest, Database.ClanskaKarta>();
			CreateMap<Model.Requests.ClanskaKartaUpdateRequest, Database.ClanskaKarta>();

			CreateMap<Database.Narudzba, Model.Narudzba>();
			CreateMap<Model.Requests.NarudzbaInsertRequest, Database.Narudzba>();
			CreateMap<Model.Requests.NarudzbaUpdateRequest, Database.Narudzba>();

			CreateMap<Database.StavkaNarudzbe, Model.StavkaNarudzbe>();
			CreateMap<Model.Requests.StavkaNarudzbeInsertRequest, Database.StavkaNarudzbe>();
			CreateMap<Model.Requests.StavkaNarudzbeUpdateRequest, Database.StavkaNarudzbe>();

			CreateMap<Database.RecommendResult, Model.RecommendResult>();
			CreateMap<Model.Requests.RecommendResultUpsertRequest, Database.RecommendResult>();

			CreateMap<Database.Recenzija, Model.Recenzija>();
			CreateMap<Model.Requests.RecenzijaInsertRequest, Database.Recenzija>();
			CreateMap<Model.Requests.RecenzijaUpdateRequest, Database.Recenzija>();

			CreateMap<Database.Klijent, Model.Klijent>();
			CreateMap<Model.Requests.KlijentInsertRequest, Database.Klijent>();
			CreateMap<Model.Requests.KlijentUpdateRequest, Database.Klijent>();


			CreateMap<Database.Uposlenik, Model.Uposlenik>();
			CreateMap<Model.Requests.UposlenikInsertRequest, Database.Uposlenik>();
			CreateMap<Model.Requests.UposlenikUpdateRequest, Database.Uposlenik>();

			CreateMap<Database.Novost, Model.Novost>();
			CreateMap<Model.Requests.NovostUpsertRequest, Database.Novost>();

			CreateMap<Database.OmiljeniProizvod, Model.OmiljeniProizvod>();
			CreateMap<Model.Requests.OmiljeniProizvodUpsertRequest, Database.OmiljeniProizvod>();

			CreateMap<Database.Transakcija, Model.Transakcija>();
			CreateMap<Model.Requests.TransakcijaUpdateRequest, Database.Transakcija>();

			CreateMap<Database.Grad, Model.Grad>();
			CreateMap<Model.Requests.GradUpsertRequest, Database.Grad>();

			CreateMap<Database.VrstaProizvodum, Model.VrstaProizvodum>();
			CreateMap<Database.KorisnikUloga, Model.KorisnikUloga>();
			CreateMap<Database.Uloga, Model.Uloga>();
		}

	}
}
