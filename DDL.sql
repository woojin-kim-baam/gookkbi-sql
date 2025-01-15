# 주석
-- 주석 (단순한 설명을 달 때)
-- SQL은 대소문자 가리지 않음. 하지만 대문자로 쓰는거 추천

-- 데이터 정의어 (DDL)
-- 데이터베이스, 테이블, 인덱스, 사용자를 정의하고 관리하는데 사용되는 언어

-- CREATE : 구조를 생성하는 명령어
-- CREATE 생성할구조 구조이름 [구조별 옵션];

-- 데이터베이스 생성 
-- 스크립트는 한 줄씩 실행
-- 명명규칙 : 이름들은 lower snake case 사용이 좋음

CREATE DATABASE practice_sql;
-- 데이터베이스 사용을 먼저 지정해야함 : 데이터베이스 작업을 수행하기 전에 반드시 사용할 데이터베이스를 선택해야 함.
USE practice_sql; -- 이렇게 말고 해당 스키마 더블 클릭을 통해 사용 가능

-- 테이블 생성
CREATE TABLE example_table(
	example_column1 INT,
    example_column2 BOOLEAN
);

-- 컬럼의 데이터 타입
CREATE TABLE data_type(
	-- INT : 정수 타입
    int_c INT,
    -- DOUBLE : 실수 타입
    double_c DOUBLE,
    -- FLOAT : 실수 타입, 데이터베이스에서는 float을 실수로 더 많이 지정함.
    float_c FLOAT,
    -- BOOLEAN : 논리 타입 (실제로는 정수 0(false), 1(true)을 다루는 tiny_int)
    boolean_c BOOLEAN,
    -- VARCHAR(문자열 길이) : 가변길이 문자열
    varchar_c VARCHAR(5), -- 최대길이가 5짜리인 varchar_c, -- 모든 제약조건 하에서 사용 가능
    -- TEXT : 고정된 크기를 가지는 문자열 (64KB), 조금 긴거
    text_c TEXT, -- index, default라는 제약조건 사용 불가
    -- DATE : 날짜
    date_c DATE, -- 관리가 힘듦.
    -- DATETIME : 날짜 및 시간
    datetime_C DATETIME -- 관리가 힘듦.
);

-- 사용자 생성
-- CREATE USER '사용자명'@'접속IP' IDENTIFIED BY '비밀번호';\
-- !!!! 중요함 !!!! --
CREATE USER 'developer'@'%' IDENTIFIED BY 'root'; -- 이렇게만 해놓으면 만들어 두기만 한거라 다른 건 실행하지 못함. 권한이 없기에
CREATE USER 'guest'@'192.168.1.101' IDENTIFIED BY 'qwer1234'; -- %를 쓰면 모두 접근 가능

-- DROP : 데이터 구조(스키마)를 삭제할 때 사용하는 명령어
-- DROP 구조이름(스키마명)

-- 사용자 삭제
DROP USER 'guest'@'192.168.1.101';

-- 테이블 삭제
DROP TABLE data_type;

-- 데이터베이스 삭제
DROP DATABASE practice_sql;

-- ALTER : 데이터 구조(스키마)를 변경하는 명령어

-- 테이블 컬럼 추가
ALTER TABLE example_table ADD example_column3 VARCHAR(10);

-- 테이블 컬럼 삭제
ALTER TABLE example_table DROP COLUMN example_column3;

-- 테이블 컬럼 타입 수정
ALTER TABLE example_table MODIFY COLUMN example_column2 TEXT;

-- 테이블 컬럼 전체 수정 (하나의 컬럼에 대해 전반적인 것을 변경)
ALTER TABLE example_table CHANGE example_column1 column1 VARCHAR(5); -- 이름 변경 하고 타입 변경됨. -- 타입 변경은 최대한 지양

-- 데이터베이스 문자셋 수정
ALTER DATABASE practice_sql DEFAULT CHARACTER SET utf8;












