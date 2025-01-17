USE practice_sql;

CREATE TABLE employee(
	employee_number INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT,
    department_code VARCHAR(2)
);

CREATE TABLE department(
	department_code VARCHAR(2) PRIMARY KEY,
    name VARCHAR(30),
    tel_number VARCHAR(15)
);


ALTER TABLE employee ADD CONSTRAINT employee_department_code_fk
FOREIGN KEY (department_code) REFERENCES department (department_code);
-- FOREIGN KEY 설정 시 RIGHT JOIN과 FULL JOIN 잘안됨. 그래서 수업떄는 제약조건 지움.
ALTER TABLE employee DROP CONSTRAINT employee_department_code_fk;

INSERT INTO department VALUES ('A', '영업부', '051-111-1111');
INSERT INTO department VALUES ('B', '인사부', '051-111-2222');
INSERT INTO department VALUES ('C', '총무부', '051-111-3333');

INSERT INTO employee (name, age, department_code) VALUES ('홍길동', 23, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('이영희', 32, 'D');
INSERT INTO employee (name, age, department_code) VALUES ('김철수', 23, 'B');
INSERT INTO employee (name, age, department_code) VALUES ('이성계', 40, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('왕건', 18, 'D');

SELECT * FROM department;
SELECT * FROM employee;

-- Alias : 쿼리문에서 사용되는 별칭 (AS 키워드 사용)
-- 컬럼 및 테이블에서 사용가능
-- 결과 혹은 원래이름을 다르게 지정하고 싶을 때 사용
SELECT 
	employee_number AS '사번',
    name AS '사원 이름',
    age AS '사원 나이',
    department_code AS '부서 코드'
FROM employee AS e;

-- AS 키워드는 생략 가능
SELECT 
	employee_number '사번',
    name '사원 이름',
    age '사원 나이',
    department_code '부서 코드'
FROM employee e;

-- JOIN: 두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회하고자 할 때 사용하는 명령어

-- INNER JOIN: 두 테이블에서 조건이 일치하는 레코드만 반환
-- SELECT column, ... FROM 기준테이블 INNER JOIN 조합할테이블 ON 조인조건
-- JOIN이 포함된 WHERE은 JOIN 이후의 테이블에서 조건 검사함
SELECT 
   E.employee_number,
    E.name,
    E.age,
    E.department_code,
    D.name,
    D.tel_number
FROM employee E
INNER JOIN department D
ON E.department_code = D.department_code
WHERE E.age < 20;

-- LEFT OUTER JOIN (LEFT JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약, 조합할 테이블에 조건에 부합하는 레코도그 존재하지 않으면 null로 채움
SELECT 
   E.employee_number,
    E.name,
    E.age,
    E.department_code,
    D.name,
    D.tel_number
FROM employee E
LEFT JOIN department D
ON E.department_code = D.department_code;

-- RIGHT OUTER JOIN(RIGHT JOIN) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
SELECT 
   E.employee_number,
    E.name,
    E.age,
    E.department_code,
    D.name,
    D.tel_number
FROM employee E
RIGHT JOIN department D
ON E.department_code = D.department_code;

-- FULL OUTER JOIN(FULL JOIN): 기준 테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 반환
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 부합하는 레코드가 존재하지 않으면 null로 반환
-- 하지만 MYSQL에서는 FULL OUTER JOIN을 문법상으로 지원하지 않음
-- FULL JOIN = LEFT JOIN + RIGHT JOIN -> 합집합으로 한다는것.
SELECT 
   E.employee_number,
    E.name,
    E.age,
    E.department_code,
    D.name,
    D.tel_number
FROM employee E
LEFT JOIN department D
ON E.department_code = D.department_code
UNION
SELECT 
   E.employee_number,
    E.name,
    E.age,
    E.department_code,
    D.name,
    D.tel_number
FROM employee E
RIGHT JOIN department D
ON E.department_code = D.department_code;

-- CROSS JOIN: 기준 테이블에 각 레코드를 조합할 테이블의 각 레코드와 조합하여 반환
-- CROSS JOIN 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블의 레코드 수
-- CROOS JOIN에서는 ON 조건들이 필요 없음

SELECT * FROM employee E CROSS JOIN department D;

-- MYSQL에서 기본 조인이 CROOS JOIN임
SELECT * FROM employee E JOIN department D;

SELECT * FROM employee E, department D;

-- 부서코드가 A인 사원에 대해 사번, 사원의 이름, 부서명을 조회하시오
SELECT E.employee_number '사번' , E.name '사원' , D.name '부서명' 
FROM employee E INNER JOIN department D  -- left, right, full 다 됨.
ON E.department_code = D.department_code
WHERE E.department_code = 'A';

-- 부서명이 '영업부'인 사원에 대해 사번, 이름, 나이를 조회하시오.
SELECT E.employee_number '사번', e.name '이름', e.age '나이' 
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code
WHERE D.name = '영업부';
























