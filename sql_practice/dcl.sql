-- ----------------------------------------------------------------------------------------------------------------
-- 계정 생성, 권한 부여, 권한 제거
-- ----------------------------------------------------------------------------------------------------------------
-- DCL(Data Control Language) : grant(권한 주기), revoke(권한 뺏기)
-- ----------------------------------------------------------------------------------------------------------------
-- 존재하는 계좌 확인
USE mysql;
SELECT HOST, user, password FROM user;

-- 계정 생성
CREATE user 'kosta2'@'%' IDENTIFIED BY '7564'; -- 외부 pc, 웹서버, 모바일 등 어디서든 접속 가능
CREATE user 'kosta2'@'localhost' IDENTIFIED BY '7564'; -- db가 설치된 pc(서버) 내부에서만 접속 가능

DROP user 'kosta2'@'%';

ALTER user 'kosta3'@'localhost' IDENTIFIED BY '7654';
-- 권한 보기
SHOW GRANTS FOR 'kosta2'@'%';

-- 권한 부여
GRANT ALL PRIVILEGES ON kostadb26_2. * TO 'kosta2'@'%';

-- 모든 권한 회수
REVOKE ALL PRIVILEGES ON kostadb26_2.* FROM 'kosta2'@'%'; 

-- 데이터 베이스의emp 테이블에 select insert update 권한 부여 및 회수
GRANT SELECT, INSERT, UPDATE ON kostadb26_2.emp TO 'kosta2'@'%';
REVOKE INSERT, UPDATE ON kostadb26_2.emp FROM 'kosta2'@'%';

-- 데이터베이스의 emp2 테이블의 select 권한 부여
GRANT SELECT ON kostadb26_2.emp2 TO 'kosta2'@'%';

GRANT ALL ON kostadb26_2.department TO 'kosta2'@'%';

-- 여러 사용자에게 동일한 세트의 권한을 줘야한다면 role을 만들어 관리하면 효율적이다.
-- role에 필요한 권한을 부여하고
-- 그 role을 사용자에게 부여한다.
CREATE ROLE 'developer_role';
GRANT ALL ON kosta26_2.department TO 'developer_role';
CREATE user 'kosta4'@'%' IDENTIFIED BY '2345';
GRANT 'developer_role' TO 'kosta4'@'%';


