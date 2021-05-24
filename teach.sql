/*teach table과 insert*/
CREATE TABLE teach(
t_year NUMBER,
t_time NUMBER,
t_semester NUMBER,
t_max NUMBER,
 c_no VARCHAR2(30),
 c_name VARCHAR2(30),
 split_no VARCHAR2(30)
);

INSERT INTO teach VALUES (2021, 1, 2, 10, 'C100', '감자키우기', 1);
INSERT INTO teach VALUES (2021, 2, 2, 10, 'C200', '고구마키우기', 1);
INSERT INTO teach VALUES (2021, 4, 2, 8, 'C150', '감자굽기', 1);
INSERT INTO teach VALUES (2021, 3, 2, 8, 'C150', '감자굽기', 2);
INSERT INTO teach VALUES (2021, 2, 2, 8, 'C150', '감자굽기', 3);
INSERT INTO teach VALUES (2021, 3, 2, 5, 'C250', '고구마굽기', 1);