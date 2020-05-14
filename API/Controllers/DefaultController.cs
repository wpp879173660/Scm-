using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MODEL;
using DAL;

namespace API.Controllers
{
    [RoutePrefix("api/Default")]
    public class DefaultController : ApiController
    {
        //[Inject]
        public SCMEntities db { get; set; }
        //SCMEntities db = new SCMEntities();
        //[Inject]
        //public DALBase<CheckDepot> SeleAllCheckDepot { get; set; }
        [HttpGet]
        [Route("a")]
        public List<CheckDepot> a()
        {
            return db.CheckDepot.ToList();
        }
    }
}
