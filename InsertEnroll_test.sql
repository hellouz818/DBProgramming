DECLARE
result VARCHAR2(50) := '';

BEGIN
DBMS_OUTPUT.enable;
DBMS_OUTPUT.PUT_LINE('******테스트*******');
InsertEnroll('1400002', 'C100', 1, result);
DBMS_OUTPUT.PUT_LINE('결과' || result);
InsertEnroll('1400002', 'C100', 2, result);
DBMS_OUTPUT.PUT_LINE('결과' || result);
DBMS_OUTPUT.PUT_LINE('CURSOR를 이용한 테스트');
selectTimeTable('1400002', 2021, 2);
DELETE FROM enroll WHERE s_id = '140002' and c_no = 'C100' and split_no =1;

END;
/