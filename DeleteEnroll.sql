CREATE OR Replace PROCEDURE DeleteEnroll (sStudentId IN VARCHAR2, 
		sSplitNo IN NUMBER,
		nCourseIdNo IN VARCHAR2,
		result OUT VARCHAR2)
IS
BEGIN
	result := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' ||nCourseIdNo|| ', �й� ' || TO_CHAR(sSplitNo) || '�� ���� ��Ҹ� ��û�Ͽ����ϴ�.');

	DELETE
	FROM enroll
	WHERE s_id = sStudentId and split_no = sSplitNo and c_no = nCourseIdNo;

	COMMIT;
	result := '������Ұ� �Ϸ�Ǿ����ϴ�.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;

END;
/