
alter session set nls_date_format = 'yyyy-mm-dd hh24:mi';
/

/*obtener las tablas
SELECT * FROM (
SELECT 'DROP TABLE '||table_name||' CASCADE CONSTRAINTS;' FROM user_tables UNION
SELECT 'DROP VIEW '||VIEW_NAME||';' FROM user_views UNION
SELECT 'DROP SEQUENCE '|| SEQUENCE_NAME||';' FROM user_sequences UNION
SELECT 'DROP SYNONYM ' || SYNONYM_NAME ||';' FROM user_synonyms UNION
SELECT 'DROP FUNCTION ' || OBJECT_NAME ||';' FROM user_procedures UNION
SELECT 'PURGE RECYCLEBIN;' FROM dual)
ORDER BY 1 ASC;*/


DROP SEQUENCE Codigos;


DROP TABLE T_DETALLE CASCADE CONSTRAINTS;

DROP TABLE T_CINE CASCADE CONSTRAINTS;

DROP TABLE T_EMPLEADO CASCADE CONSTRAINTS;

DROP TABLE T_EXHIBICION CASCADE CONSTRAINTS;

DROP TABLE T_FACTURA CASCADE CONSTRAINTS;

DROP TABLE T_OCUPADAS CASCADE CONSTRAINTS;

DROP TABLE T_PELICULA CASCADE CONSTRAINTS;

DROP TABLE T_PRECIO CASCADE CONSTRAINTS;

DROP TABLE T_SALA CASCADE CONSTRAINTS;

DROP TABLE T_SILLA CASCADE CONSTRAINTS;

DROP TABLE T_UBICACION CASCADE CONSTRAINTS;

PURGE RECYCLEBIN;

/*Secuencia;*/
create  sequence Codigos start with 1 increment by 1;

/*CINE*/
create table T_Cine(
Cin_Codigo int primary key,
Cin_Nombre varchar2 (50) not null,
Cin_Logo varchar2 (3000) not null,
Cin_Mision varchar2 (100) not null,
Cin_Vision varchar2 (100) not null,
Cin_Fundacion varchar2(15) not null);
/

/*UBICACION*/
create table T_Ubicacion(
Ubi_Codigo int primary key,
Cin_Codigo int not null,
Ubi_Ubicacion varchar2 (255) not null,
Ubi_Nombre varchar2 (50) not null,
Ubi_Fundado varchar2(15) not null,
foreign key (Cin_Codigo) references T_Cine (Cin_Codigo) on delete cascade);



/*Sala*/
create table T_Sala(
Sal_Codigo int primary key,
Ubi_Codigo int not null,
Sal_Nombre varchar2 (50) not null,
Sal_Descripcion varchar2 (200) not null,
Sal_Formato varchar2 (50) check (Sal_Formato in ('2D','3D','4D','Estreno','Privada')) not null,
foreign key (Ubi_Codigo) references T_Ubicacion (Ubi_Codigo) on delete cascade);



/*Sillas*/
create table T_Silla(
Sal_Codigo int not null,
Sil_Fila int not null,
Sil_Cantidad int not null,
primary key (Sal_Codigo,Sil_Fila),
foreign key (Sal_Codigo) references T_Sala (Sal_Codigo) on delete cascade);


/*Empleado*/
create table T_Empleado(
Emp_Codigo int primary key,
Emp_Id varchar2(20) unique not null,
Emp_Nombre1 varchar2 (50) not null,
Emp_Nombre2 varchar2 (50),
Emp_Apellido1 varchar2 (50) not null,
Emp_Apellido2 varchar2 (50),
Emp_Direccion varchar2 (255) not null,
Emp_Nacido varchar2 (15) not null,
Emp_Sexo varchar2 (10) check( Emp_Sexo in ('Masculino','Femenino')) not null,
Emp_Contrato varchar2 (10) not null,
Emp_Puesto varchar2 (10) check (Emp_Puesto in ('Empleado','Gerente')) not null,
Emp_Sueldo decimal (12,2) not null,
Emp_Correo varchar2 (100),
Emp_Tel varchar2 (15),
Emp_Cel varchar2 (15),
Emp_Usuario varchar2 (50) unique not null,
Emp_Password varchar2 (50) not null);


