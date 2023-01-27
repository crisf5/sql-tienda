
-- Database: Mysql --

-- Autor: Cristian Fernandez --


-- Todos los productos del rubro "libreria", creados hoy --

select p.nombre, p.fecha_creacion, r.rubro
from producto p 
join rubro r on p.id_rubro = r.id_rubro 
where r.rubro = "libreria" and p.fecha_creacion = curdate();


-- Monto total vendido por cliente (Mostrar nombre del cliente y monto) -- 

select c.nombre, c.apellido, sum(v.cantidad*v.precio_unitario) as "monto_total"
from cliente c 
join venta v on c.id_cliente = v.id_cliente
group by v.id_cliente;


-- Cantidad de ventas por producto --

select p.nombre, count(v.cantidad) as "ventas_por_producto" 
from producto p 
join venta v on p.codigo = v.codigo_producto 
group by p.nombre; 


-- Cantidad de productos comprados por cliente en el mes actual --

select c.nombre , c.apellido , count(v.cantidad) as cantidad_producto
from cliente c 
join venta v on c.id_cliente = v.id_cliente 
where month(v.fecha) = month(curdate()) and year(v.fecha) = year(curdate())
group by c.id_cliente ;


-- Ventas que tiene al menos un producto en el rubro bazar --

select r.rubro , v.id_venta 
from venta v 
join producto p on p.codigo = v.codigo_producto 
join rubro r on r.id_rubro = p.id_rubro 
where r.rubro = "bazar";


-- Rubros que no tienen ventas en los ultimos 2 meses -- 

select distinct r.rubro 
from rubro r 
join producto p on p.id_rubro = r.id_rubro 
join venta v on v.codigo_producto = p.codigo 
where v.fecha < (curdate() - interval 2 month)
and r.rubro not in(
	select r.rubro
    from rubro r
    join producto p on p.id_rubro = r.id_rubro 
    join venta v on v.codigo_producto = p.codigo 
    where v.fecha >= (curdate() - interval 2 month));
    
    





