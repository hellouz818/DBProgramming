 CREATE TABLE enroll(
  s_id VARCHAR2(10),
  year NUMBER,                  
  semester NUMBER,           
  c_no VARCHAR2(30),
  c_name VARCHAR2(30),
  split_no NUMBER
);

INSERT INTO enroll VALUES ('1400002', 2021,2, 'C100', '감자키우기', 1);
INSERT INTO enroll VALUES ('1100003', 2020,2, 'C200', '고구마키우기', 1);
INSERT INTO enroll VALUES ('1400002', 2021,2, 'C150', '감자굽기', 1);
INSERT INTO enroll VALUES ('1100003', 2020,2, 'C250', '고구마굽기', 1);