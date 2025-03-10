USE practice_sql;

-- 거래내역 테이블
-- 거래번호 정수
-- 거래일짜 날짜
-- 거래구분 가변문자열 10
-- 내역 장문의 문자열
-- 금액 실수
-- 세금 실수
-- 비고 장문의 문자열

CREATE TABLE transaction(
	transaction_number INT,
    transaction_date DATE,
    transaction_type VARCHAR(10),
    breakdown TEXT,
    amount FLOAT,
    tax FLOAT,
    note TEXT
);

TRUNCATE TABLE transaction; -- 틀렸을떄 초기화하고 다시 넣게

INSERT INTO transaction VALUES (1, '2025-01-16', '구매', '기타 자재', 100000, 10000, null);

INSERT INTO transaction VALUES (2, '2025-01-16', '판매', '영양제', 70000, 7000, '종합 비타민');

INSERT INTO transaction VALUES (3, '2025-01-17', '판매', '영양제', 120000, 12000, '종합 비타민');

INSERT INTO transaction VALUES (4, '2025-01-17', '구매', '책상', 400000, 40000, '4개 구매');

INSERT INTO transaction VALUES (5, '2025-01-17', '구매', '의자', 200000, 20000, '4개 구매');

INSERT INTO transaction VALUES (6, '2025-01-20', '판매', '의약외품', 100000, 10000, '소염 진통제');

INSERT INTO transaction VALUES (7, '2025-01-21', '판매', '의약외품', 50000, 5000, '소염 진통제');

INSERT INTO transaction VALUES (8, '2025-01-21', '구매', '기타 자재', 10000, 1000, '볼펜 및 노트');

INSERT INTO transaction VALUES (9, '2025-01-24', '판매', '의료 기기', 800000, 80000, '휠체어');

INSERT INTO transaction VALUES (10, '2025-01-25', '판매', '의료 기기', 50000, 5000, '체온계');

-- 연산자

-- 산술 연산자
-- +, -, *, /, %
SELECT amount + tax FROM transaction;

-- 비교 연산자
-- 좌항과 우항을 비교
-- WHERE 절에서 자주 사용됨, 원하는 레코드를 정확히 조회하는데 중요한 역할을 수행함

-- = : 좌항과 우항이 같으면 true 를 반환
SELECT * FROM transaction WHERE transaction_type = '구매';

-- <>, != : 좌항과 우항이 다르면 true
SELECT * FROM transaction WHERE transaction_type <> '구매';
SELECT * FROM transaction WHERE breakdown != '영양제';

-- < : 좌항이 우항보다 작으면 true
-- <= : 좌항이 우항보다 작거나 같으면 true
SELECT * FROM transaction WHERE amount < 70000;

SELECT * FROM transaction WHERE amount <= 70000; 

-- > : 좌항이 우항보다 크면 true
-- >= : 좌항이 우항보다 크거나 같으면 true

SELECT * FROM transaction WHERE amount > 70000;

SELECT * FROM transaction WHERE amount >= 70000;

ALTER TABLE transaction ADD complete BOOLEAN;

UPDATE transaction SET complete = true WHERE (transaction_number % 3) = 1;

UPDATE transaction SET complete = false WHERE (transaction_number % 3) = 2;

UPDATE transaction SET note = null WHERE transaction_number = 6;

-- <=> : 좌항과 우항이 모두 null이면 true -- 문자열에 숫자가 없으면 0으로 반환함
SELECT * FROM transaction WHERE note <=> complete;

-- IS : 좌항이 우항과 같으면 true (키워드)
-- IS NOT : 좌항이 우항과 다르면 ture (키워드)
SELECT * FROM transaction WHERE complete IS TRUE;
SELECT * FROM transaction WHERE complete IS NOT NULL;

-- BETWEEN min AND max : 좌항이 min보다 크거나 같고 max보다 작거나 같으면 true
-- NOT BETWEEN min AND max : 좌항이 min보다 작거나 max보다 크면 true

SELECT * FROM transaction WHERE transaction_date BETWEEN '2025-01-18' AND '2025-01-22';
-- SQL은 문자열에 대해서도 크거나 작다를 비교 가능, 날짜가 문자열로 되어있으나 비교 가능해서 된 구문.alter

SELECT * FROM transaction WHERE amount NOT BETWEEN 70000 AND 200000;

-- IN() : 주어진 리스트 중에 하나라도 일치하면 true
-- NOT IN() : 주어진 리스트 중에 하나라도 일치하지 않으면 true
SELECT * FROM transaction WHERE breakdown IN('영양제', '의약외품');
-- 								여기 무조건 컬럼이 안오고
							-- 값이 와도 됨.

-- 논리 연산자

-- AND, && : 좌항과 우항이 모두 true이면 true
SELECT * FROM transaction WHERE transaction_type = '구매' AND amount > 100000;

-- OR, || : 좌항과 우항중 하나라도 true이면 true
SELECT * FROM transaction WHERE transaction_date >= '2025-01-21' OR breakdown = '기타 자재';

-- XOR : 좌항과 우항이 서로 다르면 true

-- SELECT * FROM transaction WHERE transaction_date >= '2025-01-20' XOR breakdown = '기타 자재';
--  ->위랑 밑 같은 거임. 표현만 다르게
SELECT * FROM transaction WHERE transaction_date >= '2025-01-20' AND breakdown != '기타 자재'
OR transaction_date < '2025-01-20' AND breakdown = '기타 자재';

-- NOT, ! : 우항이 true면 false, false면 true
SELECT * FROM transaction WHERE NOT (transaction_type = '구매');

-- Like 연산자 : 문자열을 패턴을 기준으로 비교하고자 할 때 사용
-- _ : 임의의 한 문자 표현 
-- % : 임의의 문자 표현 (0~ 무한대)
SELECT * FROM transaction WHERE transaction_date LIKE '2025-01-__';

SELECT * FROM transaction WHERE transaction_date LIKE '2025-01-%';

SELECT * FROM transaction WHERE breakdown LIKE '의%';

SELECT * FROM transaction WHERE breakdown LIKE '의_';

-- 정렬
-- ORDER BY : 조회결과를 특정 컬럼 기준으로 정렬
-- ASC: 오름차순 정렬 / DESC: 내림차순 정렬 / 지정안하면 ASC가 default
SELECT * FROM transaction ORDER BY amount ASC;
SELECT * FROM transaction ORDER BY amount;

SELECT * FROM transaction ORDER BY amount DESC;

SELECT * FROM transaction ORDER BY transaction_type, amount DESC;

-- 중복제거
-- DISTINCT: SELECT 결과 테이블에서 컬럼 조합의 중복을 제거함

SELECT DISTINCT transaction_type FROM transaction;
SELECT DISTINCT transaction_type, breakdown FROM transaction;



SELECT * FROM transaction;









