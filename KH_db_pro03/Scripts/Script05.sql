/*
 * 프로시져에 매개변수를 사용하는 방법
 */
CREATE OR REPLACE PROCEDURE PROC_PARAM(x IN NUMBER, y IN VARCHAR2)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('x -> ' || x);
    DBMS_OUTPUT.PUT_LINE('y -> ' || y);
END;

BEGIN
    PROC_PARAM(10, 'Hello');
END;


/*
 * 프로시져로 실행한 결과를 리턴 받는 방법
 *     - 프로시져는 함수와 유사하나 함수 처럼 결과를 리턴시키는 기능은 없다.
 */
CREATE OR REPLACE PROCEDURE PROC_PARAM(x IN NUMBER, y OUT VARCHAR2)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('x -> ' || x);
    y := 'Done!';
END;

DECLARE
    x1 VARCHAR2(10);
BEGIN
    PROC_PARAM(10, x1);
    DBMS_OUTPUT.PUT_LINE('x1 -> ' || x1);
END;


CREATE TABLE 재고입출고(
       ID    NUMBER        CONSTRAINT PK_재고입출고_ID PRIMARY KEY
     , PNAME VARCHAR2(100) CONSTRAINT NN_재고입출고_PNAME NOT NULL
     , PTYPE CHAR(1)       CONSTRAINT CK_재고입출고_PTYPE CHECK(PTYPE IN ('I', 'O'))
     , CNT   NUMBER        DEFAULT(1) CONSTRAINT NN_재고입출고_CNT NOT NULL
     , PDATE DATE          CONSTRAINT NN_재고입출고_PDATE NOT NULL
);

CREATE SEQUENCE SEQ_재고번호 NOCACHE;

CREATE TABLE 재고관리(
       ID    NUMBER        CONSTRAINT PK_재고관리_ID    PRIMARY KEY
     , PNAME VARCHAR2(100) CONSTRAINT NN_재고관리_PNAME NOT NULL
     , CNT   NUMBER        CONSTRAINT NN_재고관리_CNT   NOT NULL
);

CREATE SEQUENCE SEQ_재고관리번호 NOCACHE;

/*
 * 제품명, 입고/출고 타입, 수량, 날짜 정보를 전달하면 재고입출고 테이블에
 * 해당 정보가 추가 되며, 재고관리 테이블에도 동일한 정보를 추가한다
 * 단, 이미 등록된 제품의 경우 수량만 변경하도록 한다.
 * 
 * 만약 출고인 경우 재고관리에 동일한 제품에 대한 수량이 부족한 경우 출고가 안되게
 * 해야 한다.
 */

CREATE OR REPLACE PROCEDURE PROC_재고입출등록(
       name IN VARCHAR2
     , in_out IN VARCHAR2
     , inout_cnt IN NUMBER
     , inout_date IN DATE
     , res OUT NUMBER
)
IS
    io_type       VARCHAR2(1) := UPPER(in_out);
    row_data      재고관리%ROWTYPE;
    row_cnt       NUMBER;
    invalid_type  EXCEPTION;
    no_out_data   EXCEPTION;
    not_enough_count EXCEPTION;
BEGIN
	IF io_type NOT IN ('I', 'O') THEN
	    RAISE invalid_type;
	END IF;
	
    IF io_type = 'O' THEN
        SELECT COUNT(*)
          INTO row_cnt
          FROM 재고관리
         WHERE PNAME = name;
           
        IF row_cnt != 0 THEN
            INSERT INTO 재고입출고 VALUES(SEQ_재고번호.NEXTVAL, name, io_type, inout_cnt, inout_date);
            
            SELECT ID, PNAME, CNT
              INTO row_data
              FROM 재고관리
             WHERE PNAME = name;
            
            UPDATE 재고관리
               SET CNT = CNT - inout_cnt
             WHERE ID = row_data.ID;
            
            SELECT CNT
              INTO row_cnt
              FROM 재고관리
             WHERE ID = row_data.ID;
            
            IF row_cnt < 0 THEN
                RAISE not_enough_count;
            END IF;
        ELSE
            RAISE no_out_data;
        END IF;
    ELSE
        SELECT COUNT(*)
          INTO row_cnt
          FROM 재고관리 WHERE PNAME = name;
        
        INSERT INTO 재고입출고 VALUES(SEQ_재고번호.NEXTVAL, name, io_type, inout_cnt, inout_date);
        
        IF row_cnt = 0 THEN
            INSERT INTO 재고관리 VALUES(SEQ_재고관리번호.NEXTVAL, name, inout_cnt);
        ELSE
            SELECT ID, PNAME, CNT
              INTO row_data
              FROM 재고관리 WHERE PNAME = name;
            
            UPDATE 재고관리
               SET CNT = CNT + inout_cnt
             WHERE ID = row_data.ID;
        END IF;
    END IF;
    res := 1;
    COMMIT;
EXCEPTION
    WHEN invalid_type THEN
        DBMS_OUTPUT.PUT_LINE('입출력 타입을 잘못 지정하였습니다. (''I'' 또는 ''O'')');
    WHEN no_out_data THEN
        DBMS_OUTPUT.PUT_LINE('출고 할 상품이 없습니다. 또는 수량이 부족합니다.');
    WHEN not_enough_count THEN
        DBMS_OUTPUT.PUT_LINE('출고 수량이 부족합니다.');
        ROLLBACK;
END;

SELECT * FROM USER_ERRORS;

DECLARE
    res NUMBER;
BEGIN
    PROC_재고입출등록('제품A', 'o', 45, TO_DATE(20220502), res);
    DBMS_OUTPUT.PUT_LINE('실행 결과: ' || res);
END;

SELECT * FROM 재고입출고;
SELECT * FROM 재고관리;

DELETE FROM 재고입출고;