/*Pelicula*/
create table T_Pelicula(
Pel_Codigo int primary key,
Pel_Cartelera varchar2(255) not null,
Pel_Titulo varchar2 (50) not null,
Pel_Sinopsis varchar2 (200) not null,
Pel_Generos varchar2 (100) not null,
Pel_Audio varchar2 (50) not null,
Pel_Director varchar2 (100) not null,
Pel_Subtitulos varchar2 (50) not null,
Pel_Estreno varchar2(15) not null,
Pel_Duracion varchar2 (50) not null,
Pel_Trailer varchar2 (255) not null,
Pel_Formato varchar2 (5) check (Pel_Formato in ('2D','3D','4D')) not null,
Pel_EdadMin int not null,
Pel_Calificacion int);
/

/*Precio*/
create table T_Precio(
Pre_Codigo int primary key,
Cin_Codigo int not null,
Pre_Descripcion varchar2 (50) not null,
Pre_Edad_Min int,
Pre_Edad_Max int,
Pre_Precio decimal (12,2) not null,
Pre_Formato varchar2 (5) check (Pre_Formato in ('2D','3D','4D')) not null,
foreign key (Cin_Codigo) references T_Cine (Cin_Codigo) on delete cascade);


/*Exhibicion*/
create table T_Exhibicion(
Exh_Codigo int primary key,
Sal_Codigo int not null,
Pel_Codigo int not null,
Exh_Fecha date not null,
foreign key (Sal_Codigo) references T_Sala (Sal_Codigo) on delete cascade,
foreign key (Pel_Codigo) references T_Pelicula (Pel_Codigo) on delete cascade);

/*Factura*/
create table T_Factura(
Sal_Codigo int not null,
Fac_Codigo int primary key,
Pel_Codigo int not null,
Fac_Fecha date not null,
Fac_Total decimal (12,2) not null,
Fac_Correo varchar2 (100) not null,
Fac_Cel varchar2 (15),
Fac_Id varchar2 (20) not null,
Fac_Nombre varchar2 (200) not null,
foreign key (Sal_Codigo) references T_Sala (Sal_Codigo) on delete cascade,
foreign key (Pel_Codigo) references T_Pelicula (Pel_Codigo) on delete cascade);


/*En Uso*/
create table T_Ocupadas(
Exh_Codigo int not null,
Fac_Codigo int not null,
EnUs_Fila int not null,
EnUs_Columna int not null,
primary key (Exh_Codigo, EnUs_Fila, EnUs_Columna),
foreign key (Exh_Codigo) references T_Exhibicion (Exh_Codigo) on delete cascade,
foreign key (Fac_Codigo) references T_Factura (Fac_Codigo) on delete cascade);

/*Detalle Factura*/
create table T_Detalle (
Fac_Codigo int not null,
Pre_Codigo int not null,
DeFa_Cantidad int not null,
DeFa_Subtotal decimal (12,2) not null,
primary key (Fac_Codigo,Pre_Codigo),
foreign key (Fac_Codigo) references T_Factura (Fac_Codigo) on delete cascade,
foreign key (Pre_Codigo) references T_Precio (Pre_Codigo) on delete cascade);


insert into T_Empleado values(Codigos.nextval,'0801-1998-18003','Elio',null,'Hernandez',null,'El bosque','1998-09-19','Masculino','2020-11-18','Empleado',25000.00,
'elio1998@unitec.edu','No tengo','Tampoco','elio1998','3572e6f96d02fd8b377a74cfb5546910');

insert into T_Empleado values(Codigos.nextval,'0801-1998-180030','Alexandro',null,'Hernandez',null,'El bosque','1998-09-19','Masculino','2020-11-18','Gerente',25000.00,
'eaoh@yahoo.com','No tengo','Tampoco','EAOH','f7b4ef1237ec2f85a9117a2ec695f6ae');

