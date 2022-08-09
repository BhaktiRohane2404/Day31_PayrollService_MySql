	Employee Payroll Service :

#UC1:

mysql> create database payroll_service;
Query OK, 1 row affected (0.24 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| adress_book        |
| employee           |
| information_schema |
| mydb               |
| mysql              |
| payroll_service    |
| performance_schema |
| sys                |
+--------------------+

8 rows in set (0.02 sec)

mysql> use payroll_service;
Database changed

#UC2:

mysql> create table employee_payroll(
    -> ID int unsigned not null auto_increment primary key,
    -> NAME varchar(150) not null,
    -> SALARY double not null,
    -> START_DATE date not null);
Query OK, 0 rows affected (1.87 sec)

mysql> describe employee_payroll;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| ID         | int unsigned | NO   | PRI | NULL    | auto_increment |
| NAME       | varchar(150) | NO   |     | NULL    |                |
| SALARY     | double       | NO   |     | NULL    |                |
| START_DATE | date         | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
4 rows in set (0.12 sec)

#UC3:

mysql> insert into employee_payroll (NAME,SALARY,START_DATE) values
    -> ("Bill", 100000.00, "2018-10-03"),
    -> ("Mark", 200000.00, "2019-10-03"),
    -> ("Charlie", 300000.00, "2020-05-21");
Query OK, 3 rows affected (0.09 sec)
Records: 3  Duplicates: 0  Warnings: 0

#UC4:

mysql> select * from employee_payroll;
+----+---------+--------+------------+
| ID | NAME    | SALARY | START_DATE |
+----+---------+--------+------------+
|  1 | Bill    | 100000 | 2018-10-03 |
|  2 | Mark    | 200000 | 2019-10-03 |
|  3 | Charlie | 300000 | 2020-05-21 |
+----+---------+--------+------------+
3 rows in set (0.10 sec)

#UC5:

mysql> select SALARY from employee_payroll where NAME = "Bill";
+--------+
| SALARY |
+--------+
| 100000 |
+--------+
1 row in set (0.00 sec)

mysql> select * from employee_payroll where START_DATE between cast("2018-01-01" as date) and date (NOW());
+----+---------+--------+------------+
| ID | NAME    | SALARY | START_DATE |
+----+---------+--------+------------+
|  1 | Bill    | 100000 | 2018-10-03 |
|  2 | Mark    | 200000 | 2019-10-03 |
|  3 | Charlie | 300000 | 2020-05-21 |
+----+---------+--------+------------+
3 rows in set (0.11 sec)

#UC6:

mysql> alter table employee_payroll add GENDER char not null after NAME;
Query OK, 0 rows affected (3.21 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+---------+--------+--------+------------+
| ID | NAME    | GENDER | SALARY | START_DATE |
+----+---------+--------+--------+------------+
|  1 | Bill    |        | 100000 | 2018-10-03 |
|  2 | Mark    |        | 200000 | 2019-10-03 |
|  3 | Charlie |        | 300000 | 2020-05-21 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> update employee_payroll set GENDER = 'M' where NAME = "Bill" or NAME = "Charlie";
Query OK, 2 rows affected (0.24 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> update employee_payroll set GENDER = 'M' where ID = 2;
Query OK, 1 row affected (0.11 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from employee_payroll;
+----+---------+--------+--------+------------+
| ID | NAME    | GENDER | SALARY | START_DATE |
+----+---------+--------+--------+------------+
|  1 | Bill    | M      | 100000 | 2018-10-03 |
|  2 | Mark    | M      | 200000 | 2019-10-03 |
|  3 | Charlie | M      | 300000 | 2020-05-21 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> insert into employee_payroll (NAME, GENDER, SALARY, START_DATE) values
    -> ("Terisa",'F',400000.00,"2021-08-26");
Query OK, 1 row affected (0.18 sec)

mysql> select * from employee_payroll;
+----+---------+--------+--------+------------+
| ID | NAME    | GENDER | SALARY | START_DATE |
+----+---------+--------+--------+------------+
|  1 | Bill    | M      | 100000 | 2018-10-03 |
|  2 | Mark    | M      | 200000 | 2019-10-03 |
|  3 | Charlie | M      | 300000 | 2020-05-21 |
|  4 | Terisa  | F      | 400000 | 2021-08-26 |
+----+---------+--------+--------+------------+
4 rows in set (0.11 sec)

#UC7:

mysql> select sum(SALARY) from employee_payroll where GENDER = 'M' group by GENDER;
+-------------+
| sum(SALARY) |
+-------------+
|      600000 |
+-------------+
1 row in set (0.11 sec)

mysql> select sum(SALARY) from employee_payroll where GENDER = 'F' group by GENDER;
+-------------+
| sum(SALARY) |
+-------------+
|      400000 |
+-------------+
1 row in set (0.00 sec)

mysql> select avg(SALARY) from employee_payroll where GENDER = 'M' group by GENDER;
+-------------+
| avg(SALARY) |
+-------------+
|      200000 |
+-------------+
1 row in set (0.00 sec)

mysql> select avg(SALARY) from employee_payroll group by GENDER;
+-------------+
| avg(SALARY) |
+-------------+
|      200000 |
|      400000 |
+-------------+
2 rows in set (0.11 sec)

mysql> select GENDER,avg(SALARY) from employee_payroll group by GENDER;
+--------+-------------+
| GENDER | avg(SALARY) |
+--------+-------------+
| M      |      200000 |
| F      |      400000 |
+--------+-------------+
2 rows in set (0.00 sec)

mysql> select max(SALARY) from employee_payroll;
+-------------+
| max(SALARY) |
+-------------+
|      400000 |
+-------------+
1 row in set (0.00 sec)

mysql> select min(SALARY) from employee_payroll;
+-------------+
| min(SALARY) |
+-------------+
|      100000 |
+-------------+
1 row in set (0.00 sec)

mysql> select NAME,GENDER,max(SALARY) from employee_payroll group by GENDER;
+--------+--------+-------------+
| NAME   | GENDER | max(SALARY) |
+--------+--------+-------------+
| Bill   | M      |      300000 |
| Terisa | F      |      400000 |
+--------+--------+-------------+
2 rows in set (0.00 sec)

mysql>
mysql> select NAME,GENDER,min(SALARY) from employee_payroll group by GENDER;
+--------+--------+-------------+
| NAME   | GENDER | min(SALARY) |
+--------+--------+-------------+
| Bill   | M      |      100000 |
| Terisa | F      |      400000 |
+--------+--------+-------------+
2 rows in set (0.00 sec)

#UC8:

mysql> alter table employee_payroll add phone_number bigint after NAME;
Query OK, 0 rows affected (5.00 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add address varchar(250) after phone_number;
Query OK, 0 rows affected (2.87 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add department varchar(150) not null after address;
Query OK, 0 rows affected (2.18 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll alter address set default 'TBD';
Query OK, 0 rows affected (0.23 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| ID           | int unsigned | NO   | PRI | NULL    | auto_increment |
| NAME         | varchar(150) | NO   |     | NULL    |                |
| phone_number | bigint       | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(150) | NO   |     | NULL    |                |
| GENDER       | char(1)      | NO   |     | NULL    |                |
| SALARY       | double       | NO   |     | NULL    |                |
| START_DATE   | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
8 rows in set (0.00 sec)

#UC9 :

mysql> alter table employee_payroll add deductions double not null after basic_pay;
Query OK, 0 rows affected (4.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add taxable_pay double not null after deductions;
Query OK, 0 rows affected (2.18 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add tax double not null after taxable_pay;
Query OK, 0 rows affected (1.72 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add net_pay double not null after tax;
Query OK, 0 rows affected (1.76 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| phone_number | bigint       | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(150) | NO   |     | NULL    |                |
| gender       | char(1)      | NO   |     | NULL    |                |
| basic_pay    | double       | NO   |     | NULL    |                |
| deductions   | double       | NO   |     | NULL    |                |
| taxable_pay  | double       | NO   |     | NULL    |                |
| tax          | double       | NO   |     | NULL    |                |
| net_pay      | double       | NO   |     | NULL    |                |
| start_date   | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
12 rows in set (0.11 sec)

mysql> select * from employee_payroll;
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
| id | name    | phone_number | address | department | gender | basic_pay | deductions | taxable_pay | tax | net_pay | start_date |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
|  1 | Bill    |         NULL | NULL    |            | M      |    100000 |          0 |           0 |   0 |       0 | 2018-10-03 |
|  2 | Mark    |         NULL | NULL    |            | M      |    200000 |          0 |           0 |   0 |       0 | 2019-10-03 |
|  3 | Charlie |         NULL | NULL    |            | M      |    300000 |          0 |           0 |   0 |       0 | 2020-05-21 |
|  4 | Terisa  |         NULL | NULL    |            | F      |    400000 |          0 |           0 |   0 |       0 | 2021-08-26 |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
4 rows in set (0.00 sec)

