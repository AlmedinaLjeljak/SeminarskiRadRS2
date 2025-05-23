using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using RabbitMQ.Client.Events;
using xFit;
using xFit.Filters;
using xFit.Model.SearchObjects;
using xFit.Services;
using xFit.Services.Database;
using xFit.Services.ProizvodStateMachine;
using System.Text;
using System.Text.Json;
using xFit.Model.Requests;
using RabbitMQ.Client;
using RabbitMQ.Client.Exceptions;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IProizvodService, ProizvodService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IService<xFit.Model.VrstaProizvodum, BaseSearchObject>, BaseSevice<xFit.Model.VrstaProizvodum, xFit.Services.Database.VrstaProizvodum, BaseSearchObject>>();
builder.Services.AddTransient<INarudzbaService, NarudzbaService>();
builder.Services.AddTransient<ITerminService, TerminService>();

builder.Services.AddTransient<ITransakcijaService, TransakcijaService>();
builder.Services.AddTransient<IStavkaNarudzbeService, StavkaNarudzbeService>();
builder.Services.AddTransient<IGradService, GradService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();
builder.Services.AddTransient<INovostService, NovostService>();
builder.Services.AddTransient<IKlijentService, KlijentService>();
builder.Services.AddTransient<IUposlenikService, UposlenikService>();
builder.Services.AddTransient<IOmiljeniProizvodService, OmiljeniProizvodService>();
builder.Services.AddTransient<IClanskaKartaService, ClanskaKartaService>();
builder.Services.AddTransient<IRecommendResultService, RecommendResultService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();


builder.Services.AddHttpContextAccessor();

builder.Services.AddControllers(x =>
{
	x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
	c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme()
	{
		Type = SecuritySchemeType.Http,
		Scheme = "basic"
	});
	c.AddSecurityRequirement(new OpenApiSecurityRequirement()
	{
		{
			new OpenApiSecurityScheme
			{
				Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
			},
			new string[] { }
		}
	});
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<XFitContext>(options =>
	options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication")
	.AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

// Add CORS services
builder.Services.AddCors(options =>
{
	options.AddPolicy("AllowSpecificOrigin",
		builder => builder.WithOrigins("http://localhost:3000") // URL aplikacije sa koje se �alju zahtevi
						  .AllowAnyHeader()
						  .AllowAnyMethod());
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors("AllowSpecificOrigin"); // Add this line for CORS

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
	var dataContext = scope.ServiceProvider.GetRequiredService<XFitContext>();

	var databaseExist = dataContext.Database.GetService<IRelationalDatabaseCreator>().Exists();

	if (!databaseExist)
	{
		dataContext.Database.Migrate();

		var recommendResutService = scope.ServiceProvider.GetRequiredService<IRecommendResultService>();
		try
		{
			recommendResutService.TrainProductsModel();
		}
		catch (Exception e)
		{
		}
	}
}

string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ";
string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";



var factory = new ConnectionFactory
{
	// HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ"

	HostName = hostname,
	UserName = username,
	Password = password,
	VirtualHost = virtualHost,
};
using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "favorites",
					 durable: false,
					 exclusive: false,
					 autoDelete: true,
					 arguments: null);

Console.WriteLine(" [*] Waiting for messages.");

var consumer = new EventingBasicConsumer(channel);
consumer.Received += async (model, ea) =>
{
	var body = ea.Body.ToArray();
	var message = Encoding.UTF8.GetString(body);
	Console.WriteLine(message.ToString());
	var omiljeni = JsonSerializer.Deserialize<OmiljeniProizvodUpsertRequest>(message);
	using (var scope = app.Services.CreateScope())
	{
		var omiljeniProizvodiService = scope.ServiceProvider.GetRequiredService<IOmiljeniProizvodService>();

		if (omiljeni != null)
		{
			try
			{
				await omiljeniProizvodiService.Insert(omiljeni);
			}
			catch (Exception e)
			{

			}
		}
	}
	// Console.WriteLine();
	Console.WriteLine(Environment.GetEnvironmentVariable("Some"));
	Console.WriteLine("USAO U GLAVNI U PROGRAM CS PROSAO INSERT PROIZVODA");
};
channel.BasicConsume(queue: "favorites",
					 autoAck: true,
					 consumer: consumer);


//////////////////////////////////////////////////////////////////////////////////
///


app.Run();
