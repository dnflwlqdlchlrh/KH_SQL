/*
 * 프로시져(PROCEDUAE)
 *     - PL/SQL 을 사용하여 DBMS 시스템에서 실행 할 프로그램을 만들기 위해 사용하는 객체
 *     - 반복 작업 및 복잡한 SQL 구문을 프로시져로 저장하여 재사용하는 용도로 사용될 수 있다.
 *     - DBMS 에 컴파일 된 상태로 동작하기 때문에 기존 SQL 스크립트 보다는 빠른 처리를 기대할 수 있다.
 */

CREATE OR REPLACE PROCEDURE PROC_TEST
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello PROCEDURE');
END;

-- EXEC PROC_TEST;
BEGIN
    PROC_TEST;
END;

DROP PROCEDURE PROC_TEST;

SELECT * FROM USER_PROCEDURES;
SELECT * FROM USER_ERRORS;
