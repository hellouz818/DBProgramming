declare
  result VARCHAR2(50) := '';
 begin
 dbms_output.enable;
 dbms_output.put_line('******테스트*******');
 InsertEnroll('1916205', 'C405', 1, result);
dbms_output.put_line('결과' || result);
end;
/
