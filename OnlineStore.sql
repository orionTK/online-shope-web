USE [master]
GO
/****** Object:  Database [OnlineStore]    Script Date: 6/22/2020 10:28:44 PM ******/
CREATE DATABASE [OnlineStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DIOSVO\MSSQL\DATA\OnlineStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DIOSVO\MSSQL\DATA\OnlineStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [OnlineStore] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineStore] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineStore] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineStore] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineStore', N'ON'
GO
ALTER DATABASE [OnlineStore] SET QUERY_STORE = OFF
GO
USE [OnlineStore]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[Size] [varchar](50) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[Size] ASC,
	[ProductID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](225) NULL,
	[Gender] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Size] [varchar](50) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[ShipName] [nvarchar](100) NOT NULL,
	[ShipAddress] [nvarchar](100) NOT NULL,
	[ShipPhoneNumber] [varchar](50) NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[Price] [money] NOT NULL,
	[Stock] [smallint] NOT NULL,
	[DateCreate] [date] NOT NULL,
	[Description] [nvarchar](225) NULL,
	[ImageSource] [varchar](225) NULL,
	[PromotionID] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSize]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSize](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[SizeID] [int] NOT NULL,
 CONSTRAINT [PK_ProductSize] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionID] [int] IDENTITY(1,1) NOT NULL,
	[PromotionName] [nvarchar](255) NULL,
	[DiscountPercent] [real] NOT NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleUser]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleUser](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_RoleUser] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[SizeID] [int] IDENTITY(1,1) NOT NULL,
	[SizeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Size] PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [varchar](50) NOT NULL,
	[TransactionDate] [date] NOT NULL,
	[Fee] [money] NOT NULL,
	[Result] [nvarchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
 CONSTRAINT [PK_Transactions_1] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[DOB] [varchar](50) NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Carts] ([Size], [UnitPrice], [Quantity], [ProductID], [UserID]) VALUES (N'L', 349.0000, 1, 44, 1)
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (1, N'Quần Jeans', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (2, N'Quần Short', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (3, N'Áo Thun', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (6, N'Áo Khoác', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (7, N'Áo Jersey ', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (9, N'Phụ kiện', N'Nam', N'Nam', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (11, N'Áo Khoác', N'Nữ', N'Nữ', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (13, N'Quần Short', N'Nữ', N'Nữ', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (14, N'Quần Jeans', N'Nữ', N'Nữ', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (22, N'Áo thun', N'Nữ', N'Nữ', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (24, N'Áo Croptops', N'Nữ', N'Nữ', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Title], [Description], [Gender]) VALUES (26, N'Phụ kiện', N'Nữ', N'Nữ', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (1, 1, N'Quần Jean Atom', 499.0000, 20, CAST(N'2020-06-10' AS Date), N'Nam', N'culture-kings.imgix.net/products/03004667-YL027_normal_0020.jpg?v=1590753585&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (2, 1, N'Quần Jean Hellcat Elastic', 399.0000, 20, CAST(N'0001-01-01' AS Date), N'Nam', N'culture-kings.imgix.net/products/03002508-YB430_normal_010.jpg?v=1580863307&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (4, 1, N'Quần Jean Endommage', 249.0000, 20, CAST(N'2020-06-10' AS Date), N'Nam', N'culture-kings.imgix.net/products/03002963-YS400_normal_0020.jpg?v=1583793963&fit=crop&h=1000&w=800&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (29, 1, N'Quần Jean Pasadena', 249.0000, 20, CAST(N'2020-06-15' AS Date), N'Nam', N'culture-kings.imgix.net/products/03001193-YB684_normal_010.jpg?v=1580863270&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (34, 1, N'Quần Jean Roco', 299.0000, 10, CAST(N'2020-06-16' AS Date), N'Nam', N'culture-kings.imgix.net/products/03003971-YV015_normal_001.jpg?v=1571304516&auto=compress,format&fit=crop&w=500&h=625', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (36, 1, N'Quần Jean Nettoyer', 499.0000, 15, CAST(N'2020-06-16' AS Date), N'Nam', N'culture-kings.imgix.net/products/03003643-YX561_normal_00040.jpg?v=1583794663&auto=compress,format&fit=crop&w=500&h=625', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (38, 1, N'Quần Jean Big Baz', 399.0000, 10, CAST(N'2020-06-16' AS Date), N'Nam', N'culture-kings.imgix.net/products/03003332-YX561_normal_01.jpg?v=1574121919&auto=compress,format&fit=crop&w=500&h=625', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (39, 3, N'Áo thun Smiley Narava', 259.0000, 20, CAST(N'2020-06-16' AS Date), N'Nam', N'culture-kings.imgix.net/products/08000303-YW607_normal_0040.jpg?v=1591848039&auto=compress,format&fit=crop&w=500&h=625', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (41, 2, N'Quần short Champions', 459.0000, 15, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/9354009521358_normal_0020.jpg?v=1591311157&auto=compress,format&fit=crop&w=500&h=625', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (42, 2, N'Quần short Enorme', 299.0000, 10, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/4454569134519_normal_0020.jpg?v=1591196628&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (44, 3, N'Áo tay dài Lacoste 90''s', 349.0000, 10, CAST(N'2020-06-16' AS Date), NULL, N'
culture-kings.imgix.net/products/02024483-YV040_normal_0020.jpg?v=1591998774&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (48, 7, N'LA Lakers #34 Swingman Jersey', 999.0000, 2, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/02019494-YY001_normal_0040.jpg?v=1589861321&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (51, 9, N'Đồng hồ G-Shock Carbon Core', 2999.0000, 2, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/4549526241642_normal_0020.png?v=1592195395&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (52, 9, N'Túi bao tử Nike ', 555.0000, 3, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/06006057-YP421_normal_0020_42737b60-b2a1-496d-839c-e9e51c628d94.png?v=1588847148&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (54, 9, N'Balo Calvin Klein', 799.0000, 1, CAST(N'2020-06-16' AS Date), NULL, N'culture-kings.imgix.net/products/8719852696027_normal_0020.png?v=1585807555&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (57, 6, N'Áo khoác Vertico', 999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022368-YQ001_normal_020.jpg?v=1592195062&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (58, 7, N'Bull #8 Swingman Jersey', 499.0000, 3, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02020718-YB695_normal_0020.jpg?v=1588920159&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (60, 3, N'Áo thun Peek A Boo', 399.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02023110-YB001_normal_0040.jpg?v=1592440867&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (61, 6, N'Áo khoác Classic Leatherman', 1099.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02021395-YB001_normal_00020.jpg?v=1585708368&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (62, 7, N'Dynamic Jersey', 799.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02012940-YY003_normal_011.jpg?culture-kings.imgix.net/products/02012940-YY003_normal_011.jpg?v=1569197393&auto=compress,format

', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (63, 9, N'Balo Supreme', 7999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4454569156771_normal_0021.jpg?v=1592566232&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (64, 2, N'Quần short D-Luxe Denim', 399.0000, 4, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004163-YX561_normal_00040.jpg?v=1583804006&auto=compress,format
', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (66, 3, N'Áo thun Goat Crew', 499.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02024278-YB295_normal_0020.jpg?v=1592207698&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (67, 9, N'Mắt kính High Key', 719.0000, 3, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9343963053173_normal_0020.jpg?v=1592456997&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (68, 6, N'Áo khoác Adidas AOP', 1599.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02019846-YX500_normal_0020.jpg?v=1584497904&auto=compress,format', 5)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (70, 7, N'Jersey Layer Bball', 999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02019742-YR001_normal_00020.jpg?v=1581708533&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (71, 9, N'Mắt kính Bossy Blue Ligh', 1299.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9343963046601_normal_0020.jpg?v=1592456948&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (72, 9, N'Bình nước PYRA® X Nalgene 1000ml', 499.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/06006629-YQ043_normal_0019.jpg?v=1592441178&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (73, 9, N'Đồng hồ Ambassador', 7999.0000, 1, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4454569135110_normal_0019.jpg?v=1584321924&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (74, 9, N'Ví Oscar Leather', 500.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432375912_normal_0040.png?v=1583752718&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (75, 9, N'Đồng hồ Sentry SS', 6199.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/3608701059913_normal_0020.png?v=1583756151&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (77, 9, N'Đồng hồ Cypher M1', 5100.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/3608701082102_normal_0040.jpg?v=1583793524&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (78, 6, N'Áo khoác Colorblock Popover', 4999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/8719861053217_normal_0020.jpg?v=1583660200&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (79, 6, N'Áo khoác C-47 Bomber 2.0', 1999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02008088-YS400_normal_00050.jpg?v=1589239887&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (80, 6, N'Áo khoác Staple Varsity', 999.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02017287-YN295_normal_00040.jpg?v=1589240107&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (83, 3, N'Áo thun P.O.P Classique', 519.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4454569167807_normal_0020.jpg?v=1591217227&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (84, 3, N'Áo thun Nike NBA MVP2', 499.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022156-YW100_normal_0020.jpg?v=1592259477&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (85, 3, N'Áo thun UNC Wordmark Crest Vintage', 419.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02024159-YB001_normal_0040.jpg?v=1591858835&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (86, 2, N'Quần short Kane', 499.0000, 25, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004229-YM041_normal_00020.jpg?v=1581770341&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (87, 2, N'Quần short Lafayette Essentiel ', 899.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4434569574539_normal_0020.jpg?v=1570769815&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (90, 11, N'Áo khoác Tommy Flag Trucker', 4999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022754-YL200_womens_0020.jpg?v=1592260440&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (91, 11, N'Áo khoác Adidas SST Track Top', 1999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02011623-YB001_womens_0020.jpg?v=1589252735&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (92, 11, N'Áo khoác Adidas  Lock Up Track', 1500.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4062055251727_normal_0020.jpg?v=1589237983&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (96, 11, N'Áo khoác Nike Throwback Woven', 2999.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02019701-YB235_womens_0020.jpg?v=1589153673&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (97, 11, N'Áo khoác Women''s Gibbs Worker', 1444.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986106074_normal_0019.png?v=1588329665&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (98, 11, N'Áo khoác NSW Icon Clash Packable', 4200.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/193659773156_normal_0020.png?v=1589417054&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (99, 11, N'Áo khoác Women''s Skyla Bomber', 2999.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02020063-YB001_normal_00020.jpg?v=1576751045&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (102, 13, N'Quần short Women''s Bermuda', 499.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004132-YM152_normal_0030.jpg?v=1581768859&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (103, 13, N'Quần short Champion', 599.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004118-YG040_normal_01.jpg?v=1581768469&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (104, 13, N'Quần short Evelyn ', 600.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986014041_normal_0020.jpg?v=1573715725&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (105, 13, N'Quần short Knox', 700.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986014294_normal_001.jpg?v=1572846316&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (106, 13, N'Quần short Matira', 500.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004099-YB001_normal_00020.jpg?v=1581768158&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (107, 14, N'Quần Jean High Rise Tapered', 999.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004488-YL200_normal_0020.jpg?v=1583699492&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (108, 14, N'Quần Jean The Jane', 1500.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03003931-YS582_normal_01.jpg?v=1580901217&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (110, 14, N'Quần Jean Hi Rise Skinny ', 1499.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03004297-YB673_normal_0020.jpg?v=1584658945&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (111, 14, N'Quần Jean Bonnie Boyfriend Jean', 1999.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/03003923-YA009_normal_01.jpg?v=1569233144&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (112, 22, N'Áo thun Scary Movie Vintage', 499.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02024269-YB295_womens_0020.jpg?v=1592458429&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (113, 22, N'Áo thun Chicago Bulls Vintage', 599.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02018142-YB001_womens_0025.png?v=1592522937&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (114, 22, N'Áo thun Jordan', 659.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022285-YW062_womens_0027.jpg?v=1592274371&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (116, 22, N'Áo thun Ride The Lightning Vintage', 799.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/08000057-YW607_womens_0020_a651fa7a-99ad-43be-a202-b7c2690c0879.jpg?v=1591848790&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (117, 22, N'Áo thun Rave Photo Box Reg', 899.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/8719852632957_womens_0020.jpg?v=1591330949&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (118, 22, N'Áo thun Upscale Monogram', 999.0000, 50, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/8719852649085_womens_0020.jpg?v=1590620444&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (119, 22, N'Áo thun Heritage Cloud Dye ', 789.0000, 50, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022165-YS112_womens_0020.jpg?v=1589536302&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (120, 22, N'Áo thun Carré Foundation Divise SS', 999.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02019093-YW100_womens_0020.jpg?v=1589240233&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (121, 22, N'Áo thun Adidas Large Logo Cropped ', 599.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4062055468460_normal_0020.jpg?v=1589238383&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (123, 22, N'Áo thun Live In Concert', 499.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/08000334-YW100_womens_0020.png?v=1588737628&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (124, 22, N'Áo thun Houston Rockets World Champs', 399.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022484-YW100_womens_0020.png?v=1588737893&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (129, 22, N'Áo thun Barrows Boxy', 499.0000, 20, CAST(N'2020-06-20' AS Date), N'Nữ', N'culture-kings.imgix.net/products/9354986098249_normal_0020.jpg?v=1588333713&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (130, 22, N'Áo thun Copyright Boxy', 519.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986097471_normal_0020.jpg?v=1584656550&fit=crop&h=1000&w=800&auto=compress,format', 3)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (131, 22, N'Áo thun Ten Eddies', 999.0000, 25, CAST(N'2020-06-20' AS Date), N'', N'culture-kings.imgix.net/products/08000329-YW100_womens_0020.png?v=1587707903&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (133, 22, N'Áo thun TJW Linear Logo', 499.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/8719861022695_normal_0020.jpg?v=1579565851&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (134, 22, N'Áo thun Sportswear Icon Clash ', 599.0000, 25, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/193654982812_normal_0020.jpg?v=1581734763&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (135, 22, N'Áo thun TJW Linear Small Logo', 419.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/8719861021780_normal_0020.jpg?v=1579565877&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (136, 24, N'Áo thun Rough Script', 399.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022662-YD045_normal_00024.jpg?v=1576810304&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (137, 24, N'Áo thun Obey Blockbuster Crop', 299.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02020013-YF033_normal_0020.jpg?v=1581712537&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (140, 24, N'Áo Cro Cocaine & Caviar', 315.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02022663-YY001_normal_020_df33a784-99d1-4f48-bc98-e2a1d1a701ed.jpg?v=1580854974&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (142, 24, N'Áo thun W Avery Stripe', 399.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986010494_normal_00020.jpg?v=1578543153&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (143, 24, N'Áo Cali Boxy', 299.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02019933-YO020_normal_00020.jpg?v=1576749279&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (144, 22, N'Áo Ricki OS ', 300.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02020916-YW035_normal_00020.jpg?v=1576760953&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (145, 22, N'Áo thun  TJW Tommy Classics', 550.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02015283-YB483_normal_01.jpg?v=1580893587&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (146, 24, N'Áo  Designs Boxy ', 400.0000, 20, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354986058113_normal_0020.jpg?v=1581723148&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (147, 22, N'Áo thun Loveless', 500.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/02020014-YS038_normal_0020.jpg?v=1581712613&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (148, 24, N'Áo Crop NSW Futura Wash ', 499.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/194272063648_normal_0020.jpg?v=1592019867&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (149, 24, N'Áo Crop New York Yankees Archy', 499.0000, 10, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9353380175563_normal_0020.png?v=1590659269&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (150, 24, N'Áo Crop Heritage Script', 399.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9354779453675_normal_0020.png?v=1587363204&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (151, 24, N'Áo Crop Sportswear Swoosh ', 999.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/193659869811_normal_0020.png?v=1585446928&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (152, 26, N'Vớ ngắn Nike', 719.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/886550330893_normal_0010.jpg?v=1569090620&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (153, 24, N'Áo Crop Easy To Love', 599.0000, 35, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/193259295386_normal_0020.png?v=1585526613&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (154, 26, N'Mắt kính Farrah', 1100.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9343963048766_normal_0020.jpg?v=1590015197&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (155, 26, N'Túi đeo chéo Eighteen', 2100.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432341658_normal_0018.jpg?v=1581823731&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (156, 26, N'Balo Herchel Classic', 1500.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432338337_normal_0018.jpg?v=1581823575&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (157, 26, N'Balo Delta Buckingham', 1800.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432338351_normal_0018.jpg?v=1581823608&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (158, 26, N'Ví Herschel Bag Co Charlie RFID Salmon', 500.0000, 15, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432273348_normal_0019.jpg?v=1569251767&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (159, 26, N'Vớ Champion', 419.0000, 30, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/9351950817806_normal_011.jpg?v=1569251753&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (160, 26, N'Túi BAMFIELD MID-VOL TOTE', 999.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432246182_normal_0018.jpg?v=1581823799&fit=crop&h=1000&w=800&auto=compress,format', 0)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (161, 26, N'Balo Seasonal', 1999.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432309450_normal_0018.jpg?v=1581823555&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (162, 26, N'Đồng hồ Super Slim A700 A700WMG-9A', 3199.0000, 2, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/4549526220203_normal_0040.jpg?v=1583793486&fit=crop&h=1000&w=800&auto=compress,format', 1)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (164, 26, N'Túi bao tử STUDIO NINETEEN HIP', 1699.0000, 1, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432258925_normal_0019.jpg?v=1569251770&fit=crop&h=1000&w=800&auto=compress,format', 2)
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ProductName], [Price], [Stock], [DateCreate], [Description], [ImageSource], [PromotionID]) VALUES (165, 26, N'Túi FIFTEEN HIP PACK', 1699.0000, 5, CAST(N'2020-06-20' AS Date), NULL, N'culture-kings.imgix.net/products/828432258628_normal_0021.jpg?v=1569251768&fit=crop&h=1000&w=800&auto=compress,format', 2)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (0, N'Không giảm giá', 0)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (1, N'Giảm 10%', 0.1)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (2, N'Giảm 20%', 0.2)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (3, N'Giảm 30%', 0.3)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (4, N'Giảm 40%', 0.4)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (5, N'Giảm 50%', 0.5)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (6, N'Giảm 60%', 0.6)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (7, N'Giảm 70%', 0.7)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (8, N'Giảm 80%', 0.8)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (9, N'Giảm 90%', 0.9)
INSERT [dbo].[Promotion] ([PromotionID], [PromotionName], [DiscountPercent]) VALUES (10, N'Giảm 100%', 1)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleUser] ON 

INSERT [dbo].[RoleUser] ([RoleID], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[RoleUser] ([RoleID], [RoleName]) VALUES (2, N'user')
SET IDENTITY_INSERT [dbo].[RoleUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([SizeID], [SizeName]) VALUES (1, N'S         ')
INSERT [dbo].[Size] ([SizeID], [SizeName]) VALUES (2, N'M         ')
INSERT [dbo].[Size] ([SizeID], [SizeName]) VALUES (3, N'L         ')
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UserName], [Password], [PhoneNumber], [Email], [DOB], [RoleID]) VALUES (33, N'edit admin', N'$2a$10$QfYi46HpWZmfhP6NIFw1E.Darxx/BGVzGNoA4Re8jxh3zbNKtngYu', N'0123456789', N'laptrinhcsdl@ou.edu.vn', N'2020-06-22', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Products]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Promotion] FOREIGN KEY([PromotionID])
REFERENCES [dbo].[Promotion] ([PromotionID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Promotion]
GO
ALTER TABLE [dbo].[ProductSize]  WITH CHECK ADD  CONSTRAINT [FK_ProductSize_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductSize] CHECK CONSTRAINT [FK_ProductSize_Products]
GO
ALTER TABLE [dbo].[ProductSize]  WITH CHECK ADD  CONSTRAINT [FK_ProductSize_Size] FOREIGN KEY([SizeID])
REFERENCES [dbo].[Size] ([SizeID])
GO
ALTER TABLE [dbo].[ProductSize] CHECK CONSTRAINT [FK_ProductSize_Size]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Orders]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_RoleUser] FOREIGN KEY([RoleID])
REFERENCES [dbo].[RoleUser] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_RoleUser]
GO
/****** Object:  StoredProcedure [dbo].[ProductGetAllByGender]    Script Date: 6/22/2020 10:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductGetAllByGender]
	@gender bit
AS
BEGIN
	SELECT * FROM Products a inner join Categories b on a.CategoryID = b.CategoryID
	WHERE Gender = @gender
END

GO
USE [master]
GO
ALTER DATABASE [OnlineStore] SET  READ_WRITE 
GO
