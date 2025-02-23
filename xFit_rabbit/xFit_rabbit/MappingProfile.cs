using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;



namespace xFit_rabbit.Services
{
	public class MappingProfile:Profile
	{
		public MappingProfile()
		{
			CreateMap<Data.Korisnik, Models.Korisnik>();
			CreateMap<Data.KorisnikUloga, Models.KorisnikUloga>();
			CreateMap<Data.Uloga, Models.Uloga>();
		}
	}
}
