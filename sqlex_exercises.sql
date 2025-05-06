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


--ex9
/*
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
*/

SELECT DISTINCT maker 
FROM Product p JOIN PC pc ON p.model = pc.model
WHERE speed >= 450


--ex10
/*
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
*/

SELECT model, price
FROM  Printer
WHERE price = (SELECT MAX(price) FROM Printer)


--ex11
/*
Найдите среднюю скорость ПК.
*/

SELECT AVG(speed) avg_speed
FROM PC


--ex12
/*
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол
*/

SELECT AVG(speed) avg_speed
FROM Laptop
WHERE price >1000


--ex13
/*
Найдите среднюю скорость ПК, выпущенных производителем A
*/


SELECT AVG(speed) avg_speed
FROM Product p JOIN PC pc ON p.model = pc.model
WHERE p.maker = 'A'


--ex14
/*
Найдите класс, имя и страну для кораблей из таблицы Ships, 
имеющих не менее 10 орудий
*/

SELECT cl.class,sh.name, cl.country
FROM classes cl JOIN Ships sh ON cl.class = sh.class
WHERE numGuns >=10;


--ex15
/*
Найдите размеры жестких дисков, совпадающих у двух и более PC. 
Вывести: HD
*/

SELECT hd 
FROM PC
GROUP BY hd
HAVING COUNT(*)>=2


--ex16
/*
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. 
В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), 
Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM
*/

SELECT DISTINCT t.model, l.model, t.speed, t.ram
FROM PC as t JOIN PC as l
ON t.speed = l.speed AND t.ram = l.ram
AND t.model>l.model


--ex17
/*
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed
*/

SELECT DISTINCT p.type,lp.model,lp.speed
FROM Product p JOIN Laptop lp
ON lp.model = p.model
WHERE lp.speed < ALL(SELECT speed FROM PC)


--ex18
/*
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
*/

SELECT DISTINCT p.maker, pr.price
FROM product p
JOIN printer pr ON p.model = pr.model
WHERE pr.color = 'y'
  AND pr.price = (
     SELECT MIN(price)
     FROM printer
     WHERE color = 'y'
)


 --ex19
 /*
Для каждого производителя, имеющего модели в таблице Laptop, 
найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана
 */

SELECT p.maker, AVG(screen)AS avg_scr
FROM Product p JOIN Laptop l ON p.model = l.model
GROUP BY p.maker


--ex20
/*
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. 
Вывести: Maker, число моделей ПК
*/

SELECT maker, COUNT(DISTINCT model) AS model_count
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(DISTINCT model) >= 3;


--ex21
/*
Найдите максимальную цену ПК, выпускаемых каждым производителем, 
у которого есть модели в таблице PC. Вывести: maker, максимальная цена
*/

SELECT p.maker, MAX(pc.price) AS max_price
FROM Product p JOIN PC pc ON p.model = pc.model
WHERE p.type = 'PC'
GROUP BY maker


--ex22
/*
Для каждого значения скорости ПК, превышающего 600 МГц, 
определите среднюю цену ПК с такой же скоростью. 
Вывести: speed, средняя цена
*/

SELECT speed, AVG(price) AS avg_price
FROM PC
WHERE speed >600
GROUP BY speed


--ex23
/*
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker
*/

SELECT p.maker
FROM Product p JOIN PC pc ON p.model = pc.model
WHERE pc.speed >=750 AND p.type = 'PC'
INTERSECT
SELECT p.maker
FROM Product p JOIN Laptop l ON p.model = l.model
WHERE l.speed>=750 AND p.type = 'Laptop'


--ex24
/*
Перечислите номера моделей любых типов, 
имеющих самую высокую цену по всей имеющейся в базе данных продукции
*/

WITH MaxPriceAllProduct As (
SELECT p.model,pc.price
FROM Product p JOIN PC pc ON p.model = pc.model
WHERE p.type = 'PC'

UNION
SELECT p.model, l.price
FROM Product p JOIN Laptop l ON p.model = l.model
WHERE p.type = 'Laptop'

UNION
SELECT p.model, pr.price
FROM Product p JOIN Printer pr ON p.model = pr.model
WHERE p.type = 'Printer'
)

SELECT model
FROM MaxPriceAllProduct
WHERE price = (SELECT MAX(price)mxpr FROM MaxPriceAllProduct)













