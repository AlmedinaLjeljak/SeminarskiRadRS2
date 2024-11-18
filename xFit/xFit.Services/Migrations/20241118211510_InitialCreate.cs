using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace xFit.Services.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradID);
                });

            migrationBuilder.CreateTable(
                name: "Spol",
                columns: table => new
                {
                    SpolID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nchar(10)", fixedLength: true, maxLength: 10, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Spol", x => x.SpolID);
                });

            migrationBuilder.CreateTable(
                name: "Termin",
                columns: table => new
                {
                    TerminID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumVrijeme = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Termin", x => x.TerminID);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaID);
                });

            migrationBuilder.CreateTable(
                name: "VrstaProizvoda",
                columns: table => new
                {
                    VrstaProizvodaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrstaProizvoda", x => x.VrstaProizvodaID);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    Prezime = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nchar(10)", fixedLength: true, maxLength: 10, nullable: true),
                    GradID = table.Column<int>(type: "int", nullable: false),
                    SpolID = table.Column<int>(type: "int", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Grad",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "GradID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Korisnik_Spol",
                        column: x => x.SpolID,
                        principalTable: "Spol",
                        principalColumn: "SpolID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Proizvod",
                columns: table => new
                {
                    ProizvodID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    Sifra = table.Column<string>(type: "nchar(10)", fixedLength: true, maxLength: 10, nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    Slika = table.Column<byte[]>(type: "image", nullable: true),
                    VrstaProizvodaID = table.Column<int>(type: "int", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Proizvod", x => x.ProizvodID);
                    table.ForeignKey(
                        name: "FK_Proizvod_VrstaProizvoda",
                        column: x => x.VrstaProizvodaID,
                        principalTable: "VrstaProizvoda",
                        principalColumn: "VrstaProizvodaID");
                });

            migrationBuilder.CreateTable(
                name: "Klijent",
                columns: table => new
                {
                    KlijentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    Prezime = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Klijent", x => x.KlijentID);
                    table.ForeignKey(
                        name: "FK_Klijent_Korisnik",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloga",
                columns: table => new
                {
                    KorisnikUlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: true),
                    UlogaID = table.Column<int>(type: "int", nullable: true),
                    DatumIzmjene = table.Column<DateTime>(type: "date", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloga", x => x.KorisnikUlogaID);
                    table.ForeignKey(
                        name: "FK_KorisnikUloga_Korisnik",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_KorisnikUloga_Uloga",
                        column: x => x.UlogaID,
                        principalTable: "Uloga",
                        principalColumn: "UlogaID");
                });

            migrationBuilder.CreateTable(
                name: "Narudzba",
                columns: table => new
                {
                    NarudzbaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojNarudzbe = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Datum = table.Column<DateTime>(type: "date", nullable: true),
                    Status = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Iznos = table.Column<double>(type: "float", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Narudzba", x => x.NarudzbaID);
                    table.ForeignKey(
                        name: "FK_Narudzba_Korisnik",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "Uposlenik",
                columns: table => new
                {
                    UposlenikID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uposlenik", x => x.UposlenikID);
                    table.ForeignKey(
                        name: "FK_Uposlenik_Korisnik",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                });

            migrationBuilder.CreateTable(
                name: "Novost",
                columns: table => new
                {
                    NovostID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Sadzaj = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    DatumObjave = table.Column<DateTime>(type: "date", nullable: true),
                    KlijentID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Novost", x => x.NovostID);
                    table.ForeignKey(
                        name: "FK_Novost_Klijent",
                        column: x => x.KlijentID,
                        principalTable: "Klijent",
                        principalColumn: "KlijentID");
                });

            migrationBuilder.CreateTable(
                name: "OmiljeniProizvod",
                columns: table => new
                {
                    OmiljeniProizvodID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumDodavanja = table.Column<DateTime>(type: "date", nullable: true),
                    ProizvodID = table.Column<int>(type: "int", nullable: true),
                    KlijentID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OmiljeniProizvod", x => x.OmiljeniProizvodID);
                    table.ForeignKey(
                        name: "FK_OmiljeniProizvod_Klijent",
                        column: x => x.KlijentID,
                        principalTable: "Klijent",
                        principalColumn: "KlijentID");
                    table.ForeignKey(
                        name: "FK_OmiljeniProizvod_Proizvod",
                        column: x => x.ProizvodID,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodID");
                });

            migrationBuilder.CreateTable(
                name: "Recenzija",
                columns: table => new
                {
                    RecenzijaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Sadrzaj = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Datum = table.Column<DateTime>(type: "date", nullable: true),
                    ProizvodID = table.Column<int>(type: "int", nullable: true),
                    KlijentID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recenzija", x => x.RecenzijaID);
                    table.ForeignKey(
                        name: "FK_Recenzija_Klijent",
                        column: x => x.KlijentID,
                        principalTable: "Klijent",
                        principalColumn: "KlijentID");
                    table.ForeignKey(
                        name: "FK_Recenzija_Proizvod",
                        column: x => x.ProizvodID,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodID");
                });

            migrationBuilder.CreateTable(
                name: "StavkaNarudzbe",
                columns: table => new
                {
                    StavkaNarudzbeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: true),
                    NarudzbaID = table.Column<int>(type: "int", nullable: true),
                    ProizvodID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StavkaNarudzbe", x => x.StavkaNarudzbeID);
                    table.ForeignKey(
                        name: "FK_StavkaNarudzbe_Narudzba",
                        column: x => x.NarudzbaID,
                        principalTable: "Narudzba",
                        principalColumn: "NarudzbaID");
                    table.ForeignKey(
                        name: "FK_StavkaNarudzbe_Proizvod",
                        column: x => x.ProizvodID,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodID");
                });

            migrationBuilder.CreateTable(
                name: "Transakcija",
                columns: table => new
                {
                    TransakcijaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Iznos = table.Column<double>(type: "float", nullable: true),
                    NarudzbaID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transakcija", x => x.TransakcijaID);
                    table.ForeignKey(
                        name: "FK_Transakcija_Narudzba",
                        column: x => x.NarudzbaID,
                        principalTable: "Narudzba",
                        principalColumn: "NarudzbaID");
                });

            migrationBuilder.CreateTable(
                name: "Rezervacija",
                columns: table => new
                {
                    RezervacijaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "date", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    UposlenikID = table.Column<int>(type: "int", nullable: true),
                    KlijentID = table.Column<int>(type: "int", nullable: true),
                    TerminID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezervacija", x => x.RezervacijaID);
                    table.ForeignKey(
                        name: "FK_Rezervacija_Klijent",
                        column: x => x.KlijentID,
                        principalTable: "Klijent",
                        principalColumn: "KlijentID");
                    table.ForeignKey(
                        name: "FK_Rezervacija_Termin",
                        column: x => x.TerminID,
                        principalTable: "Termin",
                        principalColumn: "TerminID");
                    table.ForeignKey(
                        name: "FK_Rezervacija_Uposlenik",
                        column: x => x.UposlenikID,
                        principalTable: "Uposlenik",
                        principalColumn: "UposlenikID");
                });

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "GradID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Mostar" },
                    { 2, "Sarajevo" },
                    { 3, "Beograd" }
                });

            migrationBuilder.InsertData(
                table: "Spol",
                columns: new[] { "SpolID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Male" },
                    { 2, "Female" }
                });

            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminID", "DatumVrijeme" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4885) });

            migrationBuilder.InsertData(
                table: "Transakcija",
                columns: new[] { "TransakcijaID", "Iznos", "NarudzbaID" },
                values: new object[] { 1, 50.0, null });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaID", "Naziv" },
                values: new object[,]
                {
                    { 1, "uposlenik" },
                    { 2, "klijent" }
                });

            migrationBuilder.InsertData(
                table: "VrstaProizvoda",
                columns: new[] { "VrstaProizvodaID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Suplementi" },
                    { 2, "Oprema" }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikID", "DatumRodjenja", "GradID", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "SpolID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 11, 15, 10, 0, 0, 0, DateTimeKind.Unspecified), 1, "korisnik", "desktop", "zQrh4zsUE+z35ztss7lj7YMOW6w=", "ZsCgm8wyDPs7RIqUszVNwg==", "korisnik", 1 },
                    { 2, new DateTime(2024, 11, 15, 10, 0, 0, 0, DateTimeKind.Unspecified), 2, "novi", "mobile", "tXvOHjvV9skoEdo/IB+EJ5f/rrk=", "8rp4QQCjoi/gQ+0RKgKuWQ==", "korisnik", 2 }
                });

            migrationBuilder.InsertData(
                table: "Proizvod",
                columns: new[] { "ProizvodID", "Cijena", "Naziv", "Sifra", "Slika", "StateMachine", "VrstaProizvodaID" },
                values: new object[,]
                {
                    { 1, 20m, "Rukavice", "TR585", null, "active", 2 },
                    { 2, 30m, "Whey", "PL789", null, "active", 1 },
                    { 3, 20m, "Trake", "RF147", null, "active", 2 },
                    { 4, 50m, "Kreatin", "CD741", null, "active", 1 },
                    { 5, 100m, "Sobni bicikl", "TM741", null, "active", 2 },
                    { 6, 50m, "Traka za trcanje", "WE179", null, "active", 2 },
                    { 7, 50m, "Steperi", "CD741", null, "active", 1 },
                    { 8, 10m, "Girje", "RE789", null, "draft", 2 },
                    { 9, 50m, "Plocasti utezi", "QW736", null, "active", 2 },
                    { 10, 20m, "Podloga za vjezbanje", "QP459", null, "active", 2 }
                });

            migrationBuilder.InsertData(
                table: "Klijent",
                columns: new[] { "KlijentID", "DatumRodjenja", "Ime", "KorisnikID", "Prezime" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4750), "Klijent", 1, "Klijent" });

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaID", "DatumIzmjene", "KorisnikID", "UlogaID" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4813), 1, 1 });

            migrationBuilder.InsertData(
                table: "Narudzba",
                columns: new[] { "NarudzbaID", "BrojNarudzbe", "Datum", "Iznos", "KorisnikID", "Status" },
                values: new object[,]
                {
                    { 1, "#1", new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4923), 17.0, 1, "Pending" },
                    { 2, "#2", new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4927), 20.0, 2, "Pending" }
                });

            migrationBuilder.InsertData(
                table: "Uposlenik",
                columns: new[] { "UposlenikID", "DatumRodjenja", "Ime", "KorisnikID", "Prezime" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4828), "uposlenik", 1, "uposlenik" });

            migrationBuilder.InsertData(
                table: "Novost",
                columns: new[] { "NovostID", "DatumObjave", "KlijentID", "Naziv", "Sadzaj" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4898), 1, "Novost", "Sadrzaj novost" });

            migrationBuilder.InsertData(
                table: "OmiljeniProizvod",
                columns: new[] { "OmiljeniProizvodID", "DatumDodavanja", "KlijentID", "ProizvodID" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4908), 1, 1 });

            migrationBuilder.InsertData(
                table: "Recenzija",
                columns: new[] { "RecenzijaID", "Datum", "KlijentID", "ProizvodID", "Sadrzaj" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4871), 1, 1, "sadrzaj" });

            migrationBuilder.InsertData(
                table: "Rezervacija",
                columns: new[] { "RezervacijaID", "Datum", "Email", "KlijentID", "TerminID", "UposlenikID" },
                values: new object[] { 1, new DateTime(2024, 11, 18, 22, 15, 10, 640, DateTimeKind.Local).AddTicks(4961), "rezervacija@gmail.com", 1, 1, 1 });

            migrationBuilder.InsertData(
                table: "StavkaNarudzbe",
                columns: new[] { "StavkaNarudzbeID", "Kolicina", "NarudzbaID", "ProizvodID" },
                values: new object[,]
                {
                    { 1, 1, 1, 1 },
                    { 2, 1, 1, 3 },
                    { 3, 1, 1, 4 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Klijent_KorisnikID",
                table: "Klijent",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_GradID",
                table: "Korisnik",
                column: "GradID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_SpolID",
                table: "Korisnik",
                column: "SpolID");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_KorisnikID",
                table: "KorisnikUloga",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_UlogaID",
                table: "KorisnikUloga",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_KorisnikID",
                table: "Narudzba",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Novost_KlijentID",
                table: "Novost",
                column: "KlijentID");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniProizvod_KlijentID",
                table: "OmiljeniProizvod",
                column: "KlijentID");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniProizvod_ProizvodID",
                table: "OmiljeniProizvod",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_Proizvod_VrstaProizvodaID",
                table: "Proizvod",
                column: "VrstaProizvodaID");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_KlijentID",
                table: "Recenzija",
                column: "KlijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzija_ProizvodID",
                table: "Recenzija",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_KlijentID",
                table: "Rezervacija",
                column: "KlijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_TerminID",
                table: "Rezervacija",
                column: "TerminID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_UposlenikID",
                table: "Rezervacija",
                column: "UposlenikID");

            migrationBuilder.CreateIndex(
                name: "IX_StavkaNarudzbe_NarudzbaID",
                table: "StavkaNarudzbe",
                column: "NarudzbaID");

            migrationBuilder.CreateIndex(
                name: "IX_StavkaNarudzbe_ProizvodID",
                table: "StavkaNarudzbe",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_Transakcija_NarudzbaID",
                table: "Transakcija",
                column: "NarudzbaID");

            migrationBuilder.CreateIndex(
                name: "IX_Uposlenik_KorisnikID",
                table: "Uposlenik",
                column: "KorisnikID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.DropTable(
                name: "Novost");

            migrationBuilder.DropTable(
                name: "OmiljeniProizvod");

            migrationBuilder.DropTable(
                name: "Recenzija");

            migrationBuilder.DropTable(
                name: "Rezervacija");

            migrationBuilder.DropTable(
                name: "StavkaNarudzbe");

            migrationBuilder.DropTable(
                name: "Transakcija");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Klijent");

            migrationBuilder.DropTable(
                name: "Termin");

            migrationBuilder.DropTable(
                name: "Uposlenik");

            migrationBuilder.DropTable(
                name: "Proizvod");

            migrationBuilder.DropTable(
                name: "Narudzba");

            migrationBuilder.DropTable(
                name: "VrstaProizvoda");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Spol");
        }
    }
}
