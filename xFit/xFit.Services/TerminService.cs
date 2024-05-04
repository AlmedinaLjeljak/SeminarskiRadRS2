using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using xFit.Model;
using xFit.Model.Requests;
using xFit.Model.SearchObjects;
using xFit.Services.Database;

namespace xFit.Services
{
	public class TerminService : BaseCRUDService<Model.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
	{
		public TerminService(XFitContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override Task<Model.Termin> Insert(TerminInsertRequest insert)
		{
			if (!insert.DatumVrijeme.HasValue)
			{
				throw new ArgumentException("Datum ne smije biti null.");
			}

			if (insert.DatumVrijeme.Value.Minute != 0)
			{
				throw new ArgumentException("Minute moraju biti 0.");
			}

			if (insert.DatumVrijeme.Value.Hour < 8 || insert.DatumVrijeme.Value.Hour > 20)
			{
				throw new ArgumentException("Sati moraju biti između 8 i 20.");
			}

			DateTime currentDate = DateTime.Now.Date;
			if (insert.DatumVrijeme.Value.Date <= currentDate)
			{
				throw new ArgumentException("Ne možete zakazati termin za trenutni dan ili dane unazad.");
			}

			return base.Insert(insert);
		}
	}
}
