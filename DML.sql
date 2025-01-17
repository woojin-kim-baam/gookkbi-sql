USE practice_sql;

-- 데이터 조작어 (DML)
-- 테이블에 데이터를 삽입, 조회, 수정, 삭제할 때 사용

-- INSERT: 테이블에 레코드를 삽입하는 명령어

-- 1. 모든 컬럼에 대해 삽입
-- INSERT INTO 테이블명 VALUES (데이터1, 데이터2, ...);
-- 테이블 구조의 컬럼 순서에 맞게 모든 데이터를 입력해야 함.

INSERT INTO example_table VALUES ('A', 'B'); -- script언어에서는 작은따옴표 자주 씀

-- 2. 특정 컬럼을 선택하여 삽입
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...) VALUES (데이터1, 데이터2, ...);
-- 지정한 컬럼의 순서와 데이터의 순서가 일치해야함.
-- 만약에 default값이 없으며 not null(제약조건)인 컬럼은 반드시 데이터를 삽입해야함.

INSERT INTO example_table (example_column2) VALUES ('선택 데이터');

-- SELECT: 테이블에서 레코드를 조회할 때 사용하는 명령어

-- 1. 모든 데이터 조회
-- SELECT * FROM 테이블명;
SELECT * FROM example_table;

-- 2. 컬럼 선택 조회
-- SELECT 조회할 컬럼1, 조회할 컬럼2,... FROM 테이블명;
SELECT example_column2 FROM example_table;

-- 3. 레코드(행) 선택 조회
-- SELECT 조회할컬럼, ... FROM 테이블명 WHERE 조건;
SELECT * FROM example_table WHERE column1 IS NULL;

-- UPDATE: 테이블에서 레코드를 수정할 때 사용하는 명령어
-- UPDATE 테이블명 SET 컬럼명 = 변경할 데이터, ... WHERE 조건
UPDATE example_table SET column1 = 'B';
UPDATE example_table SET column1 = 'C' WHERE example_column2 = 'B';

-- DELETE: 테이블에서 레코드를 삭제할 때 사용하는 명령어
-- DELETE FROM 테이블명 WHERE 조건;
DELETE FROM example_table WHERE column1 = 'C';
DELETE FROM example_table;

-- DDL은 정의된 구조를 만지는것, 데이터가 아니라
-- DROP TABLE : DDL 테이블 구조 전체를 제거
-- TRUNCATE TABLE : DDL 테이블 구조만 남기고 상태를 초기화(init이 아닌 reset임)
-- DELETE FROM : DML 테이블 레코드만 제거

TRUNCATE TABLE example_table;

CREATE TABLE auto_table(
	idx INT PRIMARY KEY AUTO_INCREMENT,
	num INT
);

INSERT INTO auto_table (num) VALUES (0);
SELECT * FROM auto_table;
DELETE FROM auto_table; -- 얘를 하고 위에 있는 insert를 하면 idx값은 초기화 x 
TRUNCATE TABLE auto_table; -- 얘를 하고 위에 있는 insert를 하면 idx값은 초기화 됨!.

-- INSERT INTO SELECT : 삽입 작업 시에 조회 결과를 사용하여 삽입
INSERT INTO example_table SELECT * FROM example_table where column1 IS NULL;
SELECT * FROM example_table;










