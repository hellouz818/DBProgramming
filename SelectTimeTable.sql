CREATE OR REPLACE PROCEDURE SelectTimeTable
( sStudentId IN VARCHAR2, nYear IN NUMBER, nSemester IN NUMBER)
IS
v_teach teach%ROWTYPE;
result number;

CURSOR timetable_infor(v_nYear v_teach.t_year%TYPE, v_nSemester v_teach.t_semester%TYPE) IS
SELECT  t_year, t_semester, teach.t_time, teach.c_no, teach.c_name, teach.split_no, teach.c_grade, teach.place
INTO v_teach.t_year, v_teach.t_semester, v_teach.t_time, v_teach.c_no, v_teach.c_name, v_teach.split_no, v_teach.c_grade, v_teach.place
FROM teach,enroll
WHERE teach.c_no=enroll.c_no and teach.t_year=enroll.year and teach.t_semester=enroll.semester and enroll.s_id=sStudentId 
and enroll.year=nYear and enroll.semester=nSemester and teach.split_no=enroll.split_no;

BEGIN
dbms_output.put_line(nYear||'년도 '||nSemester||'학기의 '||sStudentID||'님의 수강신청 시간표입니다.');
result:=0;

OPEN timetable_infor(nYear, nSemester);
LOOP
FETCH timetable_infor INTO v_teach.t_year, v_teach.t_semester, v_teach.t_time, v_teach.c_no, v_teach.c_name, v_teach.split_no, v_teach.c_grade, v_teach.place;
EXIT WHEN timetable_infor%NOTFOUND;
dbms_output.put_line('년도:'||v_teach.t_year||'    학기 : '||v_teach.t_semester);
result:=result+v_teach.c_grade;
END LOOP;
dbms_output.put_line('총 '||timetable_infor%rowcount||'과목과 총 '||result||'학점을 신청하였습니다.');
CLOSE timetable_infor;
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line(sqlerrm||'에러 발생');
END;
/
