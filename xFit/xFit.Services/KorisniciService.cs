﻿using AutoMapper;
using Azure.Core;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class KorisniciService : BaseCRUDService<Model.Korisnik, Database.Korisnik, KorisnikSearchObject,KorisnikInsertRequest,KorisnikUpdateRequest>, IKorisniciService
	{


		public KorisniciService(XFitContext context, IMapper mapper)
			: base(context, mapper)
		{

		}
		public override Task<Model.Korisnik> Delete(int id)
		{
			return base.Delete(id);
		}

		public override async Task BeforeInsert(Korisnik entity, KorisnikInsertRequest insert)
		{
			entity.LozinkaSalt = GenerateSalt();
			entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);
		}
		public static string GenerateSalt()
		{
			RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
			var byteArray = new byte[16];
			provider.GetBytes(byteArray);


			return Convert.ToBase64String(byteArray);
		}
		public static string GenerateHash(string salt, string password)
		{
			byte[] src = Convert.FromBase64String(salt);
			byte[] bytes = Encoding.Unicode.GetBytes(password);
			byte[] dst = new byte[src.Length + bytes.Length];

			System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
			System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

			HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
			byte[] inArray = algorithm.ComputeHash(dst);
			return Convert.ToBase64String(inArray);
		}

		

		public override IQueryable<Korisnik> AddInclude(IQueryable<Korisnik>query,KorisnikSearchObject? search=null)
		{
			if(search?.isUlogeIncluded==true)
			{
				query = query.Include(x=>x.KorisnikUlogas);
			}
			return base.AddInclude(query, search);
		}

		public async Task<Model.Korisnik> Login(string username, string password)
		{
			var entitiy = await _context.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);
			
			
			if(entitiy==null)
			{
				return null;
			}
			var hash = GenerateHash(entitiy.LozinkaSalt, password);
			if (hash!=entitiy.LozinkaHash)
			{
				return null;
			}
			return _mapper.Map<Model.Korisnik>(entitiy);
		}


		public override async Task<Model.Korisnik> Update(int id, KorisnikUpdateRequest update)
		{
			var entity = await _context.Korisniks.FindAsync(id);
			return await base.Update(id, update);
		}
	}
}
