USE [master]
GO
/****** Object:  Database [Universidad]    Script Date: 18/11/2019 09:57:32 ******/
CREATE DATABASE [Universidad]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Universidad', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.INGENIERIA\MSSQL\DATA\Universidad.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Universidad_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.INGENIERIA\MSSQL\DATA\Universidad_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Universidad] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Universidad].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Universidad] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Universidad] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Universidad] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Universidad] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Universidad] SET ARITHABORT OFF 
GO
ALTER DATABASE [Universidad] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Universidad] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Universidad] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Universidad] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Universidad] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Universidad] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Universidad] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Universidad] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Universidad] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Universidad] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Universidad] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Universidad] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Universidad] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Universidad] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Universidad] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Universidad] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Universidad] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Universidad] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Universidad] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Universidad] SET  MULTI_USER 
GO
ALTER DATABASE [Universidad] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Universidad] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Universidad] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Universidad] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Universidad]
GO
/****** Object:  StoredProcedure [dbo].[sp_anular_Matricula]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_anular_Matricula]
@pCod_Matricula nvarchar(10)
as
update Tbl_Matricula set Activo=0
where Cod_Matricula=@pCod_Matricula

GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_estudiante]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_estudiante]
@pID_Estudiante nvarchar(10)
as 

if @pID_Estudiante=''
	select * from Tbl_Estudiante
else 
	select * from Tbl_Estudiante
	where ID_Estudiante=@pID_Estudiante

GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_matricula]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_matricula] 
@pCod_Matricula nvarchar(10)
as 
select * from Tbl_Matricula where Cod_Matricula= @pCod_Matricula
select Nombre_Estudiante,Carrera from Tbl_Estudiante,Tbl_Matricula
where Tbl_Matricula.ID_Estudiante=Tbl_Estudiante.ID_Estudiante
and @pCod_Matricula=@pCod_Matricula

select Nombre_Profesor,Materia from Tbl_Profesor,Tbl_Matricula
where Tbl_Matricula.ID_Profesor=Tbl_Profesor.ID_Profesor
and Cod_Matricula=@pCod_Matricula


GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_profesor]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_profesor]
@pID_Profesor nvarchar(10)
as 

if @pID_Profesor=''
	select * from Tbl_Profesor
else 
	select * from Tbl_Profesor
	where ID_Profesor=@pID_Profesor

GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_usuario]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_usuario]
@pID nvarchar(10)
as 

if @pID=''
	select * from Tbl_Ingreso
else 
	select * from Tbl_Ingreso
	where ID=@pID

GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_estudiante]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_eliminar_estudiante]
@pID_Estudiante nvarchar(10)
as 
	delete from Tbl_Estudiante where ID_Estudiante=@pID_Estudiante

GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_profesor]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_eliminar_profesor]
@pID_Profesor nvarchar(10)
as 
	delete from Tbl_Profesor where ID_Profesor=@pID_Profesor


GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_estudiante]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_estudiante]
@pID_Estudiante nvarchar(10),
@pNombre_Estudiante nvarchar(50),
@pCarrera nvarchar(50)
as
	if not exists (select ID_Estudiante from Tbl_Estudiante
	where  ID_Estudiante=@pID_Estudiante)
		insert into Tbl_Estudiante
		(ID_Estudiante,Nombre_Estudiante,Carrera)
		values
		(@pID_Estudiante,@pNombre_Estudiante,@pCarrera)
	else 
		update Tbl_Estudiante set Nombre_Estudiante= @pNombre_Estudiante,
		Carrera=@pCarrera
		where ID_Estudiante=@pID_Estudiante



GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_matricula]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_matricula]
@pCod_Matricula nvarchar(10),
@pFecha nvarchar(10),
@pSalon nvarchar(3),
@pID_Estudiante nvarchar(10),
@pID_Profesor  nvarchar(10),
@pValor int
as

	if not exists (select @pCod_Matricula from Tbl_Matricula where Cod_Matricula=@pCod_Matricula)
		insert into Tbl_Matricula(Cod_Matricula ,Fecha,Salon,ID_Estudiante,ID_Profesor,Valor) values (@pCod_Matricula ,@pFecha,@pSalon,@pID_Estudiante,@pID_Profesor,@pValor)
	else 
	update Tbl_Matricula set Fecha=@pFecha,Salon=@pSalon,ID_Estudiante=@pID_Estudiante,ID_Profesor=@pID_Profesor,Valor=@pValor where Cod_Matricula=@pCod_Matricula

GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_profesor]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_profesor]
@pID_Profesor nvarchar(10),
@pNombre_Profesor nvarchar(50),
@pMateria nvarchar(50)

as

	if not exists (select ID_Profesor from Tbl_Profesor
	where  ID_Profesor=@pID_Profesor)
		insert into Tbl_Profesor 
		(ID_Profesor,Nombre_Profesor,Materia)
		values
		(@pID_Profesor,@pNombre_Profesor, @pMateria)
	else 
		update Tbl_Profesor set Nombre_Profesor= @pNombre_Profesor,
		Materia=@pMateria
		where ID_Profesor=@pID_Profesor

GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_usuario]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_usuario]
@pID nvarchar(10),
@pUsuario nvarchar(50),
@pContraseña nvarchar(50)

as

	if not exists (select ID from Tbl_Ingreso
	where  ID=@pID)
		insert into Tbl_Ingreso 
		(ID,Usuario,Contraseña)
		values
		(@pID,@pUsuario, @pContraseña)
	else 
		update Tbl_Ingreso set Usuario= @pUsuario,
		Contraseña=@pContraseña
		where ID=@pID

GO
/****** Object:  StoredProcedure [dbo].[sp_ingreso_usuario]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ingreso_usuario]
@pUsuario nvarchar(50),
@pContrasena nvarchar(50)
as 

	select * from Tbl_Ingreso
	where Usuario=@pUsuario and Contrasena=@pContrasena
GO
/****** Object:  Table [dbo].[Tbl_Estudiante]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Estudiante](
	[ID_Estudiante] [nvarchar](10) NOT NULL,
	[Nombre_Estudiante] [nvarchar](50) NOT NULL,
	[Carrera] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tbl_Estudiante] PRIMARY KEY CLUSTERED 
(
	[ID_Estudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Ingreso]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Ingreso](
	[ID] [nvarchar](50) NOT NULL,
	[Usuario] [nvarchar](50) NOT NULL,
	[Contrasena] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tbl_Ingreso] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Matricula]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Matricula](
	[Cod_Matricula] [nvarchar](3) NOT NULL,
	[Fecha] [nvarchar](10) NOT NULL,
	[Salon] [nvarchar](3) NOT NULL,
	[ID_Estudiante] [nvarchar](10) NOT NULL,
	[ID_Profesor] [nvarchar](10) NOT NULL,
	[Valor] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_Matricula] PRIMARY KEY CLUSTERED 
(
	[Cod_Matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Profesor]    Script Date: 18/11/2019 09:57:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Profesor](
	[ID_Profesor] [nvarchar](10) NOT NULL,
	[Nombre_Profesor] [nvarchar](50) NOT NULL,
	[Materia] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tbl_Profesor] PRIMARY KEY CLUSTERED 
(
	[ID_Profesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Tbl_Estudiante] ([ID_Estudiante], [Nombre_Estudiante], [Carrera]) VALUES (N'1001685703', N'Wilches Hernandez', N'Comunicacion Social')
INSERT [dbo].[Tbl_Estudiante] ([ID_Estudiante], [Nombre_Estudiante], [Carrera]) VALUES (N'1001685706', N'Steven Florez', N'Ingenieria de Sistemas')
INSERT [dbo].[Tbl_Estudiante] ([ID_Estudiante], [Nombre_Estudiante], [Carrera]) VALUES (N'1001754241', N'Español Prez', N'Ingenieria industrial')
INSERT [dbo].[Tbl_Ingreso] ([ID], [Usuario], [Contrasena]) VALUES (N'1001685706', N'Steven.flores', N'789456')
INSERT [dbo].[Tbl_Ingreso] ([ID], [Usuario], [Contrasena]) VALUES (N'1001754241', N'Espa.Españolete', N'12304578')
INSERT [dbo].[Tbl_Ingreso] ([ID], [Usuario], [Contrasena]) VALUES (N'42745105', N'Hugo.mayo', N'456123')
INSERT [dbo].[Tbl_Ingreso] ([ID], [Usuario], [Contrasena]) VALUES (N'42772045', N'Walter.arbol', N'025874')
INSERT [dbo].[Tbl_Matricula] ([Cod_Matricula], [Fecha], [Salon], [ID_Estudiante], [ID_Profesor], [Valor], [Activo]) VALUES (N'001', N'06/11/2019', N'101', N'1001685706', N'42772045', 2000000, 1)
INSERT [dbo].[Tbl_Matricula] ([Cod_Matricula], [Fecha], [Salon], [ID_Estudiante], [ID_Profesor], [Valor], [Activo]) VALUES (N'002', N'13/11/2019', N'101', N'1001685703', N'42745105', 50000, 1)
INSERT [dbo].[Tbl_Matricula] ([Cod_Matricula], [Fecha], [Salon], [ID_Estudiante], [ID_Profesor], [Valor], [Activo]) VALUES (N'005', N'18/11/2019', N'101', N'1001754241', N'42772045', 2500000, 1)
INSERT [dbo].[Tbl_Profesor] ([ID_Profesor], [Nombre_Profesor], [Materia]) VALUES (N'42745105', N'Hugo Mayo', N'Lenguajes Expresivos')
INSERT [dbo].[Tbl_Profesor] ([ID_Profesor], [Nombre_Profesor], [Materia]) VALUES (N'42772045', N'Walter Arboleda', N'Teoria General de Sistemas')
ALTER TABLE [dbo].[Tbl_Matricula] ADD  CONSTRAINT [DF_Tbl_Matricula_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Tbl_Matricula]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Matricula_Tbl_Estudiante] FOREIGN KEY([ID_Estudiante])
REFERENCES [dbo].[Tbl_Estudiante] ([ID_Estudiante])
GO
ALTER TABLE [dbo].[Tbl_Matricula] CHECK CONSTRAINT [FK_Tbl_Matricula_Tbl_Estudiante]
GO
ALTER TABLE [dbo].[Tbl_Matricula]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Matricula_Tbl_Profesor] FOREIGN KEY([ID_Profesor])
REFERENCES [dbo].[Tbl_Profesor] ([ID_Profesor])
GO
ALTER TABLE [dbo].[Tbl_Matricula] CHECK CONSTRAINT [FK_Tbl_Matricula_Tbl_Profesor]
GO
USE [master]
GO
ALTER DATABASE [Universidad] SET  READ_WRITE 
GO
