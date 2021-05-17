/*현재 날짜가 11,12월인경우 수강신청 년도는 다음 년도 1학기*/
CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
    nYear NUMBER;
    nMonth CHAR(2);

BEGIN
    nMonth := TO_CHAR(dDate, 'MM');
    IF (nMonth >= '11') THEN
        nYear := TO_NUMBER(TO_CHAR(dDate, 'YYYY')+1);
    ELSE
        nYear := TO_NUMBER(TO_CHAR(dDate, 'YYYY'));
    END IF;

    RETURN nYear;
END;
/

/*수강신청 날짜가 전년도 11,12월 & 1-4월 : 1학기, 5-10월 : 2학기*/
CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
    nSemester NUMBER;
    nMonth CHAR(2);

BEGIN
    nMonth := TO_CHAR(dDate, 'MM');
    IF (nMonth >= '05' and nMonth <= '10') THEN
        nSemester := 2;
    ELSE
        nSemester := 1;
    END IF;

    RETURN nSemester;
END;
/