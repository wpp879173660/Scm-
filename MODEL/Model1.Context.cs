﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace MODEL
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class SCMEntities1 : DbContext
    {
        public SCMEntities1()
            : base("name=SCMEntities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<CheckDepot> CheckDepot { get; set; }
        public virtual DbSet<CheckDepotDetail> CheckDepotDetail { get; set; }
        public virtual DbSet<Compose> Compose { get; set; }
        public virtual DbSet<ComposeDetail> ComposeDetail { get; set; }
        public virtual DbSet<CustomerLevel> CustomerLevel { get; set; }
        public virtual DbSet<CustomerOrder> CustomerOrder { get; set; }
        public virtual DbSet<CustomerOrderDetail> CustomerOrderDetail { get; set; }
        public virtual DbSet<Customers> Customers { get; set; }
        public virtual DbSet<Depots> Depots { get; set; }
        public virtual DbSet<DepotStock> DepotStock { get; set; }
        public virtual DbSet<DevolveDetail> DevolveDetail { get; set; }
        public virtual DbSet<Devolves> Devolves { get; set; }
        public virtual DbSet<InOutDepot> InOutDepot { get; set; }
        public virtual DbSet<InOutDepotDetail> InOutDepotDetail { get; set; }
        public virtual DbSet<LostDetail> LostDetail { get; set; }
        public virtual DbSet<Losts> Losts { get; set; }
        public virtual DbSet<OtherInDepot> OtherInDepot { get; set; }
        public virtual DbSet<OtherInDepotDetail> OtherInDepotDetail { get; set; }
        public virtual DbSet<OtherOutDepot> OtherOutDepot { get; set; }
        public virtual DbSet<OtherOutDepotDetail> OtherOutDepotDetail { get; set; }
        public virtual DbSet<PayOffDetail> PayOffDetail { get; set; }
        public virtual DbSet<PayOffs> PayOffs { get; set; }
        public virtual DbSet<PopedomRole> PopedomRole { get; set; }
        public virtual DbSet<Popedoms> Popedoms { get; set; }
        public virtual DbSet<ProduceInDepot> ProduceInDepot { get; set; }
        public virtual DbSet<ProduceInDepotDeteil> ProduceInDepotDeteil { get; set; }
        public virtual DbSet<ProduceOutDepot> ProduceOutDepot { get; set; }
        public virtual DbSet<ProduceOutDepotDetail> ProduceOutDepotDetail { get; set; }
        public virtual DbSet<ProductColor> ProductColor { get; set; }
        public virtual DbSet<ProductLend> ProductLend { get; set; }
        public virtual DbSet<Products> Products { get; set; }
        public virtual DbSet<ProductSpec> ProductSpec { get; set; }
        public virtual DbSet<ProductTypes> ProductTypes { get; set; }
        public virtual DbSet<ProductUnit> ProductUnit { get; set; }
        public virtual DbSet<QuotePrice> QuotePrice { get; set; }
        public virtual DbSet<QuotePriceDetail> QuotePriceDetail { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<SaleDepot> SaleDepot { get; set; }
        public virtual DbSet<SaleDepotDetail> SaleDepotDetail { get; set; }
        public virtual DbSet<SaleReturn> SaleReturn { get; set; }
        public virtual DbSet<SaleReturnDetail> SaleReturnDetail { get; set; }
        public virtual DbSet<SplitDetail> SplitDetail { get; set; }
        public virtual DbSet<Splits> Splits { get; set; }
        public virtual DbSet<StockDetail> StockDetail { get; set; }
        public virtual DbSet<StockInDepot> StockInDepot { get; set; }
        public virtual DbSet<StockInDepotDetail> StockInDepotDetail { get; set; }
        public virtual DbSet<StockOutDepot> StockOutDepot { get; set; }
        public virtual DbSet<StockOutDepotDetail> StockOutDepotDetail { get; set; }
        public virtual DbSet<Stocks> Stocks { get; set; }
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<UsersRole> UsersRole { get; set; }
    }
}