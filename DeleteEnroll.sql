CREATE OR Replace PROCEDURE DeleteEnroll (sStudentId IN VARCHAR2, 
		sSplitNo IN NUMBER,
		nCourseIdNo IN VARCHAR2,
		result OUT VARCHAR2)
IS
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' ||nCourseIdNo|| ', 분반 ' || TO_CHAR(sSplitNo) || '의 수강 취소를 요청하였습니다.');

	DELETE
	FROM enroll
	WHERE s_id = sStudentId and split_no = sSplitNo and c_no = nCourseIdNo;

	COMMIT;
	result := '수강취소가 완료되었습니다.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;

END;
/