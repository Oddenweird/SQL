Задание 1: Создание таблицы и изменение данных
Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
● EmployeeID (INTEGER, PRIMARY KEY)
● EmployeeName (TEXT)
● Position (TEXT)
● HireDate (DATE)
● Salary (NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.

CREATE TABLE EmployeeDetails (
EmployeeID INT PRIMARY KEY
, EmployeeName VARCHAR(10)
, Position VARCHAR(10)
, HireDate VARCHAR(10)
, Salary INT
);

INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES (1, 'Timur', 'manager', '2024-11-14', 10);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES (2, 'Ivan', 'tokar', '2024-11-14', 11);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES (3, 'Vano', 'technolog', '2024-11-14', 12);

SELECT * from EmployeeDetails ;

Задание 2: Создание представления
Задание: Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.
Подсказки:
1. Используйте JOIN для объединения таблиц.
2. Используйте функцию SUM() для вычисления общей суммы заказа.
drop HighValue_Orders

CREATE VIEW HighValueOrders__ AS
SELECT 
o.OrderID, 
o.OrderDate, 
SUM(p.Price * od.Quantity) AS TotalAmount 
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY o.OrderID, o.OrderDate
HAVING SUM(od.Quantity * p.Price) > 10000;

SELECT * FROM HighValueOrders__


Задание 3: Удаление данных и таблиц
Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
50000. Затем удалите таблицу EmployeeDetails из базы данных.
Подсказки:
1. Используйте команду DELETE FROM для удаления данных.
2. Используйте команду DROP TABLE для удаления таблицы.

DELETE FROM EmployeeDetails
WHERE Salary > 5;

DROP table EmployeeDetails;

SELECT * FROM EmployeeDetails;

Задание 4: Создание хранимой процедуры
Задание: Создайте хранимую процедуру GetProductSales с одним параметром
ProductID. Эта процедура должна возвращать список всех заказов, в которых
участвует продукт с заданным ProductID, включая следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● CustomerID (идентификатор клиента).
Подсказки:
1. Используйте команду CREATE PROCEDURE для создания процедуры.
2. Используйте JOIN для объединения таблиц и WHERE для фильтрации данных по
ProductID.
  
НЕ УДАЛОСЬ РЕШИТЬ ДАННОЕЕ ЗАДАНИЕ ИЗ-ЗА ОТСУТСТВИЯ ССЫЛКИ НА ЛОКАЛЬНЫЙ ХОСТ ПРЕПОДАВАТЕЛЯ.
Вставил код эталонный, который нужно вставить в файл Процедур MySQL.
  
--CREATE PROCEDURE GetProductSales(IN p_ProductID INTEGER)
--BEGIN
--SELECT o.OrderID, o.OrderDate, o.CustomerID 
--FROM Orders o
--JOIN OrderDetails od ON od.OrderID = o.OrderID
--WHERE od.ProductID = p_ProductID;
--END;
