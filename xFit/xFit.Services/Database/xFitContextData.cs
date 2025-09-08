using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xFit.Services.Database
{
	public partial class XFitContext
	{
		partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Spol>().HasData(
				new Spol()
				{
					SpolId = 1,
					Naziv = "Male"
				},
				new Spol()
				{
					SpolId = 2,
					Naziv = "Female"
				}
				);
			modelBuilder.Entity<Grad>().HasData(
				new Grad()
				{
					GradId = 1,
					Naziv = "Mostar"
				},
				new Grad()
				{
					GradId = 2,
					Naziv = "Sarajevo"
				},
				new Grad()
				{
					GradId = 3,
					Naziv = "Beograd"
				}
				);
			modelBuilder.Entity<VrstaProizvodum>().HasData(
				new VrstaProizvodum()
				{
					VrstaProizvodaId = 1,
					Naziv = "Suplementi"
				},
				new VrstaProizvodum()
				{
					VrstaProizvodaId = 2,
					Naziv = "Oprema"
				}
				);
			modelBuilder.Entity<Korisnik>().HasData(
				new Korisnik()
				{
					KorisnikId = 1,
					Ime = "korisnik",
					Prezime = "korisnik",
					DatumRodjenja = new DateTime(2024, 11, 15, 10, 0, 0),
					Email = "korisnik@gmail.com",
					Telefon="061234567",
					Adresa="test",
					KorisnickoIme = "desktop",
					GradId = 1,
					SpolId = 1,
					LozinkaHash = "zQrh4zsUE+z35ztss7lj7YMOW6w=",
					LozinkaSalt = "ZsCgm8wyDPs7RIqUszVNwg=="
				},
				new Korisnik()
				{
					KorisnikId = 2,
					Ime = "novi",
					Prezime = "korisnik",
					DatumRodjenja = new DateTime(2024, 11, 15, 10, 0, 0),
					Email="novikorisnik@gmail.com",
					Telefon="061234567",
					Adresa="Testiranje",
					KorisnickoIme = "mobile",
					GradId = 2,
					SpolId = 2,
					LozinkaHash = "tXvOHjvV9skoEdo/IB+EJ5f/rrk=",
					LozinkaSalt = "8rp4QQCjoi/gQ+0RKgKuWQ=="
				}

				) ;
			modelBuilder.Entity<Klijent>().HasData(
				new Klijent()
				{
					KlijentId = 1,
					Ime = "Klijent",
					Prezime = "Klijent",
					DatumRodjenja = DateTime.Now,
					KorisnikId = 2
				}

				);
			modelBuilder.Entity<Uloga>().HasData(
				new Uloga()
				{
					UlogaId = 1,
					Naziv = "uposlenik"
				},
				new Uloga()
				{
					UlogaId = 2,
					Naziv = "klijent"
				}
				);
			modelBuilder.Entity<KorisnikUloga>().HasData(
				new KorisnikUloga()
				{
					KorisnikUlogaId = 1,
					KorisnikId = 1,
					UlogaId = 1,
					DatumIzmjene = DateTime.Now

				},
				new KorisnikUloga()
					{
						KorisnikUlogaId = 2,
						KorisnikId = 2,
						UlogaId = 2,
						DatumIzmjene = DateTime.Now

					}
				);
			modelBuilder.Entity<Uposlenik>().HasData(
				new Uposlenik()
				{
					UposlenikId = 1,
					Ime = "uposlenik",
					Prezime = "uposlenik",
					DatumRodjenja = DateTime.Now,
					KorisnikId = 1
				}
				);
			modelBuilder.Entity<Proizvod>().HasData(
				new Proizvod()
				{
					ProizvodId = 1,
					Naziv = "Rukavice",
					Sifra = "TR585",
					Cijena = 20,
					Slika=ConvertImageToByteArray("wwwroot/images","image2.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 2,
					Naziv = "Whey",
					Sifra = "PL789",
					Cijena = 30,
					Slika = ConvertImageToByteArray("wwwroot/images", "image1.jpg"),
					VrstaProizvodaId = 1,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 3,
					Naziv = "Trake",
					Sifra = "RF147",
					Cijena = 20,
					Slika = ConvertImageToByteArray("wwwroot/images", "image3.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 4,
					Naziv = "Kreatin",
					Sifra = "CD741",
					Cijena = 50,
					Slika = ConvertImageToByteArray("wwwroot/images", "image4.jpg"),
					VrstaProizvodaId = 1,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 5,
					Naziv = "Sobni bicikl",
					Sifra = "TM741",
					Cijena = 100,
					Slika = ConvertImageToByteArray("wwwroot/images", "image5.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 6,
					Naziv = "Traka za trcanje",
					Sifra = "WE179",
					Cijena = 50,
					Slika = ConvertImageToByteArray("wwwroot/images", "image6.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 7,
					Naziv = "Steperi",
					Sifra = "CD741",
					Cijena = 50,
					Slika = ConvertImageToByteArray("wwwroot/images", "image7.jpg"),
					VrstaProizvodaId = 1,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 8,
					Naziv = "Girje",
					Sifra = "RE789",
					Cijena = 10,
					Slika = ConvertImageToByteArray("wwwroot/images", "image8.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 9,
					Naziv = "Plocasti utezi",
					Sifra = "QW736",
					Cijena = 50,
					Slika = ConvertImageToByteArray("wwwroot/images", "image9.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				},
				new Proizvod()
				{
					ProizvodId = 10,
					Naziv = "Podloga za vjezbanje",
					Sifra = "QP459",
					Cijena = 20,
					Slika = ConvertImageToByteArray("wwwroot/images", "image10.jpg"),
					VrstaProizvodaId = 2,
					StateMachine = "draft"
				}
				);
			modelBuilder.Entity<Recenzija>().HasData(
				new Recenzija()
				{
					RecenzijaId = 1,
					Sadrzaj = "sadrzaj",
					Datum = DateTime.Now,
					ProizvodId = 1,
					KorisnikId = 1
				}
				);
			modelBuilder.Entity<Termin>().HasData(
				new Termin()
				{
					TerminId = 1,
					Datum = DateTime.Now,
					KorisnikIdUposlenik=1,
					KorisnikIdKlijent=1
				}
				);
			modelBuilder.Entity<ClanskaKarta>().HasData(
			new ClanskaKarta()
			{
				ClanskaKArtaId = 1,
				Sadrzaj = "Test sadrzaj",
				KorisnikId = 2
			}
		);
			modelBuilder.Entity<Novost>().HasData(
				new Novost()
				{
					NovostId = 1,
					Naziv = "Novost",
					Sadzaj = "Sadrzaj novost",
					DatumObjave = DateTime.Now,
					KorisnikId = 1
				}
				);
			modelBuilder.Entity<OmiljeniProizvod>().HasData(
				new OmiljeniProizvod()
				{
					OmiljeniProizvodId = 1,
					DatumDodavanja = DateTime.Now,
					ProizvodId = 1,
					KlijentId = 1
				}

				);
			modelBuilder.Entity<Narudzba>().HasData(
				new Narudzba()
				{
					NarudzbaId = 1,
					BrojNarudzbe = "#1",
					Datum = DateTime.Now,
					Status = "Pending",
					Iznos = 17,
					KorisnikId = 1
				},
				new Narudzba()
				{
					NarudzbaId = 2,
					BrojNarudzbe = "#2",
					Datum = DateTime.Now,
					Status = "Pending",
					Iznos = 20,
					KorisnikId = 2
				}
				);
			modelBuilder.Entity<StavkaNarudzbe>().HasData(
				new StavkaNarudzbe()
				{
					StavkaNarudzbeId = 1,
					Kolicina = 1,
					NarudzbaId = 1,
					ProizvodId = 1,
				},
				new StavkaNarudzbe()
				{
					StavkaNarudzbeId = 2,
					Kolicina = 1,
					NarudzbaId = 1,
					ProizvodId = 3,
				},
				new StavkaNarudzbe()
				{
					StavkaNarudzbeId = 3,
					Kolicina = 1,
					NarudzbaId = 1,
					ProizvodId = 4,
				}
				);
			modelBuilder.Entity<Transakcija>().HasData(
				new Transakcija()
				{
					TransakcijaId = 1,
					Iznos = 50,
					NarudzbaId=1
				}
			);
			modelBuilder.Entity<Rezervacija>().HasData(
				new Rezervacija()
				{
					RezervacijaId = 1,
					Datum = DateTime.Now,
					Email = "rezervacija@gmail.com",
					UposlenikId = 1,
					KlijentId = 1,
					TerminId = 1
				}
				);


		}
		private byte[] ConvertImageToByteArray(string folderPath, string fileName)
		{
		
			string projectDirectory = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).FullName, "xFit");
			string fullPath = Path.Combine(projectDirectory, folderPath, fileName);

			Console.WriteLine(fullPath); 
			if (!File.Exists(fullPath))
				throw new FileNotFoundException($"File {fileName} not found in {fullPath}");

			return File.ReadAllBytes(fullPath);
		}





	}
}