insert into T_Cine values (Codigos.nextval, 'Cinepolis','https://assets.stickpng.com/images/5ef1c45d1cfbc200047e7424.png','No se','Tampoco','2020-11-27');

insert into T_Cine values (Codigos.nextval, 'CineMax','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Cinemax_LA.png/800px-Cinemax_LA.png','No se','Tampoco','2020-11-27');

insert into T_Ubicacion values(Codigos.nextval,'3','(14.074172,-87.200231)','Cinepolis - Miraflores TGU','2020-11-27');

insert into T_Ubicacion values(Codigos.nextval,'4','(14.061983,-87.220769)','Cinemark - City Mall TGU','2020-11-27');

insert into T_Sala values (Codigos.nextval,'5','Sala1','Sala1','2D');

insert into T_Sala values (Codigos.nextval,'6','Sala1','Sala1','3D');

insert into T_Silla values ('7','1','15');
insert into T_Silla values ('7','2','15');
insert into T_Silla values ('7','3','15');
insert into T_Silla values ('7','4','20');
insert into T_Silla values ('7','5','20');
insert into T_Silla values ('7','6','20');
insert into T_Silla values ('7','7','20');
insert into T_Silla values ('7','8','25');
insert into T_Silla values ('7','9','25');
insert into T_Silla values ('7','10','25');

insert into T_Silla values ('8','1','15');
insert into T_Silla values ('8','2','15');
insert into T_Silla values ('8','3','15');
insert into T_Silla values ('8','4','20');
insert into T_Silla values ('8','5','20');
insert into T_Silla values ('8','6','20');
insert into T_Silla values ('8','7','20');
insert into T_Silla values ('8','8','25');
insert into T_Silla values ('8','9','25');
insert into T_Silla values ('8','10','25');

insert into T_Pelicula values (Codigos.nextval,'https://cinemarkmedia.modyocdn.com/ca/300x400/231217.jpg?version=1607004000000',
'Sueños S.A','La historia de Minna, una joven que hace mal uso de su nueva habilidad para crear y controlar los ideales de otras personas para mostrar a su molesta hermanastra una leccion.',
'Animacion, Aventura','Español','Kim Hagen Jensen','No','2020-12-03','85min','https://www.youtube.com/watch?v=mIWoqFmVjDw','3D','0','2');

insert into T_Pelicula values (Codigos.nextval,'https://cinemarkmedia.modyocdn.com/ca/300x400/231237.jpg?version=1607004000000',
'Apocalipsis Zombie','Luego de un mortal brote viral, un grupo elite de soldados de fuerzas especiales deben infiltrarse en una zona de cuarentena para rescatar al investigador que tiene la cura para salvar la humanidad.',
'Accion','Español','Chee Cheung','No','2020-12-03','115min','https://www.youtube.com/watch?v=Hja9KTJuScw','2D','18','0');

insert into T_Precio values (Codigos.nextval,'3','Adultos','18','40','97.00','3D');

insert into T_Precio values (Codigos.nextval,'4','Adultos','18','40','49.00','2D');

insert into T_Exhibicion values (Codigos.nextval,'7','9','2021-01-01 00:01');

insert into T_Exhibicion values (Codigos.nextval,'8','10','2021-01-01 00:01');

insert into T_Factura values ('7', Codigos.nextval,'9',sysdate,'100','EAOH@yahoo.com','9999-9999','0801199818003','Elio');

insert into T_Factura values ('8', Codigos.nextval,'10',sysdate,'100','EAOH@yahoo.com','9999-9999','0801199818003','Elio');

insert into T_Ocupadas values ('13','15','1','0');
insert into T_Ocupadas values ('13','15','1','1');

insert into T_Ocupadas values ('14','16','1','0');
insert into T_Ocupadas values ('14','16','1','1');

commit;
/

