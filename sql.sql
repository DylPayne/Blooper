USE [master]
GO
/****** Object:  Database [blooper]    Script Date: 2023/07/03 23:58:02 ******/
CREATE DATABASE [blooper]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'blooper', FILENAME = N'C:\Users\dylan\OneDrive\Desktop\MSSQL16.MSSQLSERVER\MSSQL\DATA\blooper.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'blooper_log', FILENAME = N'C:\Users\dylan\OneDrive\Desktop\MSSQL16.MSSQLSERVER\MSSQL\DATA\blooper_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [blooper] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [blooper].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [blooper] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [blooper] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [blooper] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [blooper] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [blooper] SET ARITHABORT OFF 
GO
ALTER DATABASE [blooper] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [blooper] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [blooper] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [blooper] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [blooper] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [blooper] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [blooper] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [blooper] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [blooper] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [blooper] SET  ENABLE_BROKER 
GO
ALTER DATABASE [blooper] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [blooper] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [blooper] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [blooper] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [blooper] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [blooper] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [blooper] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [blooper] SET RECOVERY FULL 
GO
ALTER DATABASE [blooper] SET  MULTI_USER 
GO
ALTER DATABASE [blooper] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [blooper] SET DB_CHAINING OFF 
GO
ALTER DATABASE [blooper] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [blooper] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [blooper] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [blooper] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'blooper', N'ON'
GO
ALTER DATABASE [blooper] SET QUERY_STORE = ON
GO
ALTER DATABASE [blooper] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [blooper]
GO
/****** Object:  Table [dbo].[bloopers]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bloopers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[word] [nvarchar](255) NOT NULL,
	[created_at] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[to] [int] NOT NULL,
	[from] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](25) NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bloopers] ADD  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[messages] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([from])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([to])
REFERENCES [dbo].[users] ([id])
GO
/****** Object:  StoredProcedure [dbo].[CreateBlooper]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateBlooper]
	@word NVARCHAR(255)
AS
	INSERT INTO dbo.Bloopers (word)
	VALUES
		(@word)
GO
/****** Object:  StoredProcedure [dbo].[CreateMessage]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateMessage]
	@to int,
	@from int,
	@text nvarchar(1000)
AS
	INSERT INTO [dbo].[Messages]
		([To], [From], [Text])
	VALUES
		(@to, @from, @text)
GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateUser]
	@username nvarchar(25)
AS
	INSERT INTO [dbo].[Users]
		([Username])
	VALUES
		(@username)
GO
/****** Object:  StoredProcedure [dbo].[DeleteBlooper]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBlooper]
	@id int
AS
	DELETE FROM dbo.bloopers
	WHERE id=@id
GO
/****** Object:  StoredProcedure [dbo].[DeleteMessage]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
CREATE PROCEDURE [dbo].[DeleteMessage]
	@id int
AS
	DELETE FROM [dbo].[messages]
	WHERE [id] = @id
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
CREATE PROCEDURE [dbo].[DeleteUser]
	@id int
AS
	DELETE FROM [dbo].[users]
	WHERE [id] = @id
GO
/****** Object:  StoredProcedure [dbo].[ExternalGetMessages]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
CREATE PROCEDURE [dbo].[ExternalGetMessages]
	@to int,
	@from int
AS
	SELECT [to], [from], [text], [created_at]
	FROM [dbo].[Messages]
	WHERE ([to] = @to OR [to] = @from) AND ([from] = @from OR [from] = @to)
	ORDER BY [created_at] ASC
GO
/****** Object:  StoredProcedure [dbo].[GetBloopers]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBloopers]
AS
	SELECT word FROM dbo.bloopers
GO
/****** Object:  StoredProcedure [dbo].[GetMessages]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMessages]
	@to int,
	@from int
AS
	SELECT [to], [from], [text], [created_at]
	FROM [dbo].[Messages]
	WHERE ([to] = @to OR [to] = @from) AND ([from] = @from OR [from] = @to)
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsers]
AS
	SELECT *
	FROM [dbo].[users]
GO
/****** Object:  StoredProcedure [dbo].[UpdateBlooper]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBlooper]
	@id int,
	@word NVARCHAR(255)
AS
	UPDATE dbo.bloopers
	SET word=@word
	WHERE id=@id
GO
/****** Object:  StoredProcedure [dbo].[UpdateMessage]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
CREATE PROCEDURE [dbo].[UpdateMessage]
	@id INT,
	@to INT,
	@from INT,
	@text NVARCHAR(1000)
AS
	UPDATE [dbo].[messages]
	SET
		[to] = @to,
		[from] = @from,
		[text] = @text
	WHERE
		[id] = @id

GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 2023/07/03 23:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
CREATE PROCEDURE [dbo].[UpdateUser]
	@id INT,
	@username NVARCHAR(25)
AS
	UPDATE [dbo].[users]
	SET
		[username] = @username
	WHERE
		[id] = @id

GO
USE [master]
GO
ALTER DATABASE [blooper] SET  READ_WRITE 
GO
