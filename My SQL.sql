CREATE DATABASE  `test` ;

USE `test`;


DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `Cnum` int NOT NULL,
  `Cname` varchar(255) DEFAULT NULL,
  `City` varchar(255) NOT NULL,
  `Snum` int DEFAULT NULL,
  PRIMARY KEY (`Cnum`),
  KEY `Snum` (`Snum`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`Snum`) REFERENCES `salespeople` (`Snum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `customers` WRITE;

INSERT INTO `customers` (`Cnum`, `Cname`, `City`, `Snum`) VALUES (2001,'Hoffman','London',1001),(2002,'Giovanni','Rome',1003),(2003,'Liu','Sanjose',1002),(2004,'Grass','Berlin',1002),(2006,'Clemens','London',1001),(2007,'Pereira','Rome',1004),(2008,'Cisneros','Sanjose',1007);

UNLOCK TABLES;




DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `Onum` int NOT NULL,
  `Amt` decimal(10,2) DEFAULT NULL,
  `Odate` date DEFAULT NULL,
  `Cnum` int DEFAULT NULL,
  `Snum` int DEFAULT NULL,
  PRIMARY KEY (`Onum`),
  KEY `Cnum` (`Cnum`),
  KEY `Snum` (`Snum`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Cnum`) REFERENCES `customers` (`Cnum`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Snum`) REFERENCES `salespeople` (`Snum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




LOCK TABLES `orders` WRITE;

INSERT INTO `orders` (`Onum`, `Amt`, `Odate`, `Cnum`, `Snum`) VALUES (3001,18.69,'1990-10-03',2008,1007),(3002,1900.10,'1990-10-03',2007,1004),(3003,767.19,'1990-10-03',2001,1001),(3005,5160.45,'1990-10-03',2003,1002),(3006,1098.16,'1990-10-03',2008,1007),(3007,75.75,'1990-10-04',2004,1002),(3008,4273.00,'1990-10-05',2006,1001),(3009,1713.23,'1990-10-04',2002,1003),(3010,1309.95,'1990-10-06',2004,1002),(3011,9891.88,'1990-10-06',2006,1001);

UNLOCK TABLES;


--

DROP TABLE IF EXISTS `salespeople`;

CREATE TABLE `salespeople` (
  `Snum` int NOT NULL,
  `Sname` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Comm` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Snum`),
  UNIQUE KEY `Sname` (`Sname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--

LOCK TABLES `salespeople` WRITE;

INSERT INTO `salespeople` (`Snum`, `Sname`, `City`, `Comm`) VALUES (1001,'Peel','London',0.12),(1002,'Serres','Sanjose',0.13),(1003,'Axelrod','Newyork',0.10),(1004,'Motika','London',0.11),(1007,'Rifkin','Barcelona',0.15);

UNLOCK TABLES;

/* Task-1 */
SELECT COUNT(*) AS Count
FROM SalesPeople
WHERE UPPER(LEFT(Sname, 1)) = 'A';

/* Task-2 */
SELECT S.*
FROM SalesPeople AS S
INNER JOIN Orders AS O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname
HAVING SUM(O.Amt) > 2000;

/* Task-3 */
SELECT COUNT(*) AS Count
FROM SalesPeople
WHERE City = 'Newyork';

/* Task-4 */
SELECT City, COUNT(*) AS Count
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;

/* Task-5 */
SELECT S.Snum, S.Sname, COUNT(*) AS OrderCount, O.Odate
FROM SalesPeople AS S
INNER JOIN Orders AS O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname, O.Odate;
