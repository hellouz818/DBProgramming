/*검색기능 구현위해 필요한 커서쓰는 함수*/
CREATE OR REPLACE PROCEDURE cno_search(outcome out SYS_REFCURSOR, 
s_cno in VARCHAR2, SS_id in VARCHAR2)
is
begin

OPEN outcome FOR
select c_no, split_no, c_name, c_grade, t_time
from teach
where t_year=2021 and t_semester=2 and c_no=s_cno 
and (c_no,split_no) not in 
(select e.c_no,e.split_no from enroll e,teach t where s_id=SS_id and t.split_no=e.split_no) 
order by t_time;

end;
/

/*아래 부터는 위 프로시저가 잘 작동하는지 테스트*/
declare
Type refcur is ref cursor;
myCursor refcur;
v_no teach.c_no%type;
v_split_no teach.split_no%type;
v_name teach.c_name%type;
v_grade teach.c_grade%type;
v_time teach.t_time%type;

begin
cno_search(myCursor,'A301','1900002');

loop
fetch myCursor into v_no,v_split_no,v_name,v_grade,v_time;
exit when myCursor%notfound;
dbms_output.put_line('아이디:'||v_no||'   분반:'||v_split_no||'   이름:'||v_name||'   학점:'||v_grade||'   교시:'||v_time);
end loop;

end;
/ 
