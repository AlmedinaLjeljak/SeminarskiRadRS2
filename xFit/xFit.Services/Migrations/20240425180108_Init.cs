using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace xFit.Services.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradID = table.Column<int>(type: "int", nullable: false),
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
                    SpolID = table.Column<int>(type: "int", nullable: false),
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
                    TerminID = table.Column<int>(type: "int", nullable: false),
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
                    UlogaID = table.Column<int>(type: "int", nullable: false),
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
                    VrstaProizvodaID = table.Column<int>(type: "int", nullable: false),
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
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
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
                    ProizvodID = table.Column<int>(type: "int", nullable: false),
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
                    KlijentID = table.Column<int>(type: "int", nullable: false),
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
                    KorisnikUlogaID = table.Column<int>(type: "int", nullable: false),
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
                    NarudzbaID = table.Column<int>(type: "int", nullable: false),
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
                    UposlenikID = table.Column<int>(type: "int", nullable: false),
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
                    NovostID = table.Column<int>(type: "int", nullable: false),
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
                    OmiljeniProizvodID = table.Column<int>(type: "int", nullable: false),
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
                    RecenzijaID = table.Column<int>(type: "int", nullable: false),
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
                    StavkaNarudzbeID = table.Column<int>(type: "int", nullable: false),
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
                    TransakcijaID = table.Column<int>(type: "int", nullable: false),
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
                    RezervacijaID = table.Column<int>(type: "int", nullable: false),
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
