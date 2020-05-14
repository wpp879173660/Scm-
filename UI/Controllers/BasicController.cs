using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MODEL;
using DAL;
using Ninject;
using IDAL;

namespace UI.Controllers
{
    public class BasicController : Controller
    {
        [Inject]
        public SCMEntities1 db { get; set; }
        // GET: Basic
        [Inject]
        public DALBase<CheckDepot> SeleAllCheckDepot { get; set; }


        public ActionResult Index()
        {
            CustomerLevel s = new CustomerLevel() { CLName="最低级",CLAgio=100,CLID=4};
            //SeleAllCheckDepot.Inset(s);
            //SeleAllCheckDepot.DeleteKey(2);
            //SeleAllCheckDepot.Update(3,s);

            return View(SeleAllCheckDepot.Selectall()); 
        }

    }
}