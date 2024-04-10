using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using xFit.Model.Requests;
using xFit.Services.Database;

namespace xFit.Services
{
	public class KorisniciService : IKorisniciService
	{
		XFitContext _context;
		public IMapper _mapper { get; set; }
		
		public KorisniciService(XFitContext context,IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}
		public List<Model.Korisnik> Get()
		{
			var entityList = _context.Korisniks.ToList();

			/*var list = new List<Model.Korisnik>();
			foreach(var item in entityList)
			{
				list.Add(new Model.Korisnik()
				{
					KorisnikId=item.KorisnikId,
					Ime = item.Ime,
					Prezime=item.Prezime,
					KorisnickoIme=item.KorisnickoIme,
					DatumRodjenja=item.DatumRodjenja

				});
			}
			return list;*/
			return _mapper.Map<List<Model.Korisnik>>(entityList);
		}

		public Model.Korisnik Insert(KorisnikInsertRequest request)
		{
			var entity = new Korisnik();
			_mapper.Map(request, entity);

			entity.LozinkaSalt = GenerateSalt();
			entity.LozinkaHash = GenerateHash(entity.LozinkaHash, request.Password);

			_context.Korisniks.Add(entity);
			_context.SaveChanges();

			return _mapper.Map<Model.Korisnik>(entity);
			
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

		public Model.Korisnik Update(int id, KorisnikUpdateRequest request)
		{
			var entity = _context.Korisniks.Find(id);

			_mapper.Map(request, entity);

			_context.SaveChanges();
			return _mapper.Map<Model.Korisnik>(entity);
		}
	}
}
