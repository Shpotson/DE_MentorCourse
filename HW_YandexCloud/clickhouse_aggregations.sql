CREATE TABLE main.orders (
    order_id bigint,
    user_id bigint,
    order_date timestamp,
    total_amount double,
    payment_status text)
ENGINE=MergeTree
ORDER BY (order_id);

CREATE TABLE main.order_items (
    item_id bigint,
    order_id bigint,
    product_name text,
    product_price double,
    quantity int)
ENGINE=MergeTree
ORDER BY (item_id);

--Данные были заполнены через датагрип

--Агрегации:
SELECT payment_status, sum(total_amount), count(*)
FROM main.orders
WHERE order_date > date_sub(MONTH, 36, now())
GROUP BY payment_status;
-- Количество и тоталы по всем заказам по конкретным статусам за 3 прошедших года

SELECT user_id, sum(total_amount), count(*)
FROM main.orders
WHERE order_date > date_sub(MONTH, 36, now())
GROUP BY user_id
ORDER BY sum(total_amount)
LIMIT 1;
--Самый прибыльный клиент и сумма всех его заказов. И количество его заказов бонусом бонусом

SELECT order_id, count(*)
FROM main.orders
JOIN main.order_items oi on orders.order_id = oi.order_id
GROUP BY order_id
--Количества айтемов в заказах

SELECT count(*) as order_count_by_items_amount, order_item_count.items_count as items_amount
FROM (
    SELECT order_id, count(*) as items_count
    FROM main.orders
    JOIN main.order_items oi on orders.order_id = oi.order_id
    GROUP BY order_id
    ) order_item_count
GROUP BY order_item_count.items_count
-- Количество заказов с различным количеством айтемов.

SELECT
    toYYYYMMDD(order_date),
    avg(total_amount) as average_order_price,
    sum(total_amount) as total_orders_sum,
    count(*) as total_orders_count
FROM main.orders
GROUP BY toYYYYMMDD(order_date)
ORDER BY average_order_price
-- Распределение по прибыльности дней (тут средняя сумма заказа, тотал по всем заказам и кол-во заказов за каждый день)
