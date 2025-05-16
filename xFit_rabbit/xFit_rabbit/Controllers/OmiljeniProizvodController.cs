using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Connections;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using xFit_rabbit.Data;
using xFit_rabbit.Services;
using Newtonsoft.Json;
using RabbitMQ.Client;


namespace xFit_rabbit.Controllers
{

	[Route("[controller]")]
	[ApiController]


	public class OmiljeniProizvodiController : ControllerBase
	{
		XFitContext _context;
		protected IMapper _mapper { get; set; }
		public IKorisniciService _korisniciService { get; set; }

		public OmiljeniProizvodiController(XFitContext context, IMapper mapper, IKorisniciService korisniciService)
		{
			_context = context;
			_mapper = mapper;
			_korisniciService = korisniciService;
		}

		[Authorize]
		[HttpPost]
		public async Task<IActionResult> Send(OmiljeniProizvodUpsertRequest favorite)
		{
			if (favorite == null)
				return BadRequest("Can't send null object");

			if (favorite.KorisnikId <= 0)
				return BadRequest("KorisnikId must be greater than 0");

			if (favorite.ProizvodId <= 0)
				return BadRequest("ProizvodId must be greater than 0");


			var factory = new ConnectionFactory
			{
				HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ"
			};
			using var connection = factory.CreateConnection();
			using var channel = connection.CreateModel();

			channel.QueueDeclare(queue: "favorites",
								 durable: false,
								 exclusive: false,
								 autoDelete: true,
								 arguments: null);


			var json = JsonConvert.SerializeObject(favorite);

			var body = Encoding.UTF8.GetBytes(json);

			Console.WriteLine($"Šaljem proizvod: {json}");

			channel.BasicPublish(exchange: string.Empty,
								 routingKey: "favorites",

								 body: body);

			return Ok(favorite);
		}

		[Authorize]
		[HttpGet("GetUser")]
		public async Task<IActionResult> GetUser(int userId)
		{
			var user = await _korisniciService.GetKorisnik(userId);

			return Ok(user);
		}

	}

}