-- Databricks notebook source
WITH CORE AS(
SELECT
  idPedido
  ,idCliente
  ,dtEntregue
  ,datediff(year,dtEntregue,current_date) as qtd_dias_apos_entrega
FROM silver_olist.pedido
),
REGRA AS(
SELECT
idPedido,
CASE WHEN qtd_dias_apos_entrega >=5 then 'ready to change' else 'not ready for change' end as status
FROM CORE
)

SELECT * except(REGRA.idPedido) FROM CORE LEFT JOIN REGRA ON REGRA.idPedido = CORE.idPedido
