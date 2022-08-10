
SELECT FIRST_NAME
     , LENGTH(FIRST_NAME) AS "길이"
  FROM EMPLOYEES;
  
-- 컬럼의 문자열 길이를 반환
SELECT LENGTH('HELLO ORACLE') AS "길이"
     , LENGTH('오라클 안녕') AS "길이"
  FROM DUAL;

 -- 컬럼의 문자열 바이트수를 반환
 SELECT LENGTHB ('HELLO ORACLE') AS "길이"
     , LENGTHB ('오라클 안녕') AS "길이"
  FROM DUAL;
 
-- 일치하는 문자의 위치를 반환해주는 함수 
 SELECT INSTR('sample@example.com', '@', 1)
      , INSTR('sample@examp@le.com', '@', -1)
      , INSTR('sample@examp@le.com', '@', -1, 2)
   FROM DUAL;

-- 여백 표시
SELECT RPAD('A', 4) || '!'
     , RPAD('AB', 4, '--') || '!'
     , RPAD('ABC', 4, '_') || '!'
     , RPAD('ABCDE', 4) || '!'
	 , '!' || LPAD('A', 4)  
     , '!' || LPAD('AB', 4)
     , '!' || LPAD('ABC', 4)
     , '!' || LPAD('A', 4, '0')
  FROM DUAL;
  
-- 제거
SELECT RTRIM('userId@example.com', '@example.com') -- 오른쪽 제거
     , LTRIM('010-1234-1234', '010-') -- 왼쪽 제거
     , LTRIM(RTRIM('   PASSWORD INPUT    ')) -- 양쪽 제거
     , TRIM('   PASSWORD INPUT    ') -- 양쪽 제거
     , TRIM('A' FROM 'AAAAHelloAAAA')
     , TRIM(LEADING 'A' FROM 'AAAAHelloAAAA')
     , TRIM(TRAILING 'A' FROM 'AAAAHelloAAAA')
     , TRIM(BOTH 'A' FROM 'AAAAHelloAAAA') 
  FROM DUAL;

-- 지정된 문자열 제거
SELECT SUBSTR('userId@example.com', 1, 6)
     , SUBSTR('userId@example.com', 8, 7)
     , SUBSTR('userId@example.com', 8)
     , SUBSTR('userId@example.com', -3)
  FROM DUAL;

-- 대소문자로 변경
SELECT LOWER('userId@example.com')
     , UPPER('userId@example.com')
     , INITCAP('userId@example.com')
  FROM DUAL;

-- 문자열 결합
SELECT CONCAT('HELLO', ' WORLD')
  FROM DUAL;
--             원본						찾을 문자열			변경할 문자열
SELECT REPLACE('USERID@EXAMPLE.COM', '@EXAMPLE.COM', '@EXAMPLE.CO.KR') 
  FROM DUAL;

-- 음수 값을 양수 값을 변환시켜주는 함수
SELECT ABS(10)
      , ABS(-10)
      , ABS(-10.12)
  FROM DUAL;
  
-- 나머지 값으로 반환 시켜주는 함수
 SELECT MOD(10, 3)
      , MOD(-10, 3)
      , MOD(10.5, 3)
      , MOD(-10.5, 3)
   FROM DUAL;
  
-- 반올림으로 반환 시켜주는 함수   
SELECT ROUND(10.4)
     , ROUND(10.5)
     , ROUND(10.45)
     , ROUND(10.45, 1) -- 첫 번째 자리까지
     , ROUND(10.456, 2) -- 두 번째 자리까지
     , ROUND(18.456, -1)
  FROM DUAL;
  
-- 올림,내림으로 반환 시켜주는 함수
SELECT FLOOR(10.34)
     , FLOOR(-10.34)
     , CEIL(10.34)
     , CEIL(-10.34)
  FROM DUAL;

-- 숫자를 소수점 아래 N번째 자리까지 버림하여 정리
SELECT TRUNC(10.34, 1)
     , TRUNC(10.36, 1)
     , TRUNC(10.3456, 2)
     , TRUNC(1234, -1)
  FROM DUAL;
 
