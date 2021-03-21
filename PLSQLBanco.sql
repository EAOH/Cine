alter session set nls_date_format = 'yyyy-mm-dd'
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

/*Secuencia;*/
drop sequence Codigos;
/
create  sequence Codigos start with 1 increment by 1;
drop table T_Tarjeta;
/
create table T_Tarjeta(
Tar_Codigo int primary key,
Tar_Id varchar2(20) not null,
Tar_Nombre varchar2 (200) not null,
Tar_Direccion varchar2 (255) not null,
Tar_Nacido varchar2 (15) not null,
Tar_Sexo varchar2 (10) check( Tar_Sexo in ('Masculino','Femenino')) not null,
Tar_Saldo decimal (12,2) not null,
Tar_Coreo varchar2 (100),
Tar_Tel varchar2 (15),
Tar_Cel varchar2 (15),
Tar_Vence date not null,
Tar_Cod_Seg int not null,
Tar_Tipo varchar2 (10) check( Tar_Tipo in ('Credito','Debito')) not null
);

drop table T_Solicitudes;
/

create table T_Solicitudes(
Sol_Codigo int primary key,
Tar_Codigo int not null,
Sol_Descripcion varchar (50) not null,
Sol_Monto decimal (12,2) not null,
Sol_SaldoD decimal(12,2) not null,
Sol_SaldoU decimal (12,2) not null,
Sol_Fecha date not null,
foreign key (Tar_Codigo) references T_Tarjeta(Tar_Codigo)
);


insert into T_Tarjeta values ('1', '0801-1998-18003','Elio Hernandez','El Bosque','1998-09-19','Masculino','30000','EAOH@yahoo.com','2222-2222','9999-9999',To_Date('2022-01-01','yyyy-mm-dd'),'19981909','Debito');

insert into T_Tarjeta values ('2', '0801-1998-18003','Elio Hernandez','El Bosque','1998-09-19','Masculino','100000','EAOH@yahoo.com','2222-2222','9999-9999',To_Date('2022-01-01','yyyy-mm-dd'),'19981909','Credito');

insert into T_Solicitudes values (Codigos.nextval,'1','Deposito de mil lempiras','1000','29000','30000',sysdate);


insert into T_Solicitudes values (Codigos.nextval,'2','Retiro de mil lempiras','1000','101000','100000',sysdate);

commit;
/
create or replace view Ver_Tarjetas as (select * from T_Tarjeta);
/
create or replace view Ver_Solicitudes as (select T_SOLICITUDES.TAR_CODIGO, T_TARJETA.TAR_ID, T_TARJETA.TAR_NOMBRE, T_TARJETA.TAR_VENCE,
 T_TARJETA.TAR_TIPO,T_SOLICITUDES.SOL_CODIGO, T_SOLICITUDES.SOL_DESCRIPCION, T_SOLICITUDES.SOL_MONTO,T_SOLICITUDES.SOL_SALDOD,
  T_SOLICITUDES.SOL_SALDOU,T_SOLICITUDES.SOL_FECHA 
  from T_Solicitudes inner join T_Tarjeta on T_SOLICITUDES.TAR_CODIGO=T_TARJETA.TAR_CODIGO );
/

select * from ver_Tarjetas;

select * from ver_Solicitudes;

create or replace trigger Registro after Update on T_Tarjeta for each row
begin
if :old.Tar_Saldo>:new.Tar_Saldo then
insert into T_Solicitudes values (Codigos.nextval,:old.Tar_Codigo ,'Retiro',:old.Tar_Saldo-:new.Tar_Saldo,:old.Tar_Saldo,:new.Tar_Saldo,sysdate);
end if;
if :old.Tar_Saldo<:new.Tar_Saldo then
insert into T_Solicitudes values (Codigos.nextval,:old.Tar_Codigo ,'Deposito',:new.Tar_Saldo-:old.Tar_Saldo,:old.Tar_Saldo,:new.Tar_Saldo,sysdate);
end if;
end;

