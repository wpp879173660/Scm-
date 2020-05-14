using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MODEL;
namespace IDAL
{
   public interface dbhelp<T> where T:class
    {
        //返回单张表的所有数据
        List<T> Selectall();

        T SelectKey(int key);

        int DeleteKey(T t);

        int Inset(T t);

        int Update(T t);
    }
}
