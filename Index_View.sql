USE practice_sql;

-- 인덱스 (Index): 테이블에서 원하는 컬럼을 빠르게 조회하기 위해 사용하는 구조

-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(컬럼, ...);
CREATE INDEX transaction_amount_idx ON transaction (amount);
CREATE INDEX transaction_tax_idx ON transaction(amount, tax); -- amount에 대한 검색속도 빠름
CREATE INDEX transaction_tax_amount_idx ON transaction(tax, amount); -- tax에 대한 검색속도 빠름
CREATE INDEX transaction_amount_desc_idx ON transaction(amount DESC); -- 디폴트는 ASC

-- 테이블에 인덱스 추가
-- ALTER TABLE 테이블명 ADD INDEX 인덱스이름(컬럼명);
ALTER TABLE employee ADD INDEX employee_name_idx(name);

-- 인덱스 삭제
-- DROP INDEX 인덱스명 ON 테이블명;
DROP INDEX transaction_amount_desc_idx ON transaction;

-- 테이블에서 인덱스 삭제
-- ALTER TABLE 테이블명 DROP INDEX 인덱스명;
ALTER TABLE transaction DROP INDEX transaction_amount_idx;
-- WHERE 절에 많이 등장하는 녀석 idx 설정
-- 장점: 조회속도 및 성능 향상
-- 단점: 저장공간이 높아짐, 관리가 불편해짐, 적절한 인덱스 사용 못할 시 성능을 계속 저하

-- 뷰(view): 물리적으로는 존재하지 않는 읽기 전용의 가상 테이블
-- 조회문을 미리 작성해서 재사용하는 용도, 컬럼에 대한 제한된 보기를 제공하는 용도

-- 뷰 생성
-- CREATE VIEW 뷰이름 AS 조회문;
USE school;
CREATE VIEW class_summary AS SELECT 
	C.class_code '수업 코드',
	C.name '수업 이름',
    T.name '담당교사 이름',
    T.position '담당교사 직급',
    SUB.min '최소 점수',
    SUB.max '최대 점수'
FROM class C
LEFT JOIN teacher T ON C.charge_teacher = T.teacher_number
LEFT JOIN(
	SELECT 
    class_code,
    MIN(score) 'min',
    MAX(score) 'max'
    FROM class_regist
    GROUP BY class_code
)SUB
ON C.class_code = SUB.class_code;

SELECT * FROM class_summary;
SELECT * FROM class_summary WHERE `최소 점수`>= 70;

-- VIEW는 물리적인 저장공간이 존재하지 않기 때문에
-- INSERT, UPDATE, DELETE 및 INDEX 생성이 불가능

-- 테이블 접근 및 컬럼 접근 권한에 대한 제어를 쉽게 할 수 있음
CREATE VIEW teacher_summary AS 
SELECT teacher_number, name, position
FROM teacher;

SELECT * FROM teacher_summary;

-- GRANT SELECT ON school.teacher_summary TO 사용자@호스트명;


-- VIEW 수정
-- ALTER VIEW 뷰이름 AS 조회문 ~
ALTER VIEW teacher_summary AS
SELECT name, position
FROM teacher;

SELECT * FROM teacher_summary;

-- VIEW 삭제
-- DROP VIEW 뷰이름
DROP VIEW teacher_summary;






