/*teach table (개설 과목 테이블)*/
CREATE TABLE teach
(
    t_year         NUMBER          NOT NULL, 
    t_semester     NUMBER          NOT NULL, 
    t_time         NUMBER          NOT NULL, 
    split_no       NUMBER          NOT NULL, 
    t_max          NUMBER          NOT NULL, 
    t_professor    VARCHAR2(30)    NOT NULL, 
    place          VARCHAR2(30)    NOT NULL, 
    c_no           VARCHAR2(30)    NOT NULL, 
    c_name         VARCHAR2(30)    NOT NULL, 
    c_grade        VARCHAR2(30)    NOT NULL, 
    CONSTRAINT teach_pk PRIMARY KEY (t_year, t_semester, split_no, c_no)
);

ALTER TABLE teach
    ADD CONSTRAINT fk_course_pk FOREIGN KEY (c_no)
        REFERENCES course (c_no);

/*DROP TABLE teach;*/