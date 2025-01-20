use school;

DROP TABLE class;
DROP TABLE student;
DROP TABLE teacher;
DROP TABLE classroom;

-- 학생(학번, 이름, 주소, 휴대전화번호)
-- 학번 문자열(5) NN, UQ, PK
-- 이름 문자열(15) NN
-- 주소 장문의 문자열 NN
-- 휴대전화번호 문자열(13) UQ

	CREATE TABLE student (
    student_number VARCHAR(5) NOT NULL UNIQUE,
    name VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    tel_number VARCHAR(13) UNIQUE,
    CONSTRAINT student_pk PRIMARY KEY (student_number)
    );

-- 교사(교번, 이름, 주소, 휴대전화번호, 직급)
-- 교번 문자열(10) NN, UQ, PK
-- 이름 문자열(15) NN
-- 주소 장문의 문자열 NN
-- 휴대전화번호 문자열(13) NN, UQ
-- 직급 문자열(50) NN DF '일반 교사'

	CREATE TABLE teacher(
    teacher_number VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    tel_number VARCHAR(13) NOT NULL UNIQUE,
    position VARCHAR(50) NOT NULL DEFAULT '일반 교사',
    CONSTRAINT teacher_pk PRIMARY KEY (teacher_number)
    );

-- 교실(교실번호, 층수, 좌석)
-- 교실번호 정수 NN UQ PK
-- 층수 정수 NN CK(1층 ~ 5층)
-- 좌석 정수 NN CK(0 이상)

	CREATE TABLE class_room(
		class_room_number INT NOT NULL AUTO_INCREMENT,
        floor INT NOT NULL CHECK(floor BETWEEN 1 AND 5),
        seats INT NOT NULL CHECK(seats >= 0),
        
        CONSTRAINT class_room_pk PRIMARY KEY (class_room_number)
    );

-- 수업은 교실과 교사에 종속적
-- 수업(수업코드, 이름)
-- 수업코드 문자열(3) NN UQ PK
-- 이름 문자열(50) NN 
-- 교실 정수 NN FK (교실 - 교실번호)
-- 담당교사 문자열(10) NN FK (교사:교번)

	CREATE TABLE class(
		class_code VARCHAR(3) NOT NULL UNIQUE,
        name VARCHAR(50) NOT NULL,
        class_room INT NOT NULL,
        charge_teacher VARCHAR(10) NOT NULL,
        
        CONSTRAINT class_pk PRIMARY KEY (class_code),
        
        CONSTRAINT class_class_room_fk FOREIGN KEY (class_room) 
        REFERENCES class_room (class_room_number),
        
        CONSTRAINT class_teacher_fk FOREIGN KEY (charge_teacher)
        REFERENCES teacher (teacher_number)
    );-- FK 조건을 만들때 테이블을 다 만들고 ADD CONSTRAINT하는 게 더 좋긴하다. 참조가 없으면 안만들어지기에
    

-- 수강(학번, 수업코드) -부수적인 정보가 들어갈 수 있다.
-- 학번 문자열(5) NN FK (학생 - 학번) -- 학번과 수업코드를 복합키를 이용한 기본키를 만들 수 있으나 이는 나중에 썩 좋지않아
-- 수업코드 문자열(3) NN FK (수업 - 수업코드) -- 의미없는 키를 하나 만들어 사용하는 것이 좋다.
-- 성적 INT 

CREATE TABLE class_regist(
	student_number VARCHAR(5) NOT NULL,
    class_code VARCHAR(3) NOT NULL,
    score INT,
    
    CONSTRAINT class_regist_pk PRIMARY KEY (student_number, class_code),
    
    CONSTRAINT student_regist_fk FOREIGN KEY (student_number) 
    REFERENCES student (student_number),
    
    CONSTRAINT class_regist_class_fk FOREIGN KEY (class_code) 
    REFERENCES class (class_code)
);

-- 하나의 수업은 하나의 교실에서 이루어지고 한명의 교사에 의해서 강의되어지며
-- 여러명의 학생이 수업을 들을 수 있음
-- 단, 수업은 반드시 교실 및 교사가 존재해야 함.
-- 교실은 여러 수업을 진행 할 수 있고 교사는 여러 수업을 강의할 수 있다.

-- 수업은 교실, 교사와는 1:1 관계
-- 학생과는 1:n의 관계
-- 단, 수업은 반드시 교실 및 교사가 존재해야 하고 1명 이상의 학생이 수업을 들어야 한다.
-- 교실, 교사는 여러 수업을 진행할 수 있고, 학생은 여러 수업을 수강할 수 있음

