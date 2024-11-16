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
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4845) });

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
                    { 1, new DateTime(2024, 11, 15, 10, 0, 0, 0, DateTimeKind.Unspecified), 1, "Uposlenik", "uposlenik", "c0d9c1bf6597d1f8246212f7d4efdc5a5a6b2c394d6fa0ea9c8ff634a1d2bcd2", "3a5c7f12ab8d6e09c2f4a0b7d3e9f6a1", "Uposlenik", 1 },
                    { 2, new DateTime(2024, 11, 15, 10, 0, 0, 0, DateTimeKind.Unspecified), 2, "Klijent", "klijent", "c0d9c1bf6597d1f8246212f7d4efdc5a5a6b2c394d6fa0ea9c8ff634a1d2bcd2", "3a5c7f12ab8d6e09c2f4a0b7d3e9f6a1", "Klijent", 2 }
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
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4719), "Klijent", 1, "Klijent" });

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaID", "DatumIzmjene", "KorisnikID", "UlogaID" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4777), 1, 1 });

            migrationBuilder.InsertData(
                table: "Narudzba",
                columns: new[] { "NarudzbaID", "BrojNarudzbe", "Datum", "Iznos", "KorisnikID", "Status" },
                values: new object[,]
                {
                    { 1, "#1", new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4886), 17.0, 1, "Pending" },
                    { 2, "#2", new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4889), 20.0, 2, "Pending" }
                });

            migrationBuilder.InsertData(
                table: "Uposlenik",
                columns: new[] { "UposlenikID", "DatumRodjenja", "Ime", "KorisnikID", "Prezime" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4791), "uposlenik", 1, "uposlenik" });

            migrationBuilder.InsertData(
                table: "Novost",
                columns: new[] { "NovostID", "DatumObjave", "KlijentID", "Naziv", "Sadzaj" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4860), 1, "Novost", "Sadrzaj novost" });

            migrationBuilder.InsertData(
                table: "OmiljeniProizvod",
                columns: new[] { "OmiljeniProizvodID", "DatumDodavanja", "KlijentID", "ProizvodID" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4874), 1, 1 });

            migrationBuilder.InsertData(
                table: "Recenzija",
                columns: new[] { "RecenzijaID", "Datum", "KlijentID", "ProizvodID", "Sadrzaj" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4833), 1, 1, "sadrzaj" });

            migrationBuilder.InsertData(
                table: "Rezervacija",
                columns: new[] { "RezervacijaID", "Datum", "Email", "KlijentID", "TerminID", "UposlenikID" },
                values: new object[] { 1, new DateTime(2024, 11, 14, 21, 39, 31, 706, DateTimeKind.Local).AddTicks(4920), "rezervacija@gmail.com", 1, 1, 1 });

            migrationBuilder.InsertData(
                table: "StavkaNarudzbe",
                columns: new[] { "StavkaNarudzbeID", "Kolicina", "NarudzbaID", "ProizvodID" },
                values: new object[,]
                {
                    { 1, 1, 1, 1 },
                    { 2, 1, 1, 3 },
                    { 3, 1, 1, 4 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "GradID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Narudzba",
                keyColumn: "NarudzbaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Novost",
                keyColumn: "NovostID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "OmiljeniProizvod",
                keyColumn: "OmiljeniProizvodID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Recenzija",
                keyColumn: "RecenzijaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "StavkaNarudzbe",
                keyColumn: "StavkaNarudzbeID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "StavkaNarudzbe",
                keyColumn: "StavkaNarudzbeID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "StavkaNarudzbe",
                keyColumn: "StavkaNarudzbeID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Transakcija",
                keyColumn: "TransakcijaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uloga",
                keyColumn: "UlogaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Klijent",
                keyColumn: "KlijentID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Narudzba",
                keyColumn: "NarudzbaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Proizvod",
                keyColumn: "ProizvodID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uloga",
                keyColumn: "UlogaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uposlenik",
                keyColumn: "UposlenikID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "GradID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Spol",
                keyColumn: "SpolID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "VrstaProizvoda",
                keyColumn: "VrstaProizvodaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "VrstaProizvoda",
                keyColumn: "VrstaProizvodaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "GradID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Spol",
                keyColumn: "SpolID",
                keyValue: 1);
        }
    }
}
