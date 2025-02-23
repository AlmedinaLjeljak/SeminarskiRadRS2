using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace xFit_rabbit.Data;

public partial class XFit190061Context : DbContext
{
    public XFit190061Context()
    {
    }

    public XFit190061Context(DbContextOptions<XFit190061Context> options)
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

    public virtual DbSet<RecommendResult> RecommendResults { get; set; }

    public virtual DbSet<Rezervacija> Rezervacijas { get; set; }

    public virtual DbSet<Spol> Spols { get; set; }

    public virtual DbSet<StavkaNarudzbe> StavkaNarudzbes { get; set; }

    public virtual DbSet<Termin> Termins { get; set; }

    public virtual DbSet<Transakcija> Transakcijas { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

    public virtual DbSet<Uposlenik> Uposleniks { get; set; }

    public virtual DbSet<VrstaProizvodum> VrstaProizvoda { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=localhost;Database=xFit_190061;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");

            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Naziv).HasMaxLength(255);
        });

        modelBuilder.Entity<Klijent>(entity =>
        {
            entity.ToTable("Klijent");

            entity.HasIndex(e => e.KorisnikId, "IX_Klijent_KorisnikID");

            entity.Property(e => e.KlijentId).HasColumnName("KlijentID");
            entity.Property(e => e.DatumRodjenja).HasColumnType("date");
            entity.Property(e => e.Ime).HasMaxLength(255);
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.Prezime).HasMaxLength(255);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Klijents)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Klijent_Korisnik");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.GradId, "IX_Korisnik_GradID");

            entity.HasIndex(e => e.SpolId, "IX_Korisnik_SpolID");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.DatumRodjenja).HasColumnType("date");
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Ime).HasMaxLength(255);
            entity.Property(e => e.KorisnickoIme).HasMaxLength(255);
            entity.Property(e => e.Prezime).HasMaxLength(255);
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

            entity.HasIndex(e => e.KorisnikId, "IX_KorisnikUloga_KorisnikID");

            entity.HasIndex(e => e.UlogaId, "IX_KorisnikUloga_UlogaID");

            entity.Property(e => e.KorisnikUlogaId).HasColumnName("KorisnikUlogaID");
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

            entity.HasIndex(e => e.KorisnikId, "IX_Narudzba_KorisnikID");

            entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");
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

            entity.HasIndex(e => e.KlijentId, "IX_Novost_KlijentID");

            entity.Property(e => e.NovostId).HasColumnName("NovostID");
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

            entity.HasIndex(e => e.KlijentId, "IX_OmiljeniProizvod_KlijentID");

            entity.HasIndex(e => e.ProizvodId, "IX_OmiljeniProizvod_ProizvodID");

            entity.Property(e => e.OmiljeniProizvodId).HasColumnName("OmiljeniProizvodID");
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

            entity.HasIndex(e => e.VrstaProizvodaId, "IX_Proizvod_VrstaProizvodaID");

            entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");
            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Naziv).HasMaxLength(255);
            entity.Property(e => e.Sifra).HasMaxLength(255);
            entity.Property(e => e.Slika).HasColumnType("image");
            entity.Property(e => e.VrstaProizvodaId).HasColumnName("VrstaProizvodaID");

            entity.HasOne(d => d.VrstaProizvoda).WithMany(p => p.Proizvods)
                .HasForeignKey(d => d.VrstaProizvodaId)
                .HasConstraintName("FK_Proizvod_VrstaProizvoda");
        });

        modelBuilder.Entity<Recenzija>(entity =>
        {
            entity.ToTable("Recenzija");

            entity.HasIndex(e => e.KlijentId, "IX_Recenzija_KlijentID");

            entity.HasIndex(e => e.ProizvodId, "IX_Recenzija_ProizvodID");

            entity.Property(e => e.RecenzijaId).HasColumnName("RecenzijaID");
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

            entity.HasIndex(e => e.KlijentId, "IX_Rezervacija_KlijentID");

            entity.HasIndex(e => e.TerminId, "IX_Rezervacija_TerminID");

            entity.HasIndex(e => e.UposlenikId, "IX_Rezervacija_UposlenikID");

            entity.Property(e => e.RezervacijaId).HasColumnName("RezervacijaID");
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

            entity.Property(e => e.SpolId).HasColumnName("SpolID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(10)
                .IsFixedLength();
        });

        modelBuilder.Entity<StavkaNarudzbe>(entity =>
        {
            entity.ToTable("StavkaNarudzbe");

            entity.HasIndex(e => e.NarudzbaId, "IX_StavkaNarudzbe_NarudzbaID");

            entity.HasIndex(e => e.ProizvodId, "IX_StavkaNarudzbe_ProizvodID");

            entity.Property(e => e.StavkaNarudzbeId).HasColumnName("StavkaNarudzbeID");
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

            entity.HasIndex(e => e.KlijentId, "IX_Termin_KlijentId");

            entity.HasIndex(e => e.UposlenikId, "IX_Termin_UposlenikId");

            entity.Property(e => e.TerminId).HasColumnName("TerminID");
            entity.Property(e => e.DatumVrijeme).HasColumnType("datetime");

            entity.HasOne(d => d.Klijent).WithMany(p => p.Termins).HasForeignKey(d => d.KlijentId);

            entity.HasOne(d => d.Uposlenik).WithMany(p => p.Termins).HasForeignKey(d => d.UposlenikId);
        });

        modelBuilder.Entity<Transakcija>(entity =>
        {
            entity.ToTable("Transakcija");

            entity.HasIndex(e => e.NarudzbaId, "IX_Transakcija_NarudzbaID");

            entity.Property(e => e.TransakcijaId).HasColumnName("TransakcijaID");
            entity.Property(e => e.NarudzbaId).HasColumnName("NarudzbaID");

            entity.HasOne(d => d.Narudzba).WithMany(p => p.Transakcijas)
                .HasForeignKey(d => d.NarudzbaId)
                .HasConstraintName("FK_Transakcija_Narudzba");
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.ToTable("Uloga");

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");
            entity.Property(e => e.Naziv).HasMaxLength(255);
        });

        modelBuilder.Entity<Uposlenik>(entity =>
        {
            entity.ToTable("Uposlenik");

            entity.HasIndex(e => e.KorisnikId, "IX_Uposlenik_KorisnikID");

            entity.Property(e => e.UposlenikId).HasColumnName("UposlenikID");
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

            entity.Property(e => e.VrstaProizvodaId).HasColumnName("VrstaProizvodaID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(20)
                .IsFixedLength();
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
