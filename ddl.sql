-- -----------------------------------------------------------------------------------------------
-- DDL(Data Definition Language) : Create(생성), alter(변경), truncate(잘라내기), drop(삭제)
-- -----------------------------------------------------------------------------------------------
-- DCL(Data Control Language) : grant(권한 주기), revoke(권한 뺏기), 
-- -----------------------------------------------------------------------------------------------
-- TCL(Transaction Control Language) : commit(확정), rollback(취소)
-- -----------------------------------------------------------------------------------------------
-- DQL(Data Query Language) : 데이터 질의어 : select
-- -----------------------------------------------------------------------------------------------
-- DML(Data Maniqulation Language : 데이터 조작어) : insert, update, delete
-- -----------------------------------------------------------------------------------------------
-- CRUD : Create Read Update Delete(데이터 삽입(insert), 읽기(select), 수정(update), 삭제(delete)
-- -----------------------------------------------------------------------------------------------



-- database 생성
CREATE DATABASE mydb;

-- database 삭제
DROP DATABASE mydb;

-- table 생성
CREATE TABLE person(
	id INT,
	last_name VARCHAR(255),
	first_name VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(255)
);

-- table 삭제
DROP TABLE person;

-- create table as
CREATE TABLE emp_sub1 AS;
SELECT empno, ename, job, hiredate, sal FROM emp WHERE deptno=10;

-- emp, dept => emp_dept
CREATE TABLE emp_dept AS;
SELECT e.*, d.dname FROM emp e JOIN dept d USING(deptno) WHERE e.deptno=10;

-- 데이터를 제외한 테이블의 틀만 복사해서 새로운 테이블을 생성
CREATE TABLE emp_dept_cpy AS;
SELECT e.*, d.dname from emp e join dept d USING(deptno) WHERE 1=2;

-- student_cpy 테이블 생성: 데이터 없이
CREATE TABLE student_cpy AS;
SELECT * FROM student WHERE 1 = 2;

-- truncate: 테이블 비우기
DELETE FROM emp_deptemp_dept;
TRUNCATE TABLE emp_sub1emp_sub1;
-- --------------------------------------------------------------------------------
--							 		Delete					Truncate
-- --------------------------------------------------------------------------------
-- 명령어 분류				DML						DD	L		
-- 삭제 단위					행단						테이블 전체(공간초기화)
-- where 절					사용 가능 				사용 불가능(무조건 전체 삭제)
-- 속도						느림(한행씩지우면 로그 기록) 매우 빠름
-- rollback				가능(트랜잭션 로그 기록)	불가능(즉시 반영)
-- auto_increment		초기화안됨(마지막값 유지) 초기화됨(1부터 다시 시작)
-- --------------------------------------------------------------------------------
-- delete : 삭제할 때마다 "어떤 데이터를 지웠다"는 로그를 상세히 남긴다.
-- 			데이터가 많을수록 cpu와 메모리를 많이 사용하며 속도가 느려진다.
-- Truncate : 테이블의 구조만 남기고 데이터가저장된 공간 자체를 해체한다.
-- 				로그를 거의 남기지 않기 때문에 대용량 데이터도 순식간에 삭제된다.
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- alter table
-- --------------------------------------------------------------------------------
-- add column : 테이블에 칼럼 추가
ALTER TABLE person
ADD COLUMN email VARCHAR(255);

-- drop column : 테이블의 칼럼 삭제
ALTER TABLE person
DROP COLUMN email;

-- modify column : 테이블의 칼럼 변경
ALTER TABLE person
RENAME COLUMN city TO AREA;

CREATE TABLE dept_t AS
SELECT * FROM dept;

ALTER TABLE dept_t
RENAME COLUMN loc TO AREA;

-- dept_t 테이블에 loc2컬럼 추가, 크기 255, 기본값'seoul'
ALTER TABLE dept_t
ADD COLUMN loc2 VARCHAR(255) DEFAULT 'SEOUL';

-- loc2를 area2로 변경
ALTER TABLE dept_t
RENAME COLUMN loc2 TO AREA2;

RENAME TABLE dept_t TO dept_temp;


