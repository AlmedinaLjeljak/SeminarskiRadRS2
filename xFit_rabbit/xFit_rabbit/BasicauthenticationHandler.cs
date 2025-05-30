﻿using Azure.Core;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text;
using xFit_rabbit.Services;

namespace xFit_rabbit
{
	public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
	{
		protected readonly IKorisniciService _korisniciService;
		public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock, IKorisniciService korisniciService)
			: base(options, logger, encoder, clock)
		{
			_korisniciService = korisniciService;
		}

		protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
		{
			if (!Request.Headers.ContainsKey("Authorization"))
			{
				return AuthenticateResult.Fail("Missing header");
			}

			Models.Korisnik? korisnik = null;
			try
			{
				var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
				var credentialsBytes = Convert.FromBase64String(authHeader.Parameter);
				var credentials = Encoding.UTF8.GetString(credentialsBytes).Split(':');

				var username = credentials[0];
				var password = credentials[1];

				korisnik = await _korisniciService.Login(username, password);
			}
			catch
			{
				return AuthenticateResult.Fail("Incorrect username or password");
			}

			if (korisnik == null)
			{
				return AuthenticateResult.Fail("Incorrect username or password");
			}

			else
			{

				var claims = new List<Claim>()
				{
					new Claim(ClaimTypes.Name,korisnik.Ime),
					new Claim(ClaimTypes.NameIdentifier,korisnik.KorisnickoIme)
				};

				foreach (var role in korisnik.KorisnikUlogas)
				{
					claims.Add(new Claim(ClaimTypes.Role, role.Uloga.Naziv));
				}

				var identity = new ClaimsIdentity(claims, Scheme.Name);
				var principal = new ClaimsPrincipal(identity);

				var ticket = new AuthenticationTicket(principal, Scheme.Name);
				return AuthenticateResult.Success(ticket);
			}
		}
	}
}