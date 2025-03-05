using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using xFit_rabbit.Data;

namespace xFit.Services.Database;

public partial class XFitContext : DbContext
{
	public XFitContext()
	{
	}

	public XFitContext(DbContextOptions<XFitContext> options)
		: base(options)
	{
	}

	public virtual DbSet<Grad> Grads { get; set; }

	public virtual DbSet<Klijent> Klijents { get; set; }

	public virtual DbSet<Korisnik> Korisniks { get; set; }

	public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; }

	public virtual DbSet<Narudzba> Narudzbas { get; set; }

	public virtual DbSet<Novost> Novosts { get; set; }

	public virtual DbSet<OmiljeniProizvod> OmiljeniProizvods { get; set; }

	public virtual DbSet<Proizvod> Proizvods { get; set; }

	public virtual DbSet<Recenzija> Recenzijas { get; set; }

	public virtual DbSet<Rezervacija> Rezervacijas { get; set; }

	public virtual DbSet<Spol> Spols { get; set; }

	public virtual DbSet<StavkaNarudzbe> StavkaNarudzbes { get; set; }

	public virtual DbSet<Termin> Termins { get; set; }

	public virtual DbSet<Transakcija> Transakcijas { get; set; }

	public virtual DbSet<Uloga> Ulogas { get; set; }
	public virtual DbSet<RecommendResult> RecommendResults { get; set; }
	public virtual DbSet<Uposlenik> Uposleniks { get; set; }

	public virtual DbSet<VrstaProizvodum> VrstaProizvoda { get; set; }

	/* protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
   #warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
		   => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=xFit_190061; Trusted_Connection=True; TrustServerCertificate=True");

	 */
	protected override void OnModelCreating(ModelBuilder modelBuilder)
	{
		modelBuilder.Entity<Grad>(entity =>
		{
			entity.ToTable("Grad");

			entity.Property(e => e.GradId)
				.ValueGeneratedOnAdd()
				.HasColumnName("GradID");
			entity.Property(e => e.Naziv)
				.HasMaxLength(20)
				.IsFixedLength();
		});

		modelBuilder.Entity<Klijent>(entity =>
		{
			entity.ToTable("Klijent");

			entity.Property(e => e.KlijentId)
				.ValueGeneratedOnAdd()
				.HasColumnName("KlijentID");
			entity.Property(e => e.DatumRodjenja).HasColumnType("date");
			entity.Property(e => e.Ime)
				.HasMaxLength(20)
				.IsFixedLength();
			entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
			entity.Property(e => e.Prezime)
				.HasMaxLength(20)
				.IsFixedLength();

			entity.HasOne(d => d.Korisnik).WithMany(p => p.Klijents)
				.HasForeignKey(d => d.KorisnikId)
				.HasConstraintName("FK_Klijent_Korisnik");
		});

		modelBuilder.Entity<Korisnik>(entity =>
		{
			entity.ToTable("Korisnik");

			entity.Property(e => e.KorisnikId)
				.ValueGeneratedOnAdd()
				.HasColumnName("KorisnikID");
			entity.Property(e => e.DatumRodjenja).HasColumnType("date");
			entity.Property(e => e.GradId).HasColumnName("GradID");
			entity.Property(e => e.Ime)
				.HasMaxLength(20)
				.IsFixedLength();
			entity.Property(e => e.KorisnickoIme)
				.HasMaxLength(10)
				.IsFixedLength();
			entity.Property(e => e.Prezime)
				.HasMaxLength(20)
				.IsFixedLength();
			entity.Property(e => e.SpolId).HasColumnName("SpolID");

			entity.HasOne(d => d.Grad).WithMany(p => p.Korisniks)
				.HasForeignKey(d => d.GradId)
				.HasConstraintName("FK_Korisnik_Grad");

			entity.HasOne(d => d.Spol).WithMany(p => p.Korisniks)
				.HasForeignKey(d => d.SpolId)
				.HasConstraintName("FK_Korisnik_Spol");
		});

		modelBuilder.Entity<KorisnikUloga>(entity =>
		{
			entity.ToTable("KorisnikUloga");

			entity.Property(e => e.KorisnikUlogaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("KorisnikUlogaID");
			entity.Property(e => e.DatumIzmjene).HasColumnType("date");
			entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
			entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

			entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
				.HasForeignKey(d => d.KorisnikId)
				.HasConstraintName("FK_KorisnikUloga_Korisnik");

			entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
				.HasForeignKey(d => d.UlogaId)
				.HasConstraintName("FK_KorisnikUloga_Uloga");
		});

		modelBuilder.Entity<Narudzba>(entity =>
		{
			entity.ToTable("Narudzba");

			entity.Property(e => e.NarudzbaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("NarudzbaID");
			entity.Property(e => e.BrojNarudzbe).HasMaxLength(50);
			entity.Property(e => e.Datum).HasColumnType("date");
			entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
			entity.Property(e => e.Status).HasMaxLength(20);

			entity.HasOne(d => d.Korisnik).WithMany(p => p.Narudzbas)
				.HasForeignKey(d => d.KorisnikId)
				.HasConstraintName("FK_Narudzba_Korisnik");
		});

		modelBuilder.Entity<Novost>(entity =>
		{
			entity.ToTable("Novost");

			entity.Property(e => e.NovostId)
				.ValueGeneratedOnAdd()
				.HasColumnName("NovostID");
			entity.Property(e => e.DatumObjave).HasColumnType("date");
			entity.Property(e => e.KlijentId).HasColumnName("KlijentID");
			entity.Property(e => e.Naziv).HasMaxLength(50);
			entity.Property(e => e.Sadzaj).HasMaxLength(50);

			entity.HasOne(d => d.Klijent).WithMany(p => p.Novosts)
				.HasForeignKey(d => d.KlijentId)
				.HasConstraintName("FK_Novost_Klijent");
		});

		modelBuilder.Entity<OmiljeniProizvod>(entity =>
		{
			entity.ToTable("OmiljeniProizvod");

			entity.Property(e => e.OmiljeniProizvodId)
				.ValueGeneratedOnAdd()
				.HasColumnName("OmiljeniProizvodID");
			entity.Property(e => e.DatumDodavanja).HasColumnType("date");
			entity.Property(e => e.KlijentId).HasColumnName("KlijentID");
			entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");

			entity.HasOne(d => d.Klijent).WithMany(p => p.OmiljeniProizvods)
				.HasForeignKey(d => d.KlijentId)
				.HasConstraintName("FK_OmiljeniProizvod_Klijent");

			entity.HasOne(d => d.Proizvod).WithMany(p => p.OmiljeniProizvods)
				.HasForeignKey(d => d.ProizvodId)
				.HasConstraintName("FK_OmiljeniProizvod_Proizvod");
		});

		modelBuilder.Entity<Proizvod>(entity =>
		{
			entity.ToTable("Proizvod");

			entity.Property(e => e.ProizvodId)
				.ValueGeneratedOnAdd()
				.HasColumnName("ProizvodID");
			entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
			entity.Property(e => e.Naziv)
				.HasMaxLength(20)
				.IsFixedLength();
			entity.Property(e => e.Sifra)
				.HasMaxLength(10)
				.IsFixedLength();
			entity.Property(e => e.Slika).HasColumnType("image");
			entity.Property(e => e.VrstaProizvodaId).HasColumnName("VrstaProizvodaID");

			entity.HasOne(d => d.VrstaProizvoda).WithMany(p => p.Proizvods)
				.HasForeignKey(d => d.VrstaProizvodaId)
				.HasConstraintName("FK_Proizvod_VrstaProizvoda");
		});

		modelBuilder.Entity<Recenzija>(entity =>
		{
			entity.ToTable("Recenzija");

			entity.Property(e => e.RecenzijaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("RecenzijaID");
			entity.Property(e => e.Datum).HasColumnType("date");
			entity.Property(e => e.KlijentId).HasColumnName("KlijentID");
			entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");
			entity.Property(e => e.Sadrzaj).HasMaxLength(50);

			entity.HasOne(d => d.Klijent).WithMany(p => p.Recenzijas)
				.HasForeignKey(d => d.KlijentId)
				.HasConstraintName("FK_Recenzija_Klijent");

			entity.HasOne(d => d.Proizvod).WithMany(p => p.Recenzijas)
				.HasForeignKey(d => d.ProizvodId)
				.HasConstraintName("FK_Recenzija_Proizvod");
		});

		modelBuilder.Entity<Rezervacija>(entity =>
		{
			entity.ToTable("Rezervacija");

			entity.Property(e => e.RezervacijaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("RezervacijaID");
			entity.Property(e => e.Datum).HasColumnType("date");
			entity.Property(e => e.Email).HasMaxLength(50);
			entity.Property(e => e.KlijentId).HasColumnName("KlijentID");
			entity.Property(e => e.TerminId).HasColumnName("TerminID");
			entity.Property(e => e.UposlenikId).HasColumnName("UposlenikID");

			entity.HasOne(d => d.Klijent).WithMany(p => p.Rezervacijas)
				.HasForeignKey(d => d.KlijentId)
				.HasConstraintName("FK_Rezervacija_Klijent");

			entity.HasOne(d => d.Termin).WithMany(p => p.Rezervacijas)
				.HasForeignKey(d => d.TerminId)
				.HasConstraintName("FK_Rezervacija_Termin");

			entity.HasOne(d => d.Uposlenik).WithMany(p => p.Rezervacijas)
				.HasForeignKey(d => d.UposlenikId)
				.HasConstraintName("FK_Rezervacija_Uposlenik");
		});

		modelBuilder.Entity<Spol>(entity =>
		{
			entity.ToTable("Spol");

			entity.Property(e => e.SpolId)
				.ValueGeneratedOnAdd()
				.HasColumnName("SpolID");
			entity.Property(e => e.Naziv)
				.HasMaxLength(10)
				.IsFixedLength();
		});

		modelBuilder.Entity<StavkaNarudzbe>(entity =>
		{
			entity.ToTable("StavkaNarudzbe");

			entity.Property(e => e.StavkaNarudzbeId)
				.ValueGeneratedOnAdd()
				.HasColumnName("StavkaNarudzbeID");
			entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");
			entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");

			entity.HasOne(d => d.Narudzba).WithMany(p => p.StavkaNarudzbes)
				.HasForeignKey(d => d.NarudzbaId)
				.HasConstraintName("FK_StavkaNarudzbe_Narudzba");

			entity.HasOne(d => d.Proizvod).WithMany(p => p.StavkaNarudzbes)
				.HasForeignKey(d => d.ProizvodId)
				.HasConstraintName("FK_StavkaNarudzbe_Proizvod");
		});

		modelBuilder.Entity<Termin>(entity =>
		{
			entity.ToTable("Termin");

			entity.Property(e => e.TerminId)
				.ValueGeneratedOnAdd()
				.HasColumnName("TerminID");
			entity.Property(e => e.DatumVrijeme).HasColumnType("datetime");
		});

		modelBuilder.Entity<Transakcija>(entity =>
		{
			entity.ToTable("Transakcija");

			entity.Property(e => e.TransakcijaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("TransakcijaID");
			entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");

			entity.HasOne(d => d.Narudzba).WithMany(p => p.Transakcijas)
				.HasForeignKey(d => d.NarudzbaId)
				.HasConstraintName("FK_Transakcija_Narudzba");
		});

		modelBuilder.Entity<Uloga>(entity =>
		{
			entity.ToTable("Uloga");

			entity.Property(e => e.UlogaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("UlogaID");
			entity.Property(e => e.Naziv)
				.HasMaxLength(20)
				.IsFixedLength();
		});

		modelBuilder.Entity<Uposlenik>(entity =>
		{
			entity.ToTable("Uposlenik");

			entity.Property(e => e.UposlenikId)
				.ValueGeneratedOnAdd()
				.HasColumnName("UposlenikID");
			entity.Property(e => e.DatumRodjenja).HasColumnType("date");
			entity.Property(e => e.Ime).HasMaxLength(50);
			entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
			entity.Property(e => e.Prezime).HasMaxLength(50);

			entity.HasOne(d => d.Korisnik).WithMany(p => p.Uposleniks)
				.HasForeignKey(d => d.KorisnikId)
				.HasConstraintName("FK_Uposlenik_Korisnik");
		});

		modelBuilder.Entity<VrstaProizvodum>(entity =>
		{
			entity.HasKey(e => e.VrstaProizvodaId);

			entity.Property(e => e.VrstaProizvodaId)
				.ValueGeneratedOnAdd()
				.HasColumnName("VrstaProizvodaID");
			entity.Property(e => e.Naziv)
				.HasMaxLength(20)
				.IsFixedLength();
		});

		OnModelCreatingPartial(modelBuilder);
	}

	partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
