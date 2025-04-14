--Создание таблиц
CREATE TABLE transactions_v2 (transaction_id int, user_id int, amount double, currency string,transaction_date timestamp,is_fraud boolean)  
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
CREATE TABLE logs_v2 (log_id int, transaction_id int, category string, comment string, log_timestamp string) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;

-- Заполнение провел через Спарк, ниже - агрегации:

-- Разбивка по валютам
SELECT currency, sum(amount)
FROM transactions_v2
WHERE currency != '???'
GROUP BY currency; 

-- Сумма всех транзакций, помеченный фродом
SELECT count(*)
FROM transactions_v2
WHERE is_fraud = 1

-- Сумма всех транзакций ПО МЕСЯЦАМ
SELECT year(transaction_date), month(transaction_date), sum(amount)
FROM transactions_v2
GROUP BY year(transaction_date), month(transaction_date)

-- Средняя сумма транзакций в день за последние 30 дней
SELECT avg(averages.AverageADay)
FROM (
  SELECT avg(amount) AS AverageADay
  FROM transactions_v2
  WHERE date_sub(from_unixtime(unix_timestamp()), 30) < transaction_date
  GROUP BY year(transaction_date), month(transaction_date), day(transaction_date)
  ) averages;
