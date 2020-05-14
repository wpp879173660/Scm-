using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using IDAL;
using DAL;
using MODEL;
using Ninject.Web.Common;

namespace UI.App_Start
{
    public class ioc : DefaultControllerFactory
    {
        /// <summary>
        /// 依赖注入核心
        /// </summary>
        private readonly IKernel _kernel;

        /// <summary>
        /// 构造依赖注入控制器工厂
        /// </summary>
        public ioc()
        {
            _kernel = new StandardKernel();
            AddBindings();
        }

        /// <summary>
        /// 产生控制器
        /// </summary>
        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            return controllerType == null ? null : (IController)_kernel.Get(controllerType);
        }

        /// <summary>
        /// 添加绑定
        /// </summary>
        private void AddBindings()
        {
            //绑定接口和实现类
            _kernel.Bind<IDAL.dbhelp<Type>>().To<DALBase<Type>>();

            //InRequestScope 需要命名空间 Ninject.Web.Common，更需要程序集 Ninject.Web.Common
            _kernel.Bind<MODEL.SCMEntities1>().ToSelf().InRequestScope();
            //InRequestScope 表示生命周期为：请求。  请求结束时，对象被释放
        }
    }
}