-- 날짜 출력 함수
ALTER SESSION SET NLS_LANGUAGE = KOREAN;  -- 나라별 언어 설정 함수

SELECT * FROM V$NLS_PARAMETERS WHERE PARAMETER LIKE '%LANG%';	-- 설정된 언어 확인 함수
 
SELECT SYSDATE 						-- 현재 날짜
     , ADD_MONTHS(SYSDATE, 3)		-- 현재 날짜의 기준에서 N개월을 더해주는 함수
     , ADD_MONTHS(SYSDATE, -3)		-- 현재 날짜의 기준에서 N개월을 빼주는 함수
     , LAST_DAY(SYSDATE)			-- 현재 날짜의 마지막 날
     , NEXT_DAY(SYSDATE, '금요일')	-- 현재 날짜를 기준으로 가장 가까운 '금요일' 찾아주는 함수
     , NEXT_DAY(SYSDATE, '금')		-- 현재 날짜를 기준으로 가장 가까운 '금요일' 찾아주는 함수
     , NEXT_DAY(SYSDATE, 6)			-- 숫자로 날짜를 찾을 수 있다. 1 : 일요일, 2 : 월 ... 6 : 금요일, 7 : 토요일
  FROM DUAL;

-- 년,월,일,시간,분,초 단위로 나눠서 출력해주는 함수
SELECT EXTRACT(YEAR FROM SYSDATE)
     , EXTRACT(MONTH FROM SYSDATE)
     , EXTRACT(DAY FROM SYSDATE)
     , EXTRACT(HOUR FROM SYSTIMESTAMP)
     , EXTRACT(MINUTE FROM SYSTIMESTAMP)
     , EXTRACT(SECOND FROM SYSTIMESTAMP)
     , SYSDATE
     , SYSTIMESTAMP
  FROM DUAL;
  
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 3))
     , MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 3), SYSDATE)
  FROM DUAL;
  
-- 날짜를 더해주는 함수
SELECT SYSDATE 
     , SYSDATE + 1
     , SYSDATE + 2
     , SYSDATE - 2
     , SYSDATE - 1
  FROM DUAL;
  

SELECT SYSTIMESTAMP 
     , SYSTIMESTAMP + INTERVAL '30' SECOND 
     , SYSTIMESTAMP + INTERVAL '30' MINUTE  
     , SYSTIMESTAMP + INTERVAL '3' HOUR 
     , SYSTIMESTAMP - INTERVAL '30' SECOND 
     , SYSTIMESTAMP - INTERVAL '30' MINUTE  
     , SYSTIMESTAMP - INTERVAL '3' HOUR 
  FROM DUAL;
  
-- 숫자를 문자로 변환해서 출력해주는 함수
SELECT 1234
     , TO_CHAR(1234)
     , TO_CHAR(SYSDATE, 'YYYYMMDD')		-- 날짜를 문자열로 출력하는 방법
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD')	
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')	
     , TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"')	
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')	
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')	
     , TO_CHAR(SYSTIMESTAMP , 'YYYY-MM-DD AM HH:MI:SS.FF3')	
     , TO_CHAR(1000000, '999,999,999')	-- 출력 형식을 정해주는 방법
     , TO_CHAR(1000000, '000,000,000')	-- 출력 형식을 정해주는 방법
     , TO_CHAR(1000000, '999,999,999L')	-- 출력 형식을 정해주는 방법
  FROM DUAL;
  
SELECT TO_DATE('20220810', 'YYYYMMDD') 
     , TO_DATE('20220810') 
     , TO_DATE(20220810) 
     , TO_DATE('2022/08/10') 
     , TO_DATE('2022-08-10') 
     , TO_DATE('2022.08.10') 
     , TO_DATE('2022년 08월 10일', 'YYYY"년" MM"월" DD"일"')
  FROM DUAL;