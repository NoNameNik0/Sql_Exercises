/*
PGSQL
https://www.sql-ex.ru/exercises

В тиши ночей я слышу зов —
Не сердца, а баз сплетеных 
Откроюсь тебе — и строка за строкой
Всплывут фрагменты времён прошедших,
Где запрос — молитва, а schema — закон,
И ключи хранят откровения.

*/

--ex1
/*
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. 
Вывести: model, speed и hd
*/

SELECT model,speed,hd
FROM PC
WHERE price <500;


--ex2
/*
Найдите производителей принтеров. Вывести: maker
*/

SELECT DISTINCT maker
FROM product
WHERE type = 'Printer';


--ex3
/*
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, 
цена которых превышает 1000 дол
*/

SELECT model,ram,screen
FROM Laptop
WHERE price > 1000;


--ex4
/*
Найдите все записи таблицы Printer для цветных принтеров
*/

SELECT code, model, color, type, price
FROM Printer
WHERE color = 'y';


--ex5
/*
Найдите номер модели, скорость и размер жесткого диска ПК, 
имеющих 12x или 24x CD и цену менее 600 дол
*/

SELECT model,speed,hd
FROM PC
WHERE cd IN('12x','24x') AND price < 600;


--ex6
/*
Для каждого производителя, выпускающего ПК-блокноты 
c объёмом жесткого диска не менее 10 Гбайт, 
найти скорости таких ПК-блокнотов. Вывод: производитель, скорость
*/

SELECT DISTINCT p.maker,l.speed
FROM Product p JOIN Laptop l ON p.model = l.model
WHERE l.hd >= 10;


--ex7
/*
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) 
производителя B (латинская буква)
*/

SELECT pr.model,p.price
FROM Product pr JOIN PC p ON pr.model = p.model
WHERE maker = 'B'
UNION
SELECT pr.model,l.price
FROM Product pr JOIN Laptop l ON pr.model = l.model
WHERE maker = 'B'
UNION
SELECT pr.model,pri.price
FROM Product pr JOIN Printer pri ON pr.model = pri.model
WHERE maker = 'B'

-- «Да прибудет с тобой Сила»


--ex8
/*
Найдите производителя, выпускающего ПК, но не ПК-блокноты
*/

SELECT DISTINCT maker
FROM Product
WHERE type = 'PC'
EXCEPT
SELECT DISTINCT maker
FROM Product
WHERE type = 'Laptop';

















