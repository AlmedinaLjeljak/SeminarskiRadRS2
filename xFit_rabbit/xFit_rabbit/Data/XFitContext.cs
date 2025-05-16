using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace xFit_rabbit.Data;

public partial class XFitContext : DbContext
{
    public XFitContext()
    {
    }

    public XFitContext(DbContextOptions<XFitContext> options)
        : base(options)
    {
    }

    public virtual DbSet<ClanskaKarta> ClanskaKartas { get; set; }

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
        modelBuilder.Entity<ClanskaKarta>(entity =>
        {
            entity.HasIndex(e => e.KorisnikId, "IX_ClanskaKartas_KorisnikId");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.ClanskaKarta).HasForeignKey(d => d.KorisnikId);
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");
        });

        modelBuilder.Entity<Klijent>(entity =>
        {
            entity.ToTable("Klijent");

            entity.HasIndex(e => e.KorisnikID, "IX_Klijent_KorisnikID");

            entity.Property(e => e.DatumRodjenja).HasColumnType("date");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Klijents)
                .HasForeignKey(d => d.KorisnikID)
                .HasConstraintName("FK_Klijent_Korisnik");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.GradID, "IX_Korisnik_GradID");

            entity.HasIndex(e => e.SpolID, "IX_Korisnik_SpolID");

            entity.Property(e => e.DatumRodjenja).HasColumnType("date");

            entity.HasOne(d => d.Grad).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.GradID)
                .HasConstraintName("FK_Korisnik_Grad");

            entity.HasOne(d => d.Spol).WithMany(p => p.Korisniks)
                .HasForeignKey(d => d.SpolID)
                .HasConstraintName("FK_Korisnik_Spol");
        });

        modelBuilder.Entity<KorisnikUloga>(entity =>
        {
            entity.ToTable("KorisnikUloga");

            entity.HasIndex(e => e.KorisnikID, "IX_KorisnikUloga_KorisnikID");

            entity.HasIndex(e => e.UlogaID, "IX_KorisnikUloga_UlogaID");

            entity.Property(e => e.DatumIzmjene).HasColumnType("date");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.KorisnikID)
                .HasConstraintName("FK_KorisnikUloga_Korisnik");

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.UlogaID)
                .HasConstraintName("FK_KorisnikUloga_Uloga");
        });

        modelBuilder.Entity<Narudzba>(entity =>
        {
            entity.ToTable("Narudzba");

            entity.HasIndex(e => e.KorisnikID, "IX_Narudzba_KorisnikID");

            entity.Property(e => e.Datum).HasColumnType("date");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Narudzbas)
                .HasForeignKey(d => d.KorisnikID)
                .HasConstraintName("FK_Narudzba_Korisnik");
        });

        modelBuilder.Entity<Novost>(entity =>
        {
            entity.ToTable("Novost");

            entity.HasIndex(e => e.KlijentId, "IX_Novost_KlijentId");

            entity.HasIndex(e => e.KorisnikId, "IX_Novost_KorisnikId");

            entity.Property(e => e.DatumObjave).HasColumnType("date");

            entity.HasOne(d => d.Klijent).WithMany(p => p.Novosts).HasForeignKey(d => d.KlijentId);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Novosts)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Novost_Korisnik");
        });

        modelBuilder.Entity<OmiljeniProizvod>(entity =>
        {
            entity.ToTable("OmiljeniProizvod");

            entity.HasIndex(e => e.KlijentID, "IX_OmiljeniProizvod_KlijentID");

            entity.HasIndex(e => e.KorisnikId, "IX_OmiljeniProizvod_KorisnikId");

            entity.HasIndex(e => e.ProizvodID, "IX_OmiljeniProizvod_ProizvodID");

            entity.Property(e => e.DatumDodavanja).HasColumnType("date");

            entity.HasOne(d => d.Klijent).WithMany(p => p.OmiljeniProizvods)
                .HasForeignKey(d => d.KlijentID)
                .HasConstraintName("FK_OmiljeniProizvod_Klijent");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.OmiljeniProizvods).HasForeignKey(d => d.KorisnikId);

            entity.HasOne(d => d.Proizvod).WithMany(p => p.OmiljeniProizvods)
                .HasForeignKey(d => d.ProizvodID)
                .HasConstraintName("FK_OmiljeniProizvod_Proizvod");
        });

        modelBuilder.Entity<Proizvod>(entity =>
        {
            entity.ToTable("Proizvod");

            entity.HasIndex(e => e.VrstaProizvodaID, "IX_Proizvod_VrstaProizvodaID");

            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Slika).HasColumnType("image");

            entity.HasOne(d => d.VrstaProizvoda).WithMany(p => p.Proizvods)
                .HasForeignKey(d => d.VrstaProizvodaID)
                .HasConstraintName("FK_Proizvod_VrstaProizvoda");
        });

        modelBuilder.Entity<Recenzija>(entity =>
        {
            entity.ToTable("Recenzija");

            entity.HasIndex(e => e.KlijentId, "IX_Recenzija_KlijentId");

            entity.HasIndex(e => e.KorisnikId, "IX_Recenzija_KorisnikId");

            entity.HasIndex(e => e.ProizvodID, "IX_Recenzija_ProizvodID");

            entity.Property(e => e.Datum).HasColumnType("date");

            entity.HasOne(d => d.Klijent).WithMany(p => p.Recenzijas).HasForeignKey(d => d.KlijentId);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Recenzijas)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Recenzija_Korisnik");

            entity.HasOne(d => d.Proizvod).WithMany(p => p.Recenzijas)
                .HasForeignKey(d => d.ProizvodID)
                .HasConstraintName("FK_Recenzija_Proizvod");
        });

        modelBuilder.Entity<Rezervacija>(entity =>
        {
            entity.ToTable("Rezervacija");

            entity.HasIndex(e => e.KlijentID, "IX_Rezervacija_KlijentID");

            entity.HasIndex(e => e.TerminID, "IX_Rezervacija_TerminID");

            entity.HasIndex(e => e.UposlenikID, "IX_Rezervacija_UposlenikID");

            entity.Property(e => e.Datum).HasColumnType("date");

            entity.HasOne(d => d.Klijent).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.KlijentID)
                .HasConstraintName("FK_Rezervacija_Klijent");

            entity.HasOne(d => d.Termin).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.TerminID)
                .HasConstraintName("FK_Rezervacija_Termin");

            entity.HasOne(d => d.Uposlenik).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.UposlenikID)
                .HasConstraintName("FK_Rezervacija_Uposlenik");
        });

        modelBuilder.Entity<Spol>(entity =>
        {
            entity.ToTable("Spol");
        });

        modelBuilder.Entity<StavkaNarudzbe>(entity =>
        {
            entity.ToTable("StavkaNarudzbe");

            entity.HasIndex(e => e.NarudzbaID, "IX_StavkaNarudzbe_NarudzbaID");

            entity.HasIndex(e => e.ProizvodID, "IX_StavkaNarudzbe_ProizvodID");

            entity.HasOne(d => d.Narudzba).WithMany(p => p.StavkaNarudzbes)
                .HasForeignKey(d => d.NarudzbaID)
                .HasConstraintName("FK_StavkaNarudzbe_Narudzba");

            entity.HasOne(d => d.Proizvod).WithMany(p => p.StavkaNarudzbes)
                .HasForeignKey(d => d.ProizvodID)
                .HasConstraintName("FK_StavkaNarudzbe_Proizvod");
        });

        modelBuilder.Entity<Termin>(entity =>
        {
            entity.ToTable("Termin");

            entity.HasIndex(e => e.KorisnikIdKlijent, "IX_Termin_KorisnikIdKlijent");

            entity.HasIndex(e => e.KorisnikIdUposlenik, "IX_Termin_KorisnikIdUposlenik");

            entity.Property(e => e.Datum).HasColumnType("datetime");

            entity.HasOne(d => d.KorisnikIdKlijentNavigation).WithMany(p => p.TerminKorisnikIdKlijentNavigations).HasForeignKey(d => d.KorisnikIdKlijent);

            entity.HasOne(d => d.KorisnikIdUposlenikNavigation).WithMany(p => p.TerminKorisnikIdUposlenikNavigations).HasForeignKey(d => d.KorisnikIdUposlenik);
        });

        modelBuilder.Entity<Transakcija>(entity =>
        {
            entity.ToTable("Transakcija");

            entity.HasIndex(e => e.NarudzbaID, "IX_Transakcija_NarudzbaID");

            entity.HasOne(d => d.Narudzba).WithMany(p => p.Transakcijas)
                .HasForeignKey(d => d.NarudzbaID)
                .HasConstraintName("FK_Transakcija_Narudzba");
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.ToTable("Uloga");
        });

        modelBuilder.Entity<Uposlenik>(entity =>
        {
            entity.ToTable("Uposlenik");

            entity.HasIndex(e => e.KorisnikID, "IX_Uposlenik_KorisnikID");

            entity.Property(e => e.DatumRodjenja).HasColumnType("date");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Uposleniks)
                .HasForeignKey(d => d.KorisnikID)
                .HasConstraintName("FK_Uposlenik_Korisnik");
        });

        modelBuilder.Entity<VrstaProizvodum>(entity =>
        {
            entity.HasKey(e => e.VrstaProizvodaID);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
