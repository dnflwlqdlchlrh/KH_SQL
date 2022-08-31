/* 
 * 인덱스 설정 안함
 *                                       Cost   Cardinality    Bytes
 * SELECT STATEMENT                       136             1      133
 *     TABLE ACCESS (FULL)                136             1      133
 */
SELECT * FROM USER_MOCK_DATA_ORIGIN WHERE ID = 10000;

/*
 * 인덱스 ID 컬럼에 설정함
 *                                       Cost   Cardinality    Bytes
 * SELECT STATEMENT                         2             1      133
 *     TABLE ACCESS (BY INDEX ROWID)        2             1      133
 *         INDEX (UNIQUE SCAN)              1             1        0
 */
SELECT * FROM USER_MOCK_DATA WHERE ID = 10000;

/*
 * Cost : 예상 비용으로 값이 낮을 수록 적은 비용으로 검색을 수행할 수 있다.
 *        비용이 낮을 뿐이지 빠르다고는 할 수 없음.
 * 
 * Cardinality : 실행 계획에서 Access된 Row 수
 * 
 * Bytes : 실행 계획에서 Access 된 Byte 수
 * 
 * TABLE ACCESS (FULL) : 전체 테이블을 탐색하여 결과를 도출하게 될 것을 예상함.
 * INDEX (UNIQUE SCAN) : 인덱스 객체를 참조하여 탐색 후 결과를 도출하게 될 것을 예상함.
 * TABLE ACCESS (BY INDEX ROWID) : 인덱스 객체로 참조한 INDEX ROWID 로 탐색하여 결과를 도출하게 될 것을 예상함.
 */

SELECT * FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'J%';
SELECT * FROM USER_MOCK_DATA_ORIGIN WHERE FIRST_NAME = 'Jone';

SELECT * FROM USER_MOCK_DATA WHERE ID = 14936 AND FIRST_NAME = 'Jone';
SELECT * FROM USER_MOCK_DATA_ORIGIN WHERE ID = 14936 AND FIRST_NAME = 'Jone';

SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

-- 인덱스 : 검색을 최적화하기 위해 사용하는 ORACLE 객체
--          인덱스를 위한 추가 공간이 필요하며, 검색 속도는 향상시키지만 데이터의 변경
--          작업이 자주 일어나는 경우에는 전체적인 성능이 저하될 수 있다.

-- 고유 인덱스 : 중복이 있으면 안됨.
CREATE UNIQUE INDEX IDX_USER_MOCK_DATA_ID ON USER_MOCK_DATA(ID);

-- 비고유 인덱스
CREATE INDEX IDX_USER_MOCK_DATA_FIRST_NAME ON USER_MOCK_DATA(FIRST_NAME);

-- 결합 인덱스
CREATE INDEX IDX_USER_MOCK_DATA_ID_FIRST_NAME ON USER_MOCK_DATA(ID, FIRST_NAME);

DROP INDEX IDX_USER_MOCK_DATA_ORI_FIRST;

ALTER INDEX IDX_USER_MOCK_DATA_ORI_FIRST REBUILD;