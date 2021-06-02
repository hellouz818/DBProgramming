/*course table (과목정보 테이블)*/
CREATE TABLE course
(
    c_no       VARCHAR2(30)    NOT NULL, 
    c_name     VARCHAR2(80)    NOT NULL, 
    c_grade    NUMBER          NOT NULL, 
    CONSTRAINT course_pk PRIMARY KEY (c_no)
);

/*DROP TABLE course;*/