-- 교실 : 수업 = 1:n
-- 교사 : 수업 = 1:n 
-- 학생 : 수업 = n : m -- 수강이라는 관계 테이블을 만들어 
-- n의 위치에 fk를 걸어준다

-- 기본 레코드 사입
INSERT INTO student VALUES ('25001', '홍길동', '부산광역시 부산진구', null);
INSERT INTO student VALUES ('25002', '김철수', '부산광역시 동구', '010-1111-1111');
INSERT INTO student VALUES ('25003', '이영희', '부산광역시 부산진구', '010-1111-2222');
INSERT INTO student VALUES ('25004', '홍길순', '부산광역시 수영구', null);
INSERT INTO student VALUES ('25005', '박보검', '부산광역시 동구', '010-1111-3333');
INSERT INTO student VALUES ('25006', '권지용', '부산광역시 동구', '010-1111-4444');
INSERT INTO student VALUES ('25007', '김태희', '부산광역시 부산진구', '010-1111-5555');
INSERT INTO student VALUES ('25008', '배수지', '부산광역시 중구', null);
INSERT INTO student VALUES ('25009', '남주혁', '부산광역시 부산진구', '010-1111-6666');
INSERT INTO student VALUES ('25010', '한가인', '부산광역시 수영구', '010-1111-7777');

SELECT * FROM student;

INSERT INTO teacher VALUE ('2000010101', '이성계', '부산광역시 강서구', '010-2222-1111', '교장');
INSERT INTO teacher VALUE ('2000010102', '이방과', '부산광역시 북구', '010-2222-2222', '교감');
INSERT INTO teacher VALUE ('2010010101', '이방원', '대구광역시 달성구', '010-2222-3333', '일반교사');
INSERT INTO teacher VALUE ('2010010102', '이도', '부산광역시 부산진구', '010-2222-4444', '일반교사');
INSERT INTO teacher VALUE ('2010010103', '이향', '부산광역시 강서구', '010-2222-5555', '교생');

SELECT * FROM teacher;

INSERT INTO class_room (floor, seats) VALUES (1, 20);
INSERT INTO class_room (floor, seats) VALUES (1, 20);
INSERT INTO class_room (floor, seats) VALUES (2, 30);
INSERT INTO class_room (floor, seats) VALUES (3, 30);

SELECT * FROM class_room;

INSERT INTO class VALUES ('KR1', '국어', 3, '2010010101');
INSERT INTO class VALUES ('KR2', '국어', 1, '2010010103');
INSERT INTO class VALUES ('MT1', '수학', 2, '2010010102');
INSERT INTO class VALUES ('MT2', '수학', 1, '2010010103');
INSERT INTO class VALUES ('EN1', '영어', 2, '2010010101');
INSERT INTO class VALUES ('EN2', '영어', 3, '2010010102');

SELECT * FROM class;

INSERT INTO class_regist VALUES (25001, 'KR1', 100);
INSERT INTO class_regist VALUES (25001, 'MT2', 50);
INSERT INTO class_regist VALUES (25001, 'EN1', 70);
INSERT INTO class_regist VALUES (25002, 'KR2', 80);
INSERT INTO class_regist VALUES (25002, 'MT1', 100);
INSERT INTO class_regist VALUES (25002, 'EN2', 100);
INSERT INTO class_regist VALUES (25003, 'KR2', 40);
INSERT INTO class_regist VALUES (25003, 'MT2', 80);
INSERT INTO class_regist VALUES (25003, 'EN2', 65);
INSERT INTO class_regist VALUES (25004, 'KR1', 70);
INSERT INTO class_regist VALUES (25004, 'MT1', 80);
INSERT INTO class_regist VALUES (25004, 'EN1', 40);
INSERT INTO class_regist VALUES (25005, 'KR1', 100);
INSERT INTO class_regist VALUES (25005, 'MT1', 80);
INSERT INTO class_regist VALUES (25005, 'EN2', 60);
INSERT INTO class_regist VALUES (25006, 'KR2', 60);
INSERT INTO class_regist VALUES (25006, 'MT1', 80);
INSERT INTO class_regist VALUES (25006, 'EN1', 100);
INSERT INTO class_regist VALUES (25007, 'KR2', 75);
INSERT INTO class_regist VALUES (25007, 'MT2', 95);
INSERT INTO class_regist VALUES (25007, 'EN1', 75);
INSERT INTO class_regist VALUES (25008, 'KR1', 95);
INSERT INTO class_regist VALUES (25008, 'MT2', 75);
INSERT INTO class_regist VALUES (25008, 'EN2', 95);
INSERT INTO class_regist VALUES (25009, 'KR1', 100);
INSERT INTO class_regist VALUES (25009, 'MT1', 100);
INSERT INTO class_regist VALUES (25009, 'EN1', 100);
INSERT INTO class_regist VALUES (25010, 'KR2', 70);
INSERT INTO class_regist VALUES (25010, 'MT2', 70);
INSERT INTO class_regist VALUES (25010, 'EN2', 80);

