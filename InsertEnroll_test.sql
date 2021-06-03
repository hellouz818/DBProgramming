declare
    result VARCHAR2(100) := '';
begin
    dbms_output.enable;
    dbms_output.put_line('******테스트*****');
    InsertEnroll('1900003', 'A302', 1, result);
    InsertEnroll('1900003', 'C304', 2, result);
    InsertEnroll('1900003', 'C307', 3, result);
    InsertEnroll('1900003', 'C307', 1, result);
    InsertEnroll('1900003', 'L202', 1, result);
    InsertEnroll('1900003', 'L302', 1, result);
    dbms_output.put_line('결과' || result);
    dbms_output.put_line('시간표 출력');
    SelectTimeTable('1900003', 2021, 2);
end;
/
