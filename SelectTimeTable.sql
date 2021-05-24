CREATE OR REPLACE PROCEDURE SelectTimeTable
( sStudentId IN VARCHAR2, nYear IN NUMBER, nSemester IN NUMBER)
IS
v_time course.c_time%TYPE;
v_no course.c_no%TYPE;
v_name course.c_name%TYPE;
v_split_no course.split_no%TYPE;
v_grade course.grade%TYPE;
v_place course.place%TYPE;
result number;
CURSOR timetable_infor IS
SELECT  c_time, c_no, c_name, split_no, grade, place
FROM course
WHERE c_no in (SELECT enroll.c_no
FROM enroll
WHERE enroll.s_id=sStudentId 
and enroll.year=nYear and enroll.semester=nSemester );

BEGIN
dbms_output.put_line(nYear||'년도 '||nSemester||'학기의 '||sStudentID||'님의 수강신청 시간표입니다.');
result:=0;

OPEN timetable_infor;
LOOP
FETCH timetable_infor INTO v_time, v_no, v_name,v_split_no, v_grade,v_place;
EXIT WHEN timetable_infor%NOTFOUND;
dbms_output.put_line( '교시 : ' || v_time || ', 과목번호 : ' || v_no || ', 과목명 : ' || v_name || ', 분반 : ' || v_split_no || ', 학점 : ' || v_grade || ', 장소 : ' || v_place);
result:=result+v_grade;
END LOOP;
dbms_output.put_line('총 '||timetable_infor%rowcount||'과목과 총 '||result||'학점을 신청하였습니다.');
CLOSE timetable_infor;
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line(sqlerrm||'에러 발생');
END;