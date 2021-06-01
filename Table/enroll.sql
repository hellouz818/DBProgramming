/*enroll table (수강등록 테이블)*/
CREATE TABLE enroll
(
    s_id        VARCHAR2(10)    NOT NULL, 
    year        NUMBER          NOT NULL, 
    semester    NUMBER          NOT NULL, 
    c_no        VARCHAR2(30)    NOT NULL, 
    c_name      VARCHAR2(30)    NOT NULL, 
    split_no    NUMBER          NOT NULL
);

ALTER TABLE enroll
    ADD CONSTRAINT fk_student_pk FOREIGN KEY (s_id)
        REFERENCES student (s_id);

ALTER TABLE enroll
    ADD CONSTRAINT FK_enroll_year_teach_t_year FOREIGN KEY (year, semester, c_no, split_no)
        REFERENCES teach (t_year, t_semester, c_no, split_no);

/*DROP TABLE enroll;*/