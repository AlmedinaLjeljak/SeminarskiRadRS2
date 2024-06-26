﻿using AutoMapper;
using Azure.Core;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Services.Database;

namespace xFit.Services.ProizvodStateMachine
{
	public class DraftProductState : BaseState
	{
		protected ILogger<DraftProductState> _logger;
		public DraftProductState(ILogger<DraftProductState>logger,IServiceProvider serviceProvider,Database.XFitContext context, IMapper mapper) : base(serviceProvider,context, mapper)
		{
			_logger = logger;
		}

		public override async Task<Model.Proizvod> Update(int id, ProizvodUpdateRequest request)
		{
			var set = _context.Set<Database.Proizvod>();

			var entity = await set.FindAsync(id);
			_mapper.Map(request, entity);

			if(entity.Cijena < 0)
			{
				throw new Exception("Cijena ne moze biti u minusu");
			}
			if (entity.Cijena < 1)
			{
				throw new UserException("Cijena ispod minimuma");
			}

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Proizvod>(entity);
		


		}

		public override async Task<Model.Proizvod> Activate(int id)
		{
			_logger.LogInformation($"Aktivacija proizvoda: {id}");

			_logger.LogWarning($"W: Aktivacija proizvoda: {id}");
			
			_logger.LogError($"E: Aktivacija proizvoda: {id}");

			var set = _context.Set<Database.Proizvod>();

			var entity = await set.FindAsync(id);

			entity.StateMachine = "active";

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Proizvod>(entity);


		}
		public override async Task<List<string>> AllowedActions()
		{
			var list = await base.AllowedActions();

			list.Add("Update");
			list.Add("Activate");

			return list;
		}
	}
}
