/*
 * 1. 관리자 계정으로 전환하여 다음의 권한을 가지는 사용자를 생성한다.
 *      A. dev01 계정을 생성하고 RESOURCE, CONNECT, CREATE SESSION 권한을 부여한다.
 *      B. dev02 계정을 생성하고 CONNECT, CREATE SESSION, INSERT, UPDATE, DELETE 권한을 부여한다.
 *      C. devAdmin 계정을 생성하고 RESOURCE, CONNECT, CREATE SESSION, INSERT, UPDATE, DELETE 권한을 부여한다.
 *    위 권한을 부여 한 후 확인까지 해 본다.
 * 
 * 2. devAdmin 계정으로 전환하여 다음의 작업을 수행한다.
 *      A. 회원관리를 위한 테이블(USER_ACCOUNT)을 생성한다.
 *         식별값, 회원아이디, 회원패스워드, 회원명, 나이, 성별 정보를 관리할 수 있는 컬럼을 포함하도록 한다.
 *      B. 회원관리에서 사용하는 식별값은 SEQUENCE 객체를 이용하도록 한다.
 *      C. 회원 정보를 별도로 관리하기 위한 테이블(INFO_ACCOUNT)을 생성한다.
 *         식별값, 이메일주소, 주소, 전화번호 정보를 관리할 수 있는 컬럼을 포함하도록 한다.
 *         식별값은 회원관리의 식별값과 외래키 관계가 될 수 있도록 한다.
 * 3. 2번에서 생성한 테이블에 데이터를 추가하기 위한 INSERT 구문 3개만 만들어 데이터 추가를 한다.
 * 4. 2번에서 생성한 테이블을 다른 개발자가 쉽게 볼 수 있도록 VIEW 테이블(V_USER_INFO)을 생성한다.
 *    해당 뷰 테이블에는 회원아이디, 회원명, 나이, 성별, 이메일주소, 주소, 전화번호 정보만 보이도록 한다.
 *    성별을 보여 줄 때 'F' 는 '여성' 으로 'M' 은 '남성' 으로 변환되어 보여지게 한다.
 */
CREATE USER dev01 IDENTIFIED BY rPqkfwk12345678;
CREATE USER dev02 IDENTIFIED BY rPqkfwk12345678;
CREATE USER devAdmin IDENTIFIED BY rPqkfwk12345678;

GRANT CONNECT, RESOURCE, CREATE SESSION TO dev01;
GRANT CONNECT, CREATE SESSION, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE TO dev02;
GRANT CONNECT, RESOURCE, CREATE SESSION
    , INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE
    , CREATE VIEW
   TO devAdmin;

ALTER USER devAdmin quota 10M ON DATA;

COMMIT;

SELECT * FROM ALL_USERS WHERE USERNAME LIKE 'DEV%';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE LIKE 'DEV%';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE LIKE 'DEV%';

--------------------------------------------------------------------------------
CREATE TABLE USER_ACCOUNT(
       ID        NUMBER        CONSTRAINT PK_USER_ACCOUNT_ID        PRIMARY KEY
     , USERNAME  VARCHAR2(30)  CONSTRAINT NN_USER_ACCOUNT_USERNAME  NOT NULL
     , PASSWORD  VARCHAR2(30)  CONSTRAINT NN_USER_ACCOUNT_PASSWORD  NOT NULL
     , NAME      VARCHAR2(30)  CONSTRAINT NN_USER_ACCOUNT_NAME      NOT NULL
     , AGE       NUMBER(3)     CONSTRAINT CK_USER_ACCOUNT_AGE       CHECK(AGE BETWEEN 0 AND 199)
     , GENDER    CHAR(1)       CONSTRAINT CK_USER_ACCOUNT_GENDER    CHECK(GENDER IN ('F', 'M'))
);

CREATE SEQUENCE USER_ACCOUNT_SEQ NOCACHE;

CREATE TABLE INFO_ACCOUNT(
       ID       NUMBER         CONSTRAINT PK_INFO_ACCOUNT_ID  PRIMARY KEY
     , EMAIL    VARCHAR2(100)
     , ADDRESS  VARCHAR2(100)
     , PHONE    VARCHAR2(15)
     , CONSTRAINT FK_INFO_ACCOUNT_ID FOREIGN KEY(ID) REFERENCES USER_ACCOUNT(ID)
);

SELECT * FROM USER_ACCOUNT;
SELECT * FROM INFO_ACCOUNT;
SELECT * FROM ALL_ALL_TABLES WHERE OWNER = 'DEVADMIN' AND TABLE_NAME IN ('USER_ACCOUNT', 'INFO_ACCOUNT');
SELECT * FROM ALL_TAB_COLUMNS WHERE OWNER = 'DEVADMIN' AND TABLE_NAME IN ('USER_ACCOUNT', 'INFO_ACCOUNT');
SELECT * FROM USER_CONSTRAINTS WHERE OWNER = 'DEVADMIN' AND TABLE_NAME IN ('USER_ACCOUNT', 'INFO_ACCOUNT');
SELECT * FROM USER_SEQUENCES;

------------------------------------------------------------------------

INSERT INTO USER_ACCOUNT VALUES(USER_ACCOUNT_SEQ.NEXTVAL, 'user1', 'user1', '사용자1', 23, 'F');
INSERT INTO INFO_ACCOUNT VALUES(USER_ACCOUNT_SEQ.CURRVAL, NULL, NULL, NULL);

INSERT INTO USER_ACCOUNT VALUES(USER_ACCOUNT_SEQ.NEXTVAL, 'user2', 'user2', '사용자2', 25, 'F');
INSERT INTO INFO_ACCOUNT VALUES(USER_ACCOUNT_SEQ.CURRVAL, NULL, NULL, NULL);

INSERT INTO USER_ACCOUNT VALUES(USER_ACCOUNT_SEQ.NEXTVAL, 'user3', 'user3', '사용자3', 28, 'M');
INSERT INTO INFO_ACCOUNT VALUES(USER_ACCOUNT_SEQ.CURRVAL, NULL, NULL, NULL);

-------------------------------------------------------------------------

CREATE OR REPLACE VIEW V_USER_INFO
    AS SELECT A.USERNAME
            , A.NAME
            , A.AGE
            , DECODE(A.GENDER, 'F', '여성', 'M', '남성') AS GENDER
            , B.EMAIL
            , B.ADDRESS
            , B.PHONE
         FROM USER_ACCOUNT A
         JOIN INFO_ACCOUNT B
           ON A.ID = B.ID;

SELECT * FROM V_USER_INFO;
SELECT * FROM USER_VIEWS;
