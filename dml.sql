-- ----------------------------------------------------------------------------------------------------------------
-- DML(Data Maniqulation Language : 데이터 조작어) : insert, update, delete - Transaction의 대상(commit, rollback)
-- ----------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------------------------------
-- insert into table_name (column_name1, column_name2, ...) values(value1, value2, ...)
-- ----------------------------------------------------------------------------------------------------------------
CREATE TABLE USER (
	id VARCHAR(10),
	NAME VARCHAR(20)
);

INSERT INTO USER (id, NAME) VALUES('hong', '홍길동');
INSERT INTO USER (id, NAME) VALUES('gom', '곰순이');
INSERT INTO USER(NAME, id) VALUES('짭순이', 'hello');
INSERT INTO USER VALUES('song', '송길동'); -- 모든 칼럼을 삽입 시 칼럼 목록 생략 가능, 단 칼럼 순서대로 입력
INSERT INTO USER(id) VALUES('tong'); -- 일부 칼럼을 삽입 시 칼럼 목록 생략 불가능

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255),
	content VARCHAR(255),
	writer VARCHAR(255)
);

-- article data insert
-- 1. 'title1', 'content1'
INSERT into article(title, content) VALUES('title1', 'content1');
-- 2. 'title2'
INSERT into article(title) VALUES('title2');
-- 3. 'content3'
INSERT into article(content) VALUES('content3');
-- 4. 'title4' 'content4' 'hong'
INSERT into article VALUES (NULL, 'title4', 'content4', 'hong');
-- 5.'title5', 'song'
INSERT INTO article(title, writer) VALUES('title5', 'song');
-- 6. 'content6' 'park'
INSERT INTO article(content, writer) VALUES('content6', 'park');

-- insert into select : select의 결과값을 테이블에 삽입
CREATE TABLE emp_sub2(
	id INT,
	NAME VARCHAR(30)
);

INSERT INTO emp_sub2(id, NAME)
SELECT empno, ename FROM emp WHERE deptno = 10;


SELECT @@autocommit;
SET autocommit = 0;

INSERT INTO article VALUES (NULL, '글제목', '글내용', 'hong');
COMMIT;
ROLLBACK;

SET autocommit =1;
INSERT INTO article(title, content, writer) VALUES('글제목2', '글내용2', 'song');
ROLLBACK; -- autocommit 상태이기 때문에 취소 처리가 불가능하다.

-- ----------------------------------------------------------------------------------------------------------------
-- update table_name set column_name1 = value1, column_name2 = value2, ... where 조건식
-- ----------------------------------------------------------------------------------------------------------------


CREATE TABLE ACCOUNT(
	id VARCHAR(255),
	balance INT
);

INSERT INTO ACCOUNT VALUES('1001', 100000);
INSERT INTO ACCOUNT VALUES('1002', 200000);

-- 보내는 계좌 1001, 받는 계좌 1002, 송금액 50000
-- 1001 계좌에서 1002 계좌에 50000원 이체
-- transaction 시작
SET autocommit = 0;
UPDATE ACCOUNT SET balance = balance-50000 WHERE id='1001';

-- 가져온 계좌가없으면 보내는계ㅗ자번호 없음 예외처리
SELECT * FROM ACCOUNT WHERE id = '1002';

-- 가져온 계좌가 없으면 rollback 처리하고 받는 계좌번호 없음 예외처리
UPDATE ACCOUNT SET balance = balance +50000 WHERE id = '1002';
COMMIT;
SET autocommit = 1;
-- transaction end

START TRANSACTION;
UPDATE ACCOUNT SET balance = balance-50000 WHERE id = '1002';
UPDATE ACCOUNT SET balance= balance+50000 WHERE id = '1001';
COMMIT;
ROLLBACK;

INSERT INTO emp VALUES(9999, 'gildong','sales', 7521, CURDATE(), 400, 0, 10);

-- gildong의 담당 업무를 'clerk', 담당 매니저를 7782로 변경
UPDATE emp SET job = 'CLERK', mgr = 7782 WHERE ename = 'gildong';

-- emp : comm이 없는 사람은 100으로 준다.
UPDATE emp SET comm = 100 WHERE comm IS NULL OR comm = 0;

-- emp : SMITH와 같은 업무를 담당하는 사람들의 급여를 30% 인상
UPDATE emp SET sal = sal+(sal*0.3) WHERE job = (SELECT job FROM emp WHERE ename = 'SMITH');

-- emp : 부서번호가 10인 부서만 comm을 급여의 10퍼센트 더 준다.
UPDATE emp SET comm = comm + (sal*0.1) WHERE deptno = 10;

-- ----------------------------------------------------------------------------------------------------------------
-- delete from table_name where 조건;
-- ----------------------------------------------------------------------------------------------------------------
-- emp: 이름이 gildong 인 데이터 삭제
DELETE FROM emp WHERE ename = 'gildong';

START TRANSACTION;
DELETE FROM emp_sub2;
COMMIT;
ROLLBACK;

START TRANSACTION;
DELETE FROM article WHERE writer = 'park';
UPDATE article SET writer = 'hong' WHERE num = 1;
DELETE FROM article WHERE writer = 'song';
ROLLBACK;
COMMIT;

SELECT @@autocommit;
SET autocommit = 1;

UPDATE article SET writer = 'park' WHERE num=1;
