SELECT * FROM ALL_ALL_TABLES WHERE TABLE_NAME = 'EMPLOYEES';

-- 개별 계정에서 동의어를 만들수 있도록 권한 부여(PRIVATE 동의어만 생성 가능)
GRANT CREATE SYNONYM TO PUSER1;

CREATE SYNONYM EMP FOR EMPLOYEES;

-- 원래 테이블명과 동의어 전부 사용 가능
SELECT * FROM EMPLOYEES;
SELECT * FROM EMP;

-- 관리자 계정으로 PUBLIC 동의어 생성
CREATE PUBLIC SYNONYM EMP FOR PUSER1.EMPLOYEES;
CREATE PUBLIC SYNONYM DEP FOR PUSER1.DEPARTMENTS;
CREATE SYNONYM JOB FOR PUSER1.JOBS; -- 비공개

-- DEVADMIN 계정이 EMP 테이블을 조회 할 수 있도록 조회권한 부여
GRANT SELECT ON EMP TO DEVADMIN;
GRANT SELECT ON DEP TO DEVADMIN;
GRANT SELECT ON JOB TO DEVADMIN;

REVOKE SELECT ANY TABLE FROM DEVADMIN;

SELECT * FROM EMP;
SELECT * FROM JOB; -- 조회 권한이 있어도 비공개 되어 있어서 보이지 않음.

