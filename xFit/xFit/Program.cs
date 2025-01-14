/*using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using xFit;
using xFit.Filters;
using xFit.Model.SearchObjects;
using xFit.Services;
using xFit.Services.Database;
using xFit.Services.ProizvodStateMachine;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IProizvodService, ProizvodService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IService<xFit.Model.VrstaProizvodum,BaseSearchObject>, BaseSevice<xFit.Model.VrstaProizvodum, xFit.Services.Database.VrstaProizvodum,BaseSearchObject>>();
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

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();

builder.Services.AddControllers(x=>
{
	x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c=>
{
	c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
	{
		Type=Microsoft.OpenApi.Models.SecuritySchemeType.Http,
		Scheme="basic"
	});
	c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
	{
		{
			new OpenApiSecurityScheme
			{
				Reference=new OpenApiReference{Type=ReferenceType.SecurityScheme,Id="basicAuth"}
			},
			new string[]{}
		}

	});
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<XFitContext>(options =>
options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication")
	.AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication",null);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();
app.UseAuthentication();

app.MapControllers();

using(var scope=app.Services.CreateScope())
{
	var dataContext = scope.ServiceProvider.GetRequiredService<XFitContext>();
	//dataContext.Database.EnsureCreated();

	var conn = dataContext.Database.GetConnectionString();

	dataContext.Database.Migrate();
}

app.Run();
*/

using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using xFit;
using xFit.Filters;
using xFit.Model.SearchObjects;
using xFit.Services;
using xFit.Services.Database;
using xFit.Services.ProizvodStateMachine;

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
builder.Services.AddTransient<IRecommendResultService, RecommendResultService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();

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
		builder => builder.WithOrigins("http://localhost:3000") // URL aplikacije sa koje se šalju zahtevi
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
	if (!dataContext.Database.CanConnect())
	{
		dataContext.Database.Migrate();

		var recommendResutService = scope.ServiceProvider.GetRequiredService<IRecommendResultService>();
		try
		{
			await recommendResutService.TrainProductsModel();
		}
		catch (Exception e)
		{
		}
	}
}

app.Run();