/*Vistas*/
CREATE or replace VIEW ver_Empleado as (select * from T_Empleado);
/
create or replace view ver_Cine as (select * from T_Cine);
/
create or replace view ver_Ubicacion as (select T_UBICACION.UBI_CODIGO , T_UBICACION.CIN_CODIGO , T_CINE.CIN_NOMBRE ,
 T_UBICACION.UBI_UBICACION, T_UBICACION.UBI_NOMBRE, T_UBICACION.UBI_FUNDADO 
 from T_Ubicacion inner join T_Cine on T_UBICACION.CIN_CODIGO= T_CINE.CIN_CODIGO);
/
create or replace view Login as (SELECT Emp_Puesto as Puesto,Emp_Usuario as Usuario,Emp_Password as Clave FROM T_Empleado);
/

CREATE or replace VIEW ver_Sala as (select T_SALA.UBI_CODIGO, T_UBICACION.UBI_NOMBRE, T_SALA.SAL_CODIGO, T_SALA.SAL_NOMBRE,
T_SALA.SAL_DESCRIPCION, T_SALA.SAL_FORMATO from T_Sala inner join T_Ubicacion on T_Sala.Ubi_Codigo= T_UBICACION.UBI_CODIGO );
/

CREATE or replace VIEW ver_Silla as (select * from T_Silla);
/

CREATE or replace VIEW ver_Pelicula as (select * from T_Pelicula);
/

create or replace view ver_Precios as (select T_PRECIO.PRE_CODIGO, T_PRECIO.CIN_CODIGO,T_CINE.CIN_NOMBRE ,T_PRECIO.PRE_DESCRIPCION,
T_PRECIO.PRE_EDAD_MIN,T_PRECIO.PRE_EDAD_MAX,T_PRECIO.PRE_PRECIO,T_Precio.Pre_Formato 
 from T_Precio inner join T_Cine on T_PRECIO.CIN_CODIGO= T_CINE.CIN_CODIGO);
/

create or replace view ver_Presentaciones as (select T_EXHIBICION.EXH_CODIGO, T_CINE.CIN_CODIGO, T_CINE.CIN_NOMBRE,
 T_UBICACION.UBI_CODIGO, T_UBICACION.UBI_NOMBRE, T_SALA.SAL_CODIGO, T_SALA.SAL_NOMBRE,
 T_PELICULA.PEL_CODIGO, T_PELICULA.PEL_TITULO,T_PELICULA.PEL_CARTELERA , T_PELICULA.PEL_FORMATO, T_EXHIBICION.EXH_FECHA 
 from T_exhibicion inner join T_Pelicula on T_EXHIBICION.PEL_CODIGO=T_PELICULA.PEL_CODIGO 
 inner join T_Sala on T_EXHIBICION.SAL_CODIGO=T_SALA.SAL_CODIGO 
 inner join T_Ubicacion on  T_SALA.UBI_CODIGO=T_UBICACION.UBI_CODIGO 
 inner join T_Cine on T_UBICACION.CIN_CODIGO=T_CINE.CIN_CODIGO);
/

create or replace view ver_Ocupadas as (select * from T_Ocupadas);
/

create or replace view ver_Factura as (select * from T_Factura);
/

create or replace view ver_Detalle as (select T_DETALLE.FAC_CODIGO, T_FACTURA.FAC_ID, T_FACTURA.FAC_NOMBRE, T_DETALLE.PRE_CODIGO, T_PRECIO.CIN_CODIGO
 ,T_CINE.CIN_NOMBRE,T_PRECIO.PRE_FORMATO, T_PRECIO.PRE_DESCRIPCION, T_PRECIO.PRE_EDAD_MIN , T_PRECIO.PRE_EDAD_MAX , T_PRECIO.PRE_PRECIO,
 T_DETALLE.DEFA_CANTIDAD, T_DETALLE.DEFA_SUBTOTAL  from T_Detalle inner join T_Factura on T_DETALLE.FAC_CODIGO=T_FACTURA.FAC_CODIGO inner join
 T_Precio on T_DETALLE.PRE_CODIGO= T_PRECIO.PRE_CODIGO inner join T_Cine on T_PRECIO.CIN_CODIGO= T_CINE.CIN_CODIGO );