SELECT * FROM class_regist;

-- 1. 수업의 수업코드, 수업이름, 담당교사 이름, 담당교사 직급을 조회하는 쿼리문을 작성하시오
-- > 수업코드, 수업이름은 수업 테이블에 담당교사 이름, 담당교사 직급 교사 테이블에
-- > join 사용하기
-- 참조에 not null이 있다면 INNER, LEFT JOIN이 다 같음
SELECT 
C.class_code '수업 코드',
 C.name '수업 이름',
 T.name '담당교사 이름',
 T.position '담당교사 직급'
 FROM class C LEFT JOIN teacher T 
ON C.charge_teacher = T.teacher_number;

-- 2. MT1 수업을 수강하는 학생의 이름, 주소, 전화번호, 점수를 조회하는 쿼리문을 작성하시오
SELECT 
S.name '이름',
S.address '주소',
S.tel_number '전화번호',
CR.score '점수'
FROM student S INNER JOIN class_regist CR
ON S.student_number = CR.student_number
WHERE CR.class_code = 'MT1';

-- 3. 부산진구에 거주하고 있는 교사가 강의중인 수업의 수업코드와 수업이름을 조회하는 쿼리문을 작성하시오
-- > 조건이 다른 경우라 JOIN을 써도 되지만 성능 문제로 SUBQUERY이용하는 것이 더 좋다.
SELECT 
class_code '수업 코드',
name '수업 이름' 
FROM class 
WHERE charge_teacher IN (
	SELECT teacher_number
	FROM teacher T
	WHERE T.address LIKE '%부산진구%'
); -- UQ도 아니고 LIKE인거 생각하면 여러개가 나오기에 IN을 써야함.

-- 4. 수업 코드별 점수의 평균, 최대, 최소 값을 구하는 쿼리문을 작성하시오
SELECT 
	class_code '수업 코드',
	AVG(score) '평균',
	MAX(score) '최대',
	MIN(score) '최소'
FROM class_regist
GROUP BY class_code;

-- 5. 수업의 평균 점수가 80점 이상인 수업의 수업이름과 담당교사의 이름을 조회하는 쿼리문을 작성하시오
SELECT 
C.name '수업 이름',
T.name '담당 교사이름'
FROM class C LEFT JOIN teacher T
ON C.charge_teacher = T.teacher_number
WHERE C.class_code IN(
SELECT class_code
FROM
(SELECT 
class_code, 
AVG(score) 'avg'
FROM class_regist
GROUP BY class_code
HAVING avg >= 80) SUB
);



-- 6. 수업의 수업코드, 수업이름, 담당교사 이름, 담당교사 직급, 최저 점수, 최대 점수를 조회하는 쿼리문을 작성하시오
-- 수업: 수업코드, 수업이름, 담당교사 이름
-- 선생: 담당교사 직급,   수업이름
-- 수강: 최저 점수, 최대 점수,   수업코드

SELECT
	C.class_code '수업 코드',
    C.name '수업 이름',
    T.name '담당교사 이름',
    T.position '담당교사 직급',
    SUB.min '최저 점수',
    SUB.max '최대 점수'
FROM
class C 
LEFT JOIN teacher T ON C.charge_teacher = T.teacher_number
LEFT JOIN (
SELECT 
class_code,
MAX(score) 'max', 
MIN(score) 'min'
FROM class_regist
GROUP BY class_code
) SUB
ON C.class_code = SUB.class_code;

-- 7. 평균 점수(수학 + 국어 + 영어)가 90점 이상인 학생이 수업중인 교실의 층 및 좌석수를 구하는 쿼리를 작성하시오
-- DISTINCT : 중복 제거

SELECT 
floor '층', 
seats '좌석 수'
FROM class_room
WHERE class_room_number IN(
SELECT DISTINCT class_room
FROM class
WHERE class_code IN(
SELECT DISTINCT class_code
FROM class_regist
WHERE student_number IN(
	SELECT student_number
	FROM (
		SELECT 
			student_number,
			AVG(score) 'avg'
		FROM class_regist
		GROUP BY student_number
		HAVING avg >= 90
		) SUB
)
)
)



