Задание: Определите общую прибыль для каждой категории продуктов,
используя таблицы OrderDetails, Orders и Products. Для расчета прибыли
умножьте цену продукта на количество, а затем суммируйте результаты по
категориям.
Подсказка: Используйте JOIN для объединения таблиц OrderDetails,
Orders, Products и Categories. Примените агрегацию с функцией SUM.

SELECT
p.CategoryID,
c.CategoryName,
SUM(od.Quantity * p.Price) AS total_price
FROM OrderDetails od 
JOIN Products p ON p.ProductID = od.ProductID
JOIN Orders o ON o.OrderID = od.OrderID 
JOIN Categories c ON c.CategoryID = p.CategoryID 
GROUP BY p.CategoryID
ORDER BY p.CategoryID ;

Задание:
Определите количество заказов, размещенных клиентами из различных стран, за
каждый месяц.
Подсказка:
Используйте JOIN для объединения таблиц Orders и Customers. Для извлечения
месяца и года из даты используйте функцию EXTRACT.

SELECT
	c.Country,
	COUNT(o.OrderID) AS count_orderID
FROM Customers c 
JOIN Orders o ON o.CustomerID = c.CustomerID 
GROUP BY c.Country;

Задание: Рассчитайте среднюю продолжительность кредитного срока для
клиентов по категориям образования.
Подсказка: Используйте таблицу Clusters и функцию AVG для вычисления
средней продолжительности кредитного срока.

SELECT 
c.education ,
AVG(c.credit_amount) AS credit_avg 
FROM Clusters c 
GROUP BY c.education
