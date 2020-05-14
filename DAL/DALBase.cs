using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using IDAL;
using MODEL;
using Ninject;

namespace DAL
{
     
    public class DALBase<T> : dbhelp<T> where T : class
    {
        [Inject]
        public SCMEntities1 db { get; set; }

        //查询所有表
        public List<T> Selectall()
        {
            return db.Set<T>().ToList();
        }


        public T SelectKey(int key)
        {
            return db.Set<T>().Find(key);
        }

        public int Inset(T t)
        {
            db.Entry(t).State = System.Data.Entity.EntityState.Added;
            return db.SaveChanges();
        }

        public int DeleteKey(T t)
        {
            db.Entry(t).State = System.Data.Entity.EntityState.Deleted;
            return db.SaveChanges();
        }

        public int Update(T t)
        {
            db.Entry(t).State = System.Data.Entity.EntityState.Modified;
            return db.SaveChanges();
        }
    }
}
