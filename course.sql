/*course table과 insert*/
CREATE TABLE course(
  c_no VARCHAR2(30),  
  c_time NUMBER,
  c_name VARCHAR2(30),  
  split_no NUMBER,           
  grade NUMBER,
  place VARCHAR2(30)
  );

INSERT INTO course VALUES ('C100', 1, '감자키우기', 1,3,'명신관');
INSERT INTO course VALUES ('C200', 2, '고구마키우기',  1,3,'순헌');
INSERT INTO course VALUES ('C150', 4, '감자굽기', 1,2,'눈꽃광장');
INSERT INTO course VALUES ('C150', 3, '감자굽기', 2,2,'눈꽃광장');
INSERT INTO course VALUES ('C150', 2, '감자굽기', 3,2,'눈꽃광장');
INSERT INTO course VALUES ('C250', 3, '고구마굽기', 1,2,'젬마홀');
