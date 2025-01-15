-- 축구 경기(football) 데이터베이스

-- 참가팀(team) [국가명(nation), 조(seed), 감독(manager), 피파랭킹(ranking)]
-- 선수(player) [이름(name), 생년월일(birth), 포지션(position), 등번호(uniform_number), 국가(country)]
-- 경기장(stadium) [이름(name), 주소(address), 좌석(seats)]
-- 심판(referee) [이름(name), 생년월일(birth), 국가(country), 포지션(position)]

-- 사용자 : football_developer @ % / foot!@
-- 		: football_broadcase @ % / foot#$

-- 참가팀 [대한민국, A, 홍길동, 30]
-- 선수 [이성계, 1998-01-15, 공격수, 10, 대한민국]
-- 경기장 [한양메인스타디움, 대한민국 서울특별시 강남구, 2000]
-- 심판 [이방원, 1994-06-05, 대한민국, 주심]

-- 축구 경기 데이터베이스 생성
CREATE DATABASE football;

-- 축구 경기 데이터베이스 선택
USE football;

-- 팀 테이블 생성
CREATE TABLE team(
	nation VARCHAR(60),
    seed VARCHAR(3), -- alphabet이라서 혹시 모를 여유공간 2정도 더 넣음
    manager VARCHAR (100),
    ranking INT
);

-- 플레이어 테이블 생성
CREATE TABLE player(
	name VARCHAR(100),
    birth VARCHAR(10), -- 10자로 정해져있음
    position VARCHAR(12),
    uniform_number INT,
    country VARCHAR(60)
);

-- 경기장 테이블 생성
CREATE TABLE stadium(
	name VARCHAR(255), -- 단어가 길다고 할때 일반적으로 255으로 잡음.
	address TEXT,
    seats INT
);

-- 심판 테이블 생성
CREATE TABLE referee(
	name VARCHAR(100),
	birth VARCHAR(10),
    country VARCHAR(60),
    position VARCHAR(6)
);

-- 개발자 계정 생성
CREATE USER 'football_developer'@'%' IDENTIFIED BY 'foot!@';
CREATE USER 'football_broadcast'@'%' IDENTIFIED BY 'foot#$';

-- 심판과 선수의 birth 컬럼의 데이터 타입을 DATE로 변경
ALTER TABLE player MODIFY COLUMN birth DATE;
ALTER TABLE referee CHANGE birth birth DATE;