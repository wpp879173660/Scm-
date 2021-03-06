USE [master]
GO
/****** Object:  Database [SCM]    Script Date: 2020/5/14 23:06:04 ******/
CREATE DATABASE [SCM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SCM', FILENAME = N'D:\S4_C#\29 IOC耦合度\13-IOC\SCM供应链项目\DB\SCM.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SCM_log', FILENAME = N'D:\S4_C#\29 IOC耦合度\13-IOC\SCM供应链项目\DB\SCM_log.LDF' , SIZE = 3840KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SCM] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SCM].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [SCM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SCM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SCM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SCM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SCM] SET ARITHABORT OFF 
GO
ALTER DATABASE [SCM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SCM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SCM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SCM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SCM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SCM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SCM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SCM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SCM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SCM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SCM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SCM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SCM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SCM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SCM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SCM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SCM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SCM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SCM] SET  MULTI_USER 
GO
ALTER DATABASE [SCM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SCM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SCM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SCM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SCM] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SCM', N'ON'
GO
ALTER DATABASE [SCM] SET QUERY_STORE = OFF
GO
USE [SCM]
GO
/****** Object:  Table [dbo].[DepotStock]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepotStock](
	[DSID] [int] IDENTITY(1,1) NOT NULL,
	[DepotID] [char](6) NULL,
	[ProID] [varchar](50) NULL,
	[DSAmount] [int] NULL,
	[DSPrice] [numeric](10, 2) NULL,
 CONSTRAINT [PK_DepotStock] PRIMARY KEY CLUSTERED 
(
	[DSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProID] [varchar](50) NOT NULL,
	[PTID] [int] NULL,
	[PUID] [int] NULL,
	[PCID] [int] NULL,
	[PSID] [int] NULL,
	[ProName] [nvarchar](100) NULL,
	[ProJP] [varchar](100) NULL,
	[ProTM] [varchar](100) NULL,
	[ProWorkShop] [varchar](200) NULL,
	[ProMax] [int] NULL,
	[ProMin] [int] NULL,
	[ProInPrice] [numeric](10, 2) NULL,
	[ProPrice] [numeric](10, 2) NULL,
	[ProDesc] [nvarchar](2000) NULL,
	[DepotID] [char](6) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[PTID] [int] IDENTITY(1,1) NOT NULL,
	[PTParentID] [int] NULL,
	[PTName] [nvarchar](100) NULL,
	[PTDes] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[PTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DS_P_PT]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_DS_P_PT]
as 
select ds_p.*,
pt.PTName from (select ds.DSID,
DSAmount,
DSPrice,
p.* from DepotStock ds left join 
Products p on ds.ProID=p.ProID) ds_p  left join	
ProductTypes pt on ds_p.PTID=pt.PTID
GO
/****** Object:  Table [dbo].[CheckDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckDepot](
	[CDID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[CDDate] [datetime] NULL,
	[UserID] [int] NULL,
	[CDDesc] [nvarchar](1000) NULL,
	[CDState] [int] NULL,
 CONSTRAINT [PK_CheckDepot] PRIMARY KEY CLUSTERED 
(
	[CDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Depots]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Depots](
	[DepotID] [varchar](50) NOT NULL,
	[DepotName] [nvarchar](100) NULL,
	[DepotMan] [nvarchar](100) NULL,
	[DepotTel] [nvarchar](100) NULL,
	[DepotAddress] [nvarchar](200) NULL,
	[DepotDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Depots] PRIMARY KEY CLUSTERED 
(
	[DepotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CheckDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckDepotDetail](
	[CDDID] [int] IDENTITY(1,1) NOT NULL,
	[CDID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[CDDAmount1] [int] NULL,
	[DevAmount2] [int] NULL,
	[CDDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_CheckDepotDetail] PRIMARY KEY CLUSTERED 
(
	[CDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UsersID] [int] IDENTITY(1,1) NOT NULL,
	[UsersName] [nvarchar](50) NULL,
	[UserLoginName] [varchar](20) NULL,
	[UserLoginPwd] [char](20) NULL,
	[UUID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UsersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CD_CDD_P_D_U]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_CD_CDD_P_D_U]
as 
select cd_cdd_p_d.*,u.UsersName from(select cd_cdd_p.*,
d.DepotName from (select cd_cdd.*,
'pl'=cd_cdd.diff*p.ProInPrice from (select cd.*,
'diff'=(cdd.CDDAmount1-cdd.DevAmount2),
cdd.ProID from CheckDepot cd left join 
CheckDepotDetail cdd on cd.CDID=cdd.CDID) cd_cdd left join 
Products p on cd_cdd.ProID=p.ProID) cd_cdd_p left join
Depots d on cd_cdd_p.DepotID=d.DepotID) cd_cdd_p_d left join
Users u on cd_cdd_p_d.UserID=u.UsersID
GO
/****** Object:  Table [dbo].[Devolves]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Devolves](
	[DevID] [char](14) NOT NULL,
	[DevOutID] [char](6) NULL,
	[DevInID] [char](6) NULL,
	[UserID] [int] NULL,
	[DevDate] [datetime] NULL,
	[DevDesc] [nvarchar](1000) NULL,
	[DevState] [int] NULL,
 CONSTRAINT [PK_Devolves] PRIMARY KEY CLUSTERED 
(
	[DevID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Dl_D_D]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_Dl_D_D]
as 
select dl_d_d.DevID,
dl_d_d.OutDepot,
dl_d_d.InDepot,
dl_d_d.DevDate,
u.UsersName,
dl_d_d.DevDesc,
dl_d_d.DevState from (select dl_d.*,
'InDepot'=d.DepotName from (select dl.*,
'OutDepot'=DepotName from Devolves dl left join 
Depots d on dl.DevOutID=d.DepotID) dl_d left join 
Depots d on dl_d.DevInID=d.DepotID) dl_d_d left join
Users u on dl_d_d.UserID=u.UsersID
GO
/****** Object:  Table [dbo].[SplitDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SplitDetail](
	[SDID] [int] IDENTITY(1,1) NOT NULL,
	[SplitID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[SDAmount] [int] NULL,
	[SDPrice] [numeric](10, 2) NULL,
	[SDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SplitDetail] PRIMARY KEY CLUSTERED 
(
	[SDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Splits]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Splits](
	[SplitID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[ProID] [varchar](50) NULL,
	[UserID] [int] NULL,
	[SplitDate] [datetime] NULL,
	[SplitDesc] [nvarchar](1000) NULL,
	[SplitState] [int] NULL,
	[SplitAmount] [int] NULL,
	[SplitPrice] [numeric](10, 2) NULL,
 CONSTRAINT [PK_Splits] PRIMARY KEY CLUSTERED 
(
	[SplitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Sl_SD_P_U]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_Sl_SD_P_U]
as 
select sl_sd_p_u.*,u.UsersName from (select sl_sd_p.*
,p.ProName from (select sl_sd.*,
d.DepotName from (select sl.*,
sd.SDAmount,
sd.SDPrice,
sd.SDDesc from Splits sl left join 
SplitDetail sd on sl.SplitID=SD.SplitID) sl_sd left join
Depots d on sl_sd.DepotID=d.DepotID) sl_sd_p left join
Products p on sl_sd_p.ProID=p.ProID) sl_sd_p_u left join
Users u on sl_sd_p_u.UserID=u.UsersID
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CusID] [char](14) NOT NULL,
	[CLID] [int] NULL,
	[CusName] [nvarchar](100) NULL,
	[CusCompany] [nvarchar](200) NULL,
	[CusMan] [nvarchar](50) NULL,
	[CusDesc] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerLevel]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerLevel](
	[CLID] [int] IDENTITY(1,1) NOT NULL,
	[CLName] [nvarchar](100) NULL,
	[CLAgio] [int] NULL,
 CONSTRAINT [PK_CustomerLevel] PRIMARY KEY CLUSTERED 
(
	[CLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vw_CL]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Vw_CL]
as
select a.*,b.CLAgio,b.CLName from Customers a join CustomerLevel b on a.CLID = b.CLID
GO
/****** Object:  Table [dbo].[ProductUnit]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductUnit](
	[PUID] [int] IDENTITY(1,1) NOT NULL,
	[PUName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductUnit] PRIMARY KEY CLUSTERED 
(
	[PUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSpec]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSpec](
	[PSID] [int] IDENTITY(1,1) NOT NULL,
	[PSName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductSpec] PRIMARY KEY CLUSTERED 
(
	[PSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductColor]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductColor](
	[PCID] [int] IDENTITY(1,1) NOT NULL,
	[PCName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductColor] PRIMARY KEY CLUSTERED 
(
	[PCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vw_DPP]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Vw_DPP]
as
select a.ProID,
a.ProName,
a.ProJP,
a.ProTM,
b.PCName,
c.PUName,
d.PSName from Products a join ProductColor b on a.PCID = b.PCID
join ProductUnit c on a.PUID = c.PUID
join ProductSpec d on a.PSID = d.PSID
GO
/****** Object:  View [dbo].[V_Dl_D_D_U]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_Dl_D_D_U]
as
select dl_d_d.*,
u.UsersName from (select dl_d.*,
'InDepot'=d.DepotName from (select dl.*,
'OutDepot'=d.DepotName from Devolves dl left join 
Depots d on dl.DevInID=d.DepotID) dl_d left join 
Depots d on dl_d.DevInID=d.DepotID) dl_d_d  left join 
Users u on dl_d_d.UserID=u.UsersID
GO
/****** Object:  View [dbo].[V_DS_D]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_DS_D]
as
select ds.*,
d.DepotName,
amount=ds.DSAmount*DSPrice from DepotStock ds left join 
Depots d on ds.DepotID=d.DepotID
GO
/****** Object:  View [dbo].[V_CustomersAndLevel]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_CustomersAndLevel]  
as
select c.*,cl.CLName,cl.CLAgio from Customers c inner join CustomerLevel cl on c.CLID=cl.CLID
GO
/****** Object:  View [dbo].[V_Products]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_Products]
as
select p.*, pt.PTName, pu.PUName, pc.PCName, ps.PSName, d.DepotName
from Products p
left join ProductTypes pt on p.PTID=pt.PTID
left join ProductUnit pu on p.PUID=pu.PUID
left join ProductColor pc on p.PCID=pc.PCID
left join ProductSpec ps on p.PSID=ps.PSID
left join Depots d on p.DepotID=d.DepotID
GO
/****** Object:  View [dbo].[V_VProductsAndDepotStock]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_VProductsAndDepotStock]  
as
select  s.ProID,p.PTID,p.ProName,p.PTName,p.ProInPrice,p.ProPrice,s.DSID,ProCount=sum(s.DSAmount) from V_Products p inner join	DepotStock s on p.ProID=s.ProID group by s.ProID,p.ProName,p.PTName,p.ProInPrice,p.ProPrice,p.PTID,s.DSID
GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[COID] [char](14) NOT NULL,
	[CusID] [char](14) NULL,
	[CODate] [datetime] NULL,
	[CORefDate] [datetime] NULL,
	[UserID] [int] NULL,
	[COState] [int] NULL,
	[CODesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_CustomerOrder] PRIMARY KEY CLUSTERED 
(
	[COID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerOrderDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderDetail](
	[CODID] [int] IDENTITY(1,1) NOT NULL,
	[COID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[CODAmount] [int] NULL,
	[CODPrice] [numeric](10, 2) NULL,
	[CODDiscont] [int] NULL,
	[CODDisPrice] [numeric](10, 2) NULL,
	[CODSale] [int] NULL,
	[CODDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_CustomerOrderDetail] PRIMARY KEY CLUSTERED 
(
	[CODID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CusAndCusOrderAndClv]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_CusAndCusOrderAndClv]
as
select od.CODID,ct.CusID,ct.CusName,od.COID,cl.CLName,od.CODDiscont,CODCount=od.CODDisPrice*od.CODSale from CustomerOrderDetail od inner join CustomerOrder co on od.COID=co.COID inner join Customers ct on co.CusID=ct.CusID inner join CustomerLevel cl on ct.CLID=cl.CLID
GO
/****** Object:  Table [dbo].[QuotePriceDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuotePriceDetail](
	[QPDID] [int] IDENTITY(1,1) NOT NULL,
	[QPID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[QPDAmount] [int] NULL,
	[QPDPrice] [numeric](10, 2) NULL,
	[QPDDiscont] [int] NULL,
	[QPDDisPrice] [numeric](10, 2) NULL,
	[QPDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_QuotePriceDetail] PRIMARY KEY CLUSTERED 
(
	[QPDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuotePrice]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuotePrice](
	[QPID] [char](14) NOT NULL,
	[CusID] [char](14) NULL,
	[UserID] [int] NULL,
	[QPDate] [datetime] NULL,
	[QPState] [int] NULL,
	[QPDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_QuotePrice] PRIMARY KEY CLUSTERED 
(
	[QPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_QuotePriceAndDetailAndCustomers]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_QuotePriceAndDetailAndCustomers]
as
select d.QPDID,p.QPID,c.CusID,c.CusName,d.QPDDiscont,QPDCount=d.QPDAmount*d.QPDDiscont from QuotePriceDetail d inner join QuotePrice p on d.QPID=p.QPID inner join Customers c on p.CusID=c.CusID
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[StockID] [char](14) NOT NULL,
	[PPID] [char](14) NULL,
	[StockDate] [datetime] NULL,
	[StockInDate] [datetime] NULL,
	[StockUser] [int] NULL,
	[StockState] [int] NULL,
	[StockDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Stocks] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockDetail](
	[SDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [varchar](50) NULL,
	[StockID] [char](14) NULL,
	[SDetailAmount] [int] NULL,
	[SDetailPrice] [numeric](10, 2) NULL,
	[SDetailDepAmount] [int] NULL,
	[SDetailDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_StockDetail] PRIMARY KEY CLUSTERED 
(
	[SDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductLend]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductLend](
	[PPID] [char](14) NOT NULL,
	[PPName] [nvarchar](100) NULL,
	[PPCompany] [nvarchar](200) NULL,
	[PPMan] [nvarchar](50) NULL,
	[PPTel] [nvarchar](100) NULL,
	[PPAddress] [nvarchar](300) NULL,
	[PPFax] [nvarchar](100) NULL,
	[PPEmail] [varchar](100) NULL,
	[PPUrl] [varchar](100) NULL,
	[PPBank] [nvarchar](200) NULL,
	[PPGoods] [varchar](100) NULL,
	[PPDesc] [nvarchar](2000) NULL,
 CONSTRAINT [PK_ProductLend] PRIMARY KEY CLUSTERED 
(
	[PPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_StockAndDetailAndProLendAndUsers]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_StockAndDetailAndProLendAndUsers]
as
select sd.SDetailID,sk.StockID,pl.PPID,pl.PPCompany,us.UsersName,sk.StockDate,sk.StockInDate,sk.StockState,StockCount=sd.SDetailAmount*sd.SDetailPrice from StockDetail sd inner join Stocks sk on sd.StockID=sk.StockID inner join Users us on sk.StockUser=us.UsersID inner join ProductLend pl on sk.PPID=pl.PPID
GO
/****** Object:  View [dbo].[V_ProAndDepotAndProType]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_ProAndDepotAndProType]
as
select p.*,t.PTName,c.PCName,u.PUName,ps.PSName,ProCount=(select SUM(d.DSAmount) from DepotStock d where ProID=p.ProID),ProFit=(select SUM(d.DSAmount) from DepotStock d where ProID=p.ProID)*p.ProPrice from Products p inner join ProductTypes t on p.PTID=t.PTID inner join ProductColor c on c.PCID=p.PCID inner join ProductUnit u on u.PUID=p.PUID inner join ProductSpec ps on p.PSID=ps.PSID
GO
/****** Object:  View [dbo].[V_DepotsAndDepotsStock]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_DepotsAndDepotsStock]
as
select s.*,d.DepotName from DepotStock s inner join Depots d on d.DepotID=s.DepotID 
GO
/****** Object:  View [dbo].[Vw_CDU]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Vw_CDU]
as
--库存盘点
select c.*,d.DepotName,u.UsersName from CheckDepot c join Depots d on c.DepotID = d.DepotID 
join Users u on c.UserID = u.UsersID
GO
/****** Object:  View [dbo].[V_StockDetailAndProAndColorAndTypes]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_StockDetailAndProAndColorAndTypes]
as
select s.*,c.PCName,t.PTName,p.ProName,SDetailSum=s.SDetailPrice*s.SDetailAmount from StockDetail s inner Join Products p on s.ProID=p.ProID inner join ProductColor c on p.PCID=c.PCID inner join ProductTypes t on p.PTID=t.PTID where s.ProID='P20190408000001'
GO
/****** Object:  View [dbo].[Vw_ptc]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Vw_ptc]
as
select p.*,pt.PTName,pc.PCName from Products p join ProductTypes pt on p.PTID = pt.PTID
join ProductColor pc on p.PCID = pc.PCID
GO
/****** Object:  Table [dbo].[PayOffs]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayOffs](
	[POID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[PODate] [datetime] NULL,
	[UserID] [int] NULL,
	[PODesc] [nvarchar](1000) NULL,
	[POState] [int] NULL,
 CONSTRAINT [PK_PayOffs] PRIMARY KEY CLUSTERED 
(
	[POID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayOffDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayOffDetail](
	[PODID] [int] IDENTITY(1,1) NOT NULL,
	[POID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[PODAmount] [int] NULL,
	[PODPrice] [numeric](10, 2) NULL,
	[PODDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_PayOffDetail] PRIMARY KEY CLUSTERED 
(
	[PODID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DepotsAndUsersAndDetailAndProducts]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_DepotsAndUsersAndDetailAndProducts]
as
select s.*,u.UsersName,d.DepotName,PayOffCount=SUM(pd.PODAmount*pd.PODPrice) from PayOffs s inner join Depots d on s.DepotID=d.DepotID inner join Users u on s.UserID=u.UsersID inner join PayOffDetail pd on s.POID=pd.POID group by s.POID,s.DepotID,s.PODate,s.PODesc,s.UserID,s.PODate,s.POState,u.UsersName,d.DepotName
GO
/****** Object:  Table [dbo].[LostDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LostDetail](
	[LDID] [int] IDENTITY(1,1) NOT NULL,
	[LostID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[LDAmount] [int] NULL,
	[LDPrice] [numeric](10, 2) NULL,
	[LDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_LostDetail] PRIMARY KEY CLUSTERED 
(
	[LDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Losts]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Losts](
	[LostID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[LostDate] [datetime] NULL,
	[UserID] [int] NULL,
	[LostDesc] [nvarchar](1000) NULL,
	[LostState] [int] NULL,
 CONSTRAINT [PK_Losts] PRIMARY KEY CLUSTERED 
(
	[LostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LostsAndDetailAndUsersAndDepots]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_LostsAndDetailAndUsersAndDepots]
as
select l.*,u.UsersName,d.DepotName,LostsCount=SUM(ld.LDAmount*ld.LDPrice) from Losts l inner join Users u on l.UserID=u.UsersID inner join Depots d on l.DepotID=d.DepotID inner join LostDetail ld on ld.LostID = l.LostID group by ld.ProID,l.LostID,l.DepotID,l.LostDate,l.LostDesc,l.LostState,l.LostState,l.UserID,u.UsersName,d.DepotName
GO
/****** Object:  Table [dbo].[InOutDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InOutDepotDetail](
	[IODDID] [int] IDENTITY(1,1) NOT NULL,
	[IODID] [int] NULL,
	[ProID] [varchar](50) NULL,
	[IODDAmount] [int] NULL,
	[IODDPrice] [numeric](10, 2) NULL,
	[IODDOutPrice] [numeric](10, 2) NULL,
 CONSTRAINT [PK_InOutDepotDetail] PRIMARY KEY CLUSTERED 
(
	[IODDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InOutDepot](
	[IODID] [int] IDENTITY(1,1) NOT NULL,
	[DepotID] [char](6) NULL,
	[IODType] [int] NULL,
	[IODNum] [varchar](100) NULL,
	[IODDate] [datetime] NULL,
	[IODUser] [int] NULL,
	[IODDesc] [nvarchar](1000) NULL,
	[IODLend] [char](14) NULL,
	[IODCus] [char](14) NULL,
 CONSTRAINT [PK_InOutDepot] PRIMARY KEY CLUSTERED 
(
	[IODID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_InDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_InDepot] as
select a.*, d.DepotName, u.UsersName, l.PPName, ISNULL(b.SumMoney,0) SumMoney
from InOutDepot a
left join Depots d on a.DepotID = d.DepotID
left join Users u on a.IODUser = u.UsersID
left join ProductLend l on a.IODLend = l.PPID
left join (select IODID, SUM(IODDAmount * IODDPrice) SumMoney from InOutDepotDetail group by IODID) b on a.IODID=b.IODID
where a.IODType = 1
GO
/****** Object:  View [dbo].[V_InOutDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[V_InOutDepotDetail]
as
select d.*, p.ProName,p.PTName, p.PUName, p.PCName, 
p.PSName, p.DepotID, p.DepotName,
d.IODDAmount * d.IODDPrice as IODDMoney
from InOutDepotDetail d
left join V_Products p on d.ProID=p.ProID

GO
/****** Object:  View [dbo].[V_OutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[V_OutDepot] as
select a.*, d.DepotName, u.UsersName, c.CusName, ISNULL(b.SumMoney,0) SumMoney
from InOutDepot a
left join Depots d on a.DepotID = d.DepotID
left join Users u on a.IODUser = u.UsersID
left join Customers c on a.IODCus = c.CusID
left join (select IODID, SUM(IODDAmount * IODDPrice) SumMoney from InOutDepotDetail group by IODID) b on a.IODID=b.IODID
where a.IODType = 2
GO
/****** Object:  Table [dbo].[Compose]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compose](
	[ComposeID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[ProID] [varchar](50) NULL,
	[UserID] [int] NULL,
	[ComposeDate] [datetime] NULL,
	[ComposeDesc] [nvarchar](1000) NULL,
	[ComposeState] [int] NULL,
	[ComposeAmount] [int] NULL,
	[ComposePrice] [numeric](10, 2) NULL,
 CONSTRAINT [PK_Compose] PRIMARY KEY CLUSTERED 
(
	[ComposeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComposeDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComposeDetail](
	[CDID] [int] IDENTITY(1,1) NOT NULL,
	[ComposeID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[CDAmount] [int] NULL,
	[CDPrice] [numeric](10, 2) NULL,
	[CDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ComposeDetail] PRIMARY KEY CLUSTERED 
(
	[CDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DevolveDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevolveDetail](
	[DevDID] [int] IDENTITY(1,1) NOT NULL,
	[DevID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[DevDAmount] [int] NULL,
	[DevDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_DevolveDetail] PRIMARY KEY CLUSTERED 
(
	[DevDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherInDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherInDepot](
	[OIDID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[OIDDate] [datetime] NULL,
	[OIDUser] [int] NULL,
	[OIDState] [int] NULL,
	[OIDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_OtherInDepot] PRIMARY KEY CLUSTERED 
(
	[OIDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherInDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherInDepotDetail](
	[OIDDID] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [varchar](50) NULL,
	[OIDID] [char](14) NULL,
	[OIDDAmount] [int] NULL,
	[OIDDPrice] [numeric](10, 2) NULL,
	[OIDDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_OtherInDepotDetail] PRIMARY KEY CLUSTERED 
(
	[OIDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherOutDepot](
	[OODID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[OODDate] [datetime] NULL,
	[UserID] [int] NULL,
	[OODState] [int] NULL,
	[OODDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_OtherOutDepot] PRIMARY KEY CLUSTERED 
(
	[OODID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherOutDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherOutDepotDetail](
	[OODDID] [int] IDENTITY(1,1) NOT NULL,
	[OODID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[OODDAmount] [int] NULL,
	[OODDPrice] [numeric](10, 2) NULL,
	[OODDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_OtherOutDepotDetail] PRIMARY KEY CLUSTERED 
(
	[OODDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PopedomRole]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PopedomRole](
	[PRID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[PopID] [int] NULL,
 CONSTRAINT [PK_PopedomRole] PRIMARY KEY CLUSTERED 
(
	[PRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Popedoms]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Popedoms](
	[PopID] [int] IDENTITY(1,1) NOT NULL,
	[PopName] [nvarchar](100) NULL,
	[PopParentID] [int] NULL,
	[PopIsMenu] [bit] NULL,
	[PopValue] [varchar](200) NULL,
	[PopDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Popedoms] PRIMARY KEY CLUSTERED 
(
	[PopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduceInDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceInDepot](
	[PIDID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[PIDDate] [datetime] NULL,
	[PIDUser] [int] NULL,
	[PIDState] [int] NULL,
	[PDIDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ProduceInDepot] PRIMARY KEY CLUSTERED 
(
	[PIDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduceInDepotDeteil]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceInDepotDeteil](
	[PIDDID] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [varchar](50) NULL,
	[PIDID] [char](14) NULL,
	[PIDDAmount] [int] NULL,
	[PIDDPrice] [numeric](14, 0) NULL,
	[PIDDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ProduceInDepotDeteil] PRIMARY KEY CLUSTERED 
(
	[PIDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduceOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceOutDepot](
	[PODID] [char](14) NOT NULL,
	[DepotID] [char](6) NULL,
	[PODDate] [datetime] NULL,
	[UserID] [int] NULL,
	[PODState] [int] NULL,
	[PODDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ProduceOutDepot] PRIMARY KEY CLUSTERED 
(
	[PODID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduceOutDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceOutDepotDetail](
	[PODDID] [int] IDENTITY(1,1) NOT NULL,
	[PODID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[PODDAmount] [int] NULL,
	[PODDPrice] [numeric](10, 2) NULL,
	[PODDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ProduceOutDepotDetail] PRIMARY KEY CLUSTERED 
(
	[PODDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NULL,
	[RoleDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleDepot](
	[SDID] [char](14) NOT NULL,
	[CusID] [char](14) NULL,
	[DepotID] [char](6) NULL,
	[SDDate] [datetime] NULL,
	[UserID] [int] NULL,
	[SDState] [int] NULL,
	[SDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SaleDepot] PRIMARY KEY CLUSTERED 
(
	[SDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleDepotDetail](
	[SDDID] [int] IDENTITY(1,1) NOT NULL,
	[SDID] [char](14) NULL,
	[ProID] [varchar](50) NULL,
	[SDDPrice] [numeric](10, 2) NULL,
	[SDDDiscount] [int] NULL,
	[SDDDisPrice] [numeric](10, 2) NULL,
	[SDDDesc] [nvarchar](1000) NULL,
	[SDDAmount] [int] NULL,
 CONSTRAINT [PK_SaleDepotDetail] PRIMARY KEY CLUSTERED 
(
	[SDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleReturn]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleReturn](
	[SRID] [char](14) NOT NULL,
	[CusID] [char](14) NULL,
	[DepotID] [char](6) NULL,
	[SRDate] [datetime] NULL,
	[UserID] [int] NULL,
	[SRState] [int] NULL,
	[SRDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SaleReturn] PRIMARY KEY CLUSTERED 
(
	[SRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleReturnDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleReturnDetail](
	[SRDID] [int] IDENTITY(1,1) NOT NULL,
	[SRID] [char](14) NULL,
	[ProID] [int] NULL,
	[SRDAmount] [int] NULL,
	[SRDPrice] [numeric](10, 2) NULL,
	[SRDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SaleReturnDetail] PRIMARY KEY CLUSTERED 
(
	[SRDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockInDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockInDepot](
	[SIDID] [char](14) NOT NULL,
	[PPID] [char](12) NULL,
	[DepotID] [char](6) NULL,
	[StockID] [char](14) NULL,
	[SIDDate] [datetime] NULL,
	[SIDDeliver] [varchar](100) NULL,
	[SIDFreight] [numeric](10, 2) NULL,
	[SIDUser] [int] NULL,
	[SIDData] [int] NULL,
	[SIDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_StockInDepot] PRIMARY KEY CLUSTERED 
(
	[SIDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockInDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockInDepotDetail](
	[SIDDID] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [varchar](50) NULL,
	[SIDID] [char](14) NULL,
	[SIDDAmount] [int] NULL,
	[SIDDPrice] [numeric](10, 2) NULL,
	[SIDDDesc] [nvarchar](1000) NULL,
 CONSTRAINT [PK_StockInDepotDetail] PRIMARY KEY CLUSTERED 
(
	[SIDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockOutDepot](
	[SRDID] [char](14) NOT NULL,
	[PPID] [char](12) NOT NULL,
	[StockID] [char](14) NOT NULL,
	[DepotID] [char](6) NOT NULL,
	[SRDDate] [datetime] NOT NULL,
	[SIDUser] [int] NOT NULL,
	[SIDData] [int] NOT NULL,
	[SIDDesc] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_StockOutDepot] PRIMARY KEY CLUSTERED 
(
	[SRDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockOutDepotDetail]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockOutDepotDetail](
	[SRDDID] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [int] NOT NULL,
	[SRDID] [char](14) NOT NULL,
	[SIDDAmount] [int] NOT NULL,
	[SIDDPrice] [numeric](10, 2) NOT NULL,
	[SIDDDesc] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_StockOutDepotDetail] PRIMARY KEY CLUSTERED 
(
	[SRDDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersRole]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersRole](
	[URID] [int] IDENTITY(1,1) NOT NULL,
	[UsersID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_UsersRole] PRIMARY KEY CLUSTERED 
(
	[URID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_InOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_InOutDepot] ON [dbo].[InOutDepot]
(
	[IODNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_CFNO]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[proc_CFNO]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from Splits)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(SplitID) from Splits
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='CF'+@newNo


GO
/****** Object:  StoredProcedure [dbo].[proc_common_create_flowNo]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_common_create_flowNo]
@tableName varchar(20),--表名
@pkNo varchar(30),--主键列
@prx varchar(40),--前缀
@no varchar(20) output
as 

declare @dt varchar(20),@temp varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp=@prx+@dt--'DD20120712'
declare @newNo varchar(20)
--判断是否有订单，有订单就有数据
declare @sql nvarchar(300),@param nvarchar(50),@count_output int
set @sql=N'select @count=count(*) from '+@tableName --拼接
set @param=N'@count int output' --设置输出参数
exec sp_executesql @sql,@param,@count=@count_output output
print @count_output
if (@count_output>0)
    begin
          --获取最大的订单号--KH201209220003
         declare @max_no varchar(20),@c_dt varchar(20)
         set @sql=' select @max_no_out=max('+@pkNo+') from ['+@tableName+']'
         set @param=N'@max_no_out varchar(30) output'
         exec sp_executesql @sql,@param,@max_no_out=@max_no output
         print 'sss'+@max_no
         set @c_dt=substring(@max_no,3,8) --20120712
         if(@dt=@c_dt)
          begin
				set @newNo=@temp+right(convert(varchar(20),convert(int,'1'+right(@max_no,4))+1),4)
          end
         else 
           begin --如果最大的订单帐号的时间和现在的时间不是同一天，就要新建新的帐号
               set @newNo=@prx+@dt+'0001'
           end     
    end
else--如果order表中没有数据，从当天的第一笔单开始
    begin
            set @newNo=@prx+@dt+'0001'
    end
   set  @no=@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_CPNO]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_CPNO]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from Compose)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(ComposeID) from Compose
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='ZH'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_CusOrder]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create  proc [dbo].[proc_CusOrder]
@no varchar(20) output
as 
   declare @prex varchar(20),@dt varchar(20),@temp_1 varchar(20)
set @prex='KD'
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@prex+@dt
 declare @newNo varchar(20)
--查询如果没有订单，从0001开始
if not exists(select * from CustomerOrder)
    begin
             declare @num varchar(7)  --0001
             set @num='0001'
             set @newNo=@temp_1+right(@num,3)
    end
else
    begin
             declare @sidid varchar(50),@shijian varchar(8)
             --获取最大的订单号
             select @sidid=max(COID) from [CustomerOrder]
             --获取时间
             set @shijian=substring(@sidid,3,8)
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo='KD'+@shijian+right(convert(varchar(10),convert(int,'1'+right(@sidid,10))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,9)
                 end
    end
set @no=@newNo

GO
/****** Object:  StoredProcedure [dbo].[proc_Cust_no]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  proc [dbo].[proc_Cust_no]
@no varchar(20) output
as 
   declare @prex varchar(20),@dt varchar(20),@temp_1 varchar(20)

set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从000001开始
select top 1 @newNo=PPID from [ProductLend] order by PPID desc
if (@newNo is null) --not exists(select * from [ProductLend])
    begin
             declare @num varchar(7)  --1000001
             set @num='0001'
             set @newNo=@temp_1+right(@num,3)
    end
else
    begin
             declare @cusid varchar(50),@shijian varchar(8)
             --获取最大的订单号
             select @cusid=max(PPID) from [ProductLend]
             --获取时间
             set @shijian=substring(@cusid,0,9)
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面6位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@cusid,4))+1),4)

                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,3)
                 end
    end
set @no=@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_Losts]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--生成订单号码
create proc [dbo].[proc_Losts]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from Losts)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max( 
 LostID
 ) from Losts
             --获取时间
             set @shijian=substring(@oid,3,9)
print @dt+':'+@shijian
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='BS'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_PayOffs]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--生成订单号码
create proc [dbo].[proc_PayOffs]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from PayOffs)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(POID) from PayOffs
             --获取时间
             set @shijian=substring(@oid,3,9)
print @dt+':'+@shijian
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='BY'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_ProID]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--生成订单号码
CREATE proc [dbo].[proc_ProID]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from Products)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(ProID) from Products
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='PR'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_SaleReturn]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--生成订单号码
create proc [dbo].[proc_SaleReturn]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from SaleReturn)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(SRID) from SaleReturn
             --获取时间
             set @shijian=substring(@oid,3,9)
print @dt+':'+@shijian
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='XT'+@newNo

GO
/****** Object:  StoredProcedure [dbo].[proc_SCNO]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_SCNO]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from ProduceInDepot)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(PIDID) from ProduceInDepot
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='SR'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_SDNO]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--生成订单号码
CREATE proc [dbo].[proc_SDNO]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from SaleDepot)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(SDID) from SaleDepot
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='XC'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_SLNO]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_SLNO]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from ProduceOutDepot)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(PODID) from ProduceOutDepot
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='SL'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[proc_StID]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--生成订单号码
CREATE proc [dbo].[proc_StID]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from Stocks)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(StockID) from Stocks
             --获取时间
             set @shijian=substring(@oid,3,9)

             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='CG'+@newNo


GO
/****** Object:  StoredProcedure [dbo].[proc_StockInDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_StockInDepot]
@no varchar(20) output
as 
   declare @prex varchar(20),@dt varchar(20),@temp_1 varchar(20)
set @prex='CR'
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@prex+@dt
 declare @newNo varchar(20)
--查询如果没有订单，从0001开始
if not exists(select * from [StockInDepot])
    begin
             declare @num varchar(7)  --0001
             set @num='0001'
             set @newNo=@temp_1+right(@num,3)
    end
else
    begin
             declare @sidid varchar(50),@shijian varchar(8)
             --获取最大的订单号
             select @sidid=max(SIDID) from [StockInDepot]
             --获取时间
             set @shijian=substring(@sidid,3,8)
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo='CR'+@shijian+right(convert(varchar(10),convert(int,'1'+right(@sidid,10))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,9)
                 end
    end
set @no=@newNo

GO
/****** Object:  StoredProcedure [dbo].[proc_StockOutDepot]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--生成订单号码
create proc [dbo].[proc_StockOutDepot]
@no varchar(20) output
as 
   declare @dt varchar(20),@temp_1 varchar(20)
set @dt=convert(varchar(20),getdate(),112)
set @temp_1=@dt
 declare @newNo varchar(20)

--查询如果没有订单，从0001开始
if not exists(select * from StockOutDepot)
    begin
             declare @num varchar(7)  --10001
             set @num='0001'
             set @newNo=@temp_1+right(@num,6)
    end
else
    begin
             declare @oid varchar(50),@shijian varchar(8)
             select @oid=max(SRDID) from StockOutDepot
             --获取时间
             set @shijian=substring(@oid,3,9)
print @dt+':'+@shijian
             if(@dt=@shijian)
                 begin--如果是同一天，编号累加
                     --截取后面4位+1
                    set @newNo=@shijian+right(convert(varchar(10),convert(int,'1'+right(@oid,4))+1),4)
                 end
            else
                 begin --新的一天，生成新的流水号
                       declare @num1 varchar(7)  --1000001
						 set @num1='0001'
						 set @newNo=@temp_1+right(@num1,6)
                 end
    end
set @no='CT'+@newNo
GO
/****** Object:  StoredProcedure [dbo].[PS_proc_CommonPager]    Script Date: 2020/5/14 23:06:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Stored Procedure dbo.p_commonList    Script Date: 2006-5-21 19:40:35 ******/

/****** Object:  Stored Procedure dbo.p_commonList    Script Date: 2006-5-21 17:17:41 ******/
Create   PROCEDURE [dbo].[PS_proc_CommonPager]
    @tblName      varchar(255),       -- 表名 
    @fldName      varchar(255),       -- 字段名 
    @PageSize     int = 5,           -- 页尺寸 
    @PageIndex    int = 1,            -- 页码 
    @IsCount      bit = 0,            -- 返回记录总数, 非 0 值则返回 
    @OrderType    bit = 0,            -- 设置排序类型, 非 0 值则降序 
    @strWhere     varchar(1000) = ''  -- 查询条件 (注意: 不要加 where) 
AS 

declare  @strSQL   varchar(1000)     -- 主语句 
declare @strTmp   varchar(300)     -- 临时变量 
declare @strOrder varchar(400)       -- 排序类型 

if @OrderType != 0 
begin 
    set @strTmp = '<(select min' 
    set @strOrder = ' order by [' + @fldName +'] desc' 
end 
else 
begin 
    set @strTmp = '>(select max' 
    set @strOrder = ' order by [' + @fldName +'] asc' 
end 

set @strSQL = 'select top ' + str(@PageSize) + ' * from [' 
    + @tblName + '] where [' + @fldName + ']' + @strTmp + '([' 
    + @fldName + ']) from (select top ' + str((@PageIndex-1)*@PageSize) + ' [' 
    + @fldName + '] from [' + @tblName + ']' + @strOrder + ') as tblTmp)' 
    + @strOrder 

if @strWhere !='' 
    set @strSQL = 'select top ' + str(@PageSize) + ' * from [' 
        + @tblName + '] where [' + @fldName + ']' + @strTmp + '([' 
        + @fldName + ']) from (select top ' + str((@PageIndex-1)*@PageSize) + ' [' 
        + @fldName + '] from [' + @tblName + '] where ' + @strWhere + ' ' 
        + @strOrder + ') as tblTmp) and  ' + @strWhere + ' ' + @strOrder 

if @PageIndex = 1 
begin 
    set @strTmp = '' 
    if @strWhere !='' 
        set @strTmp = ' where ' + @strWhere + '' 

    set @strSQL = 'select top ' + str(@PageSize) + ' * from [' 
        + @tblName + ']' + @strTmp + ' ' + @strOrder 
end 

if @IsCount != 0 
  begin
    set @strSQL = 'select count(*) as Total from [' + @tblName + ']'
    if @strWhere !=''
        set @strTmp ='where '+ @strWhere
        set @strSQL = 'select count(*) as Total from [' + @tblName + ']' +@strTmp 
  end

exec (@strSQL)
GO
USE [master]
GO
ALTER DATABASE [SCM] SET  READ_WRITE 
GO
