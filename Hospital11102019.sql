USE [master]
GO
/****** Object:  Database [Hospital]    Script Date: 11/10/2019 11:29:29 ******/
CREATE DATABASE [Hospital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hospital', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.INGENIERIA\MSSQL\DATA\Hospital.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Hospital_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.INGENIERIA\MSSQL\DATA\Hospital_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Hospital] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hospital].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hospital] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hospital] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hospital] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Hospital] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hospital] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hospital] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hospital] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hospital] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hospital] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hospital] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hospital] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hospital] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hospital] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hospital] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hospital] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hospital] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hospital] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hospital] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hospital] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hospital] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hospital] SET  MULTI_USER 
GO
ALTER DATABASE [Hospital] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hospital] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hospital] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hospital] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Hospital]
GO
/****** Object:  StoredProcedure [dbo].[eliminar_medico]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[eliminar_medico]
@pId_Medico nvarchar (10)
as
	delete from Tbl_Medico where Id_Medico=@pId_Medico
GO
/****** Object:  StoredProcedure [dbo].[sp_anular_cita]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_anular_cita]
@pCod_Cita nvarchar (10)
as
  update Tbl_Cita set Activo=0
  where Cod_Cita=@pCod_Cita


GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_medico]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_medico]
@pId_Medico nvarchar (10)
as
	if @pId_Medico=''	
		select * from Tbl_Medico
	else
		select * from Tbl_Medico
		where Id_Medico=@pId_Medico
GO
/****** Object:  StoredProcedure [dbo].[sp_consultar_paciente]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_consultar_paciente]
@pId_Paciente nvarchar (10)
as
	if @pId_Paciente=''	
		select * from Tbl_Paciente
	else
		select * from Tbl_Paciente
		where Id_Paciente=@pId_Paciente

GO
/****** Object:  StoredProcedure [dbo].[sp_conultar_cita]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[sp_conultar_cita]
@pCod_Cita nvarchar(10)
as
select * from Tbl_Cita where Cod_Cita=@pCod_Cita
select Nom_paciente,tel_paciente from Tbl_Paciente,Tbl_Cita
where Tbl_Cita.Id_Paciente=Tbl_Paciente.Id_Paciente
and Cod_Cita=@pCod_Cita

select Nom_Medico, Especialidad from Tbl_Medico,Tbl_Cita
where Tbl_Cita.Id_Medico=Tbl_Medico.Id_Medico
and Cod_Cita=@pCod_Cita
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_paciente]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_eliminar_paciente]
@pId_Paciente nvarchar (10)
as
	delete from Tbl_Paciente where Id_Paciente=@pId_Paciente


GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_cita]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_cita]
@pCod_Cita nvarchar(10),
@pFecha nvarchar(10),
@pHora nvarchar(10),
@pConsultorio nvarchar(3),
@pId_Paciente nvarchar(10),
@pId_Medico nvarchar(10),
@pValor int,
@pObservaciones nvarchar(MAX)
as
	if not exists (select @pCod_Cita from Tbl_Cita where Cod_Cita=@pCod_Cita)
		insert into Tbl_Cita (Cod_Cita,Fecha, Hora, Consultorio, Id_Paciente, Id_Medico,
		Valor, Observaciones) values (@pCod_Cita ,@pFecha, @pHora, @pConsultorio, @pId_Paciente, @pId_Medico,
		@pValor, @pObservaciones)
	else
		update Tbl_Cita set Fecha=@pFecha, Hora=@pHora, Consultorio=@pConsultorio,Id_Paciente=@pId_Paciente, Id_Medico=@pId_Medico, Valor=@pValor,
		Observaciones=@pObservaciones where Cod_Cita=Cod_Cita


GO
/****** Object:  StoredProcedure [dbo].[sp_guardar_medico]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_guardar_medico]
@pId_Medico nvarchar(10),
@pNom_Medico nvarchar(50),
@pEspecialidad nvarchar (30)
as
	if not exists (select Id_Medico from Tbl_Medico
	where Id_Medico=@pId_Medico)
		insert into Tbl_Medico
		(Id_Medico,Nom_Medico,Especialidad)
		values
		(@pId_Medico,@pNom_Medico,@pEspecialidad)
	else
	update Tbl_Medico set Nom_Medico=@pNom_Medico,
	Especialidad=@pEspecialidad
	where Id_Medico=@PId_Medico

GO
/****** Object:  StoredProcedure [dbo].[sp_Guardar_paciente]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Guardar_paciente]
@pId_Paciente nvarchar(10),
@pNom_paciente nvarchar(50),
@pDir_paciente nvarchar (50),
@ptel_paciente nvarchar (10)
as
	if not exists (select Id_Paciente from Tbl_paciente
	where Id_Paciente=@pId_Paciente)
		insert into Tbl_Paciente
		(Id_Paciente,Nom_paciente,Dir_paciente,tel_paciente)
		values
		(@pId_Paciente,@pNom_paciente,@pDir_paciente,@ptel_paciente)
	else
	update Tbl_Paciente set Nom_paciente=@pNom_paciente,
	Dir_paciente=@pDir_paciente,tel_paciente=@ptel_paciente
	where Id_Paciente=@pId_Paciente	
GO
/****** Object:  Table [dbo].[Tbl_Cita]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Cita](
	[Cod_Cita] [nvarchar](10) NOT NULL,
	[Fecha] [nvarchar](10) NOT NULL,
	[Hora] [nvarchar](10) NOT NULL,
	[Consultorio] [nvarchar](3) NOT NULL,
	[Id_Paciente] [nvarchar](10) NOT NULL,
	[Id_Medico] [nvarchar](10) NOT NULL,
	[Valor] [int] NOT NULL,
	[Observaciones] [nvarchar](max) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_Cita] PRIMARY KEY CLUSTERED 
(
	[Cod_Cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Medico]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Medico](
	[Id_Medico] [nvarchar](10) NOT NULL,
	[Nom_Medico] [nvarchar](50) NOT NULL,
	[Especialidad] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Tbl_Medico] PRIMARY KEY CLUSTERED 
(
	[Id_Medico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Paciente]    Script Date: 11/10/2019 11:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Paciente](
	[Id_Paciente] [nvarchar](10) NOT NULL,
	[Nom_paciente] [nvarchar](50) NOT NULL,
	[Dir_paciente] [nvarchar](50) NOT NULL,
	[tel_paciente] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id_Paciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Tbl_Paciente] ([Id_Paciente], [Nom_paciente], [Dir_paciente], [tel_paciente]) VALUES (N'1001622', N'Valentina Fernandez', N'Calle 12 01-03', N'3014857414')
INSERT [dbo].[Tbl_Paciente] ([Id_Paciente], [Nom_paciente], [Dir_paciente], [tel_paciente]) VALUES (N'1001685', N'Pedro Felipe', N'Cra 49 84-19', N'2775041')
INSERT [dbo].[Tbl_Paciente] ([Id_Paciente], [Nom_paciente], [Dir_paciente], [tel_paciente]) VALUES (N'1001692', N'Conejo Malo', N' Cra 45 24-75', N'2775496')
INSERT [dbo].[Tbl_Paciente] ([Id_Paciente], [Nom_paciente], [Dir_paciente], [tel_paciente]) VALUES (N'40404040', N'Benito Camelas', N'calle 110 49-61', N'5555555')
ALTER TABLE [dbo].[Tbl_Cita] ADD  CONSTRAINT [DF_Tbl_Cita_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Tbl_Cita]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Cita_Tbl_Medico1] FOREIGN KEY([Id_Medico])
REFERENCES [dbo].[Tbl_Medico] ([Id_Medico])
GO
ALTER TABLE [dbo].[Tbl_Cita] CHECK CONSTRAINT [FK_Tbl_Cita_Tbl_Medico1]
GO
ALTER TABLE [dbo].[Tbl_Cita]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Cita_TblPaciente] FOREIGN KEY([Id_Paciente])
REFERENCES [dbo].[Tbl_Paciente] ([Id_Paciente])
GO
ALTER TABLE [dbo].[Tbl_Cita] CHECK CONSTRAINT [FK_Tbl_Cita_TblPaciente]
GO
USE [master]
GO
ALTER DATABASE [Hospital] SET  READ_WRITE 
GO
