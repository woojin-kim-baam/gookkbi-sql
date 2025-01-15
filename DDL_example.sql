-- 학교 데이터베이스

-- 학생 (학번, 이름, 주소, 전화번호)
-- 수업 (수업코드, 수업 이름, 교실, 담당교사)
-- 교실 (교실번호, 층, 좌석)
-- 교사 (교번, 이름, 주소, 전화번호, 직책)

-- 개발자 계정: school_developer @ % / school123 -- 순서는 데이터베이스 테이블 계정
-- 개발자 계정: school_developer @ localhost / school123

-- 학교 데이터베이스 생성
CREATE DATABASE school;
-- 학교 데이터베이스 선택
USE school;
-- 학생 테이블 생성
CREATE TABLE student(		-- 복수형태로 적으면 안됨! 단수형태로!
	student_number VARCHAR(5), -- 숫자로 되어있지만 정수형태로 다루지 않고 분류를 위한 코드로 보기에 문자열로 다룸
    name VARCHAR(15), -- 한글자당 대충 3바이트 보면 됨. 그래서 다섯글자라 생각하면 3 * 5
    address TEXT, -- VARCHAR이나 TEXT나 둘다와도 되지만 유용한건 주소를 조건으로 검색을 자주한다면 VARCHAR, 너무 많이 저장하는 경우에는 TEXT 사용
    tel_number VARCHAR(13) -- 정수로 하면 010으로 시작하게 되면 10으로 되버림.
);
-- 테이블 이름은 중복되면 안되지만 다른 클래스에 있는 필드명은 중복되어도 되는 것처럼 여기서도 테이블 내의 column명은 중복되면 안되지만
-- 다른 테이블의 column명은 중복되도 됨.
-- 수업 테이블 생성
CREATE TABLE class(
	class_code VARCHAR(3),
    name VARCHAR(25),
    class_room INT,
    charge_teacher VARCHAR(10)
);
-- 교실 테이블 생성
CREATE TABLE classroom(
	class_room_number INT,
    floor INT,
    seats INT
);
-- 교사 테이블 생성
CREATE TABLE teacher(
	teacher_number VARCHAR(10),
    name VARCHAR(15),
    address TEXT,
    tel_number VARCHAR(13),
    position VARCHAR(50)
);

-- 개발자 계정 생성
CREATE USER 'school_developer'@'%' IDENTIFIED BY 'school123';
CREATE USER 'school_developer'@'localhost' IDENTIFIED BY 'school123';
-- 두개 만든 이유는? 첫번째는 어떤 네트워크에서든 접근 허용, 두번째는 서버 네트워크에서만 접근 허용
-- 첫번째는 권한이 최소가 되게끔 like 수정, 삭제 막기
-- 두번째는 권한이 최대는 아니지만 사용(작업)가능한 모든 권한 부여