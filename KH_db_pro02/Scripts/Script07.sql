CREATE TABLE SAMPLE(
       ID       NUMBER                      PRIMARY KEY
     , NAME     VARCHAR2(30)                NOT NULL
     , GENDER   CHAR(1)                     CHECK(GENDER IN ('F', 'M'))
     , AGE      NUMBER         DEFAULT(0)   NOT NULL
);

INSERT INTO SAMPLE(ID, NAME, GENDER, AGE) VALUES(1, '홍길동', 'M', 27);
INSERT INTO SAMPLE(ID, NAME, GENDER, AGE) VALUES(2, '김주영', 'M', 30);
INSERT INTO SAMPLE(ID, NAME, GENDER     ) VALUES(3, '박수안', 'F'    );
INSERT INTO SAMPLE(ID, NAME, GENDER, AGE) VALUES(4, '이종석', 'M', 25);
INSERT INTO SAMPLE VALUES(5, '최설은', 'F', DEFAULT);

COMMIT;

CREATE OR REPLACE VIEW V_SAMPLE
    AS SELECT ID
            , NAME
            , GENDER
            , AGE
         FROM SAMPLE
        WHERE AGE BETWEEN 20 AND 29
WITH READ ONLY;
-- WITH CHECK OPTION;

UPDATE V_SAMPLE
   SET AGE = 21
 WHERE ID = 1;

SELECT * FROM USER_VIEWS;
SELECT * FROM V_SAMPLE;
SELECT * FROM SAMPLE;

INSERT INTO V_SAMPLE VALUES(7, '김도연', 'F', 23);






DROP SEQUENCE SEQ_TEST;
CREATE SEQUENCE SEQ_TEST
          START WITH 300
      INCREMENT BY     5
       MAXVALUE      310
       MINVALUE      250
          CYCLE
        NOCACHE;

SELECT SEQ_TEST.NEXTVAL FROM DUAL;

SELECT SEQ_TEST.CURRVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'SEQ_TEST';


CREATE SEQUENCE SEQ_SAMPLE START WITH 7 NOCACHE;

SELECT * FROM SAMPLE;
INSERT INTO SAMPLE VALUES(SEQ_SAMPLE.NEXTVAL, '시퀸스', 'F', 0);
DELETE FROM SAMPLE WHERE ID = 25;


COMMIT;