/

select * from ver_Empleado;
select * from Ver_Cine;
select * from Ver_Ubicacion;
select * from ver_Sala;
select * from ver_Silla;
select * from ver_Pelicula;
select * from ver_Precios;
select * from ver_Presentaciones;
select * from ver_Ocupadas;
select * from ver_Factura;
select * from ver_Detalle;

select distinct VER_SILLA.SAL_CODIGO,VER_SILLA.SIL_FILA, VER_SILLA.SIL_CANTIDAD,
(select distinct listagg(VER_OCUPADAS.ENUS_COLUMNA,';') within group(order by VER_OCUPADAS.ENUS_COLUMNA)over (partition by VER_OCUPADAS.EXH_CODIGO )
from VER_OCUPADAS where VER_SILLA.SIL_FILA= VER_OCUPADAS.ENUS_FILA and VER_PRESENTACIONES.EXH_CODIGO=VER_OCUPADAS.EXH_CODIGO)
from ver_Silla inner join ver_Presentaciones on VER_SILLA.SAL_CODIGO=VER_PRESENTACIONES.SAL_CODIGO left join ver_Ocupadas 
on VER_PRESENTACIONES.EXH_CODIGO=VER_OCUPADAS.EXH_CODIGO where VER_SILLA.SAL_CODIGO='7' order by VER_SILLA.SAL_CODIGO,VER_SILLA.SIL_FILA asc ;

select VER_CINE.CIN_NOMBRE, VER_UBICACION.CIN_CODIGO, VER_UBICACION.UBI_NOMBRE,VER_UBICACION.UBI_UBICACION , VER_SALA.UBI_CODIGO, VER_SALA.SAL_NOMBRE, VER_FACTURA.SAL_CODIGO,
VER_FACTURA.FAC_CODIGO, VER_PELICULA.PEL_TITULO, VER_PELICULA.PEL_FORMATO ,VER_FACTURA.PEL_CODIGO,VER_FACTURA.FAC_FECHA,VER_FACTURA.FAC_TOTAL,
VER_FACTURA.FAC_ID, VER_FACTURA.FAC_NOMBRE from Ver_Factura inner join Ver_Sala on VER_FACTURA.SAL_CODIGO=VER_SALA.SAL_CODIGO
inner join VER_UBICACION on VER_SALA.UBI_CODIGO= VER_UBICACION.UBI_CODIGO inner join Ver_Cine on VER_UBICACION.CIN_CODIGO=VER_CINE.CIN_CODIGO
inner join Ver_Pelicula on VER_FACTURA.PEL_CODIGO= VER_PELICULA.PEL_CODIGO;

select VER_DETALLE.PRE_CODIGO, VER_PRECIOS.PRE_DESCRIPCION, VER_PRECIOS.PRE_EDAD_MIN, VER_PRECIOS.PRE_EDAD_MAX, VER_PRECIOS.PRE_PRECIO, 
VER_DETALLE.DEFA_CANTIDAD, VER_DETALLE.DEFA_SUBTOTAL from Ver_Detalle inner join Ver_Precios on VER_DETALLE.PRE_CODIGO=VER_PRECIOS.PRE_CODIGO;

select VER_OCUPADAS.EXH_CODIGO, VER_PRESENTACIONES.EXH_FECHA,VER_OCUPADAS.ENUS_FILA, VER_OCUPADAS.ENUS_COLUMNA 
from Ver_Ocupadas inner join Ver_Presentaciones on VER_OCUPADAS.EXH_CODIGO=VER_PRESENTACIONES.EXH_CODIGO where VER_OCUPADAS.FAC_CODIGO='';

select Sum(VER_FACTURA.FAC_TOTAL) from Ver_Factura;
/

commit;
/