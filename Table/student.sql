/*student table (학생 테이블)*/
CREATE TABLE student
(
    s_id      VARCHAR2(10)    NOT NULL, 
    s_pwd     VARCHAR2(30)    NOT NULL, 
    s_name    VARCHAR2(30)    NOT NULL, 
    s_year    NUMBER          NOT NULL, 
    CONSTRAINT student_pk PRIMARY KEY (s_id)
);

/*DROP TABLE student;*/