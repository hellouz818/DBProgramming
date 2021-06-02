declare
  result VARCHAR2(50) := '';
 begin
 dbms_output.enable;
 dbms_output.put_line('******테스트*******');
 InsertEnroll('1900002', 'A302', 1,'내가만드는3D프린팅' ,result);
dbms_output.put_line('결과' || result);
end;
/
