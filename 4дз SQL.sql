Задание 1: Ранжирование продуктов по средней цене
Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). Используйте таблицы OrderDetails и Products.
Результат: В результате запроса будут следующие столбцы:
● CategoryID: идентификатор категории продукта,
● ProductID: идентификатор продукта,
● ProductName: название продукта,
● AvgPrice: средняя цена продукта,
● ProductRank: ранг продукта внутри своей категории на основе средней цены в
порядке убывания.
Подсказка:
1. Рассчитайте среднюю цену продукта: Начните с создания подзапроса (или
CTE), в котором будете вычислять среднюю цену (AVG(Price)) для каждого
продукта. Объедините таблицы OrderDetails и Products с помощью JOIN.
2. Ранжируйте продукты по средней цене: Используйте оконную функцию
RANK() для ранжирования продуктов по средней цене внутри каждой
категории. Убедитесь, что вы применяете PARTITION BY для разделения по
категориям и ORDER BY для упорядочивания по убыванию средней цены.

WITH ProductAvgPrice AS (
SELECT 
p.CategoryID,
p.ProductID,
p.ProductName,
AVG(p.Price) AS AvgPrice
FROM OrderDetails od 
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductID
)
SELECT
CategoryID,
ProductID,
ProductName,
AvgPrice,
RANK() OVER (PARTITION BY CategoryID ORDER BY AvgPrice DESC) AS
ProductRank
FROM ProductAvgPrice;

Задание 2: Средняя и максимальная сумма кредита по месяцам
Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого
кластера в каждом месяце и сравните её с максимальной суммой кредита
(MaxCreditAmount) за тот же месяц. Используйте таблицу Clusters.
Подсказка:
1. Рассчитайте среднюю сумму кредита: Используйте подзапрос (или CTE) для
вычисления средней суммы кредита (AVG(credit_amount)) для каждого
кластера в каждом месяце.
2. Рассчитайте максимальную сумму кредита: Создайте другой подзапрос для
вычисления максимальной суммы кредита (MAX(credit_amount)) для каждого
месяца.
3. Объедините результаты: Используйте JOIN для объединения результатов
двух подзапросов по месяцу и выведите нужные столбцы.

--SELECT 
--c."month", 
--c.cluster ,
--AVG(c.credit_amount) AS AvgCreditAmount,
--MAX(c.credit_amount) AS MaxCreditAmount
--FROM Clusters c 
--GROUP BY c."month";

WITH Avgcredit AS (
SELECT 
c."month" AS month1, 
c.cluster AS cluster,
AVG(c.credit_amount) AS AvgCreditAmount
FROM Clusters c 
GROUP BY c."month", c.cluster
),
MaxCredit AS (
SELECT 
c."month" AS month1, 
c.cluster AS cluster,
MAX(c.credit_amount) AS MaxCreditAmount
FROM Clusters c 
GROUP BY c."month"
)
SELECT
a.month1,
a.cluster,
a.AvgCreditAmount,
m.MaxCreditAmount
FROM Avgcredit a
JOIN MaxCredit m ON m.month1 = a.month1;

Задание 3: Разница в суммах кредита по месяцам
Задание: Создайте таблицу с разницей (Difference) между суммой кредита и
предыдущей суммой кредита по месяцам для каждого кластера. Используйте таблицу
Clusters.
Подсказка:
1. Получите сумму кредита и сумму кредита в предыдущем месяце:
Используйте функцию оконного анализа LAG() для получения суммы кредита в
предыдущем месяце в рамках каждого кластера.
2. Вычислите разницу: Используйте результат предыдущего шага для
вычисления разницы между текущей и предыдущей суммой кредита.
Примените COALESCE() для обработки возможных значений NULL.


WITH CreditWithPrevious AS (
SELECT 
c."month",
c.cluster,
c.credit_amount,
LAG(c.credit_amount) OVER (PARTITION BY c.cluster ORDER BY
c."month") AS PreviousCreditAmount
FROM Clusters c 
--GROUP BY c."month"
--ORDER BY c."month" 
)
SELECT 
"month",
cluster,
PreviousCreditAmount,
COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
FROM CreditWithPrevious
ORDER BY "month"
