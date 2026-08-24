-- ----------------------------------------
-- 문자열 함수
-- ----------------------------------------
-- CONCAT : 문자열을 연결할 때 사용하는 함수
-- smith(clerk)
SELECT CONCAT(ename, '(', job, ')') "Name & Job" FROM emp;

-- smith's sal is $800
SELECT CONCAT(ename, '''s sal is $', sal) 
AS "How much his sal" 
FROM emp;

-- format : #, ###, ###, ###.##(숫자형 데이터에 포맷을 지정하여 문자열로 변경
SELECT FORMAT(100000000,0);
SELECT FORMAT(1132434.1256, 2);

-- emp 테이블의 사번, 이름, 급여(세 자리 당 콤마) 조회
SELECT empno, ename, FORMAT(sal, 0) FROM emp;

-- insert : 문자열 내의 지정된 위치에 특정 문자 수만큼 다른 문자열로 변경
SELECT INSERT('http://naver.com', 8, 5, '곰순이') FROM emp; 

-- student 테이블에서 주민번호 뒷자리 7개를 *로 바꾸기
SELECT studno, NAME, INSERT(jumin, 7, 7, '-*******') FROM student;

-- gogak 테이블에서 고객번호, 이름 조회(단, 이름은가운데글자를 * 으로 대체)
SELECT gno, INSERT(gname, 2, 1, '*') FROM gogak;

-- instr : 문자열 내에서 특정 문자의 위치
SELECT INSTR('http://naver.com', 'n');

-- student 테이블에서 tel 칼럼의 ')'의 위치 조회
SELECT INSTR(tel, ')') FROM student;

-- substr: 문자열 내에서 부분 문자열 추출
SELECT SUBSTR('http://naver.com', 8, 5);
SELECT SUBSTR('http://naver.com', 8);

-- student 테이블에서 jumin 번호로 생일이8월인 학생 조회
SELECT * FROM student WHERE SUBSTR(jumin, INSTR(jumin, '0'), 2) = '08';

-- student 테이블에서 학생의 학년, 이름, 지역번호 조회(instr, substr 사용)
SELECT grade, NAME, SUBSTR(tel, 1, INSTR(tel, ')')-1) FROM student;

-- student 테이블에서 학생의 학년, 이름, 국번 조회(instr,substr 사용)
SELECT grade, NAME, SUBSTR(tel, INSTR(tel,')') +1, INSTR(tel, '-')-INSTR(tel,')')-1) FROM student;

-- substring = substr
-- student 테이블에서 남학생들만 학번, 이름, 주민번호 조회
SELECT studno, NAME, jumin FROM student WHERE SUBSTRING(jumin, 7, 1) IN (1, 3);

-- length : 문자열의 바이트 수 구하기(영문 1글자: 1byte, 한글 1글자: 3byte)
SELECT LENGTH('stiven');
SELECT CHAR_LENGTH('스티븐');

SELECT LENGTH(email) FROM professor;

-- captain@abc.net 의 출력: abc.net 7
-- professor 테이블에서 교수번호,이름, 이메일, 이메일의 @이후의 문자열, @이후의 문자열 바이트 수 조회

SELECT profno, NAME, email, 
SUBSTR(email, INSTR(email, '@')+1, CHAR_LENGTH(email)), 
LENGTH(SUBSTR(email, INSTR(email, '@')+1, CHAR_LENGTH(email))) BYTE 
FROM professor;

-- insert(a, b, c, d) : a칼럼에서 b에서부터 c까지를 d로 변경
-- professor 테이블에서 이메일, @ 이후를 kosta.com으로 변경하여 조회
SELECT INSERT(email, INSTR(email, '@')+1,LENGTH(email),'kosta.com') 'kosta email' FROM professor;

-- LOWER(=LCASE) 소문자로 변환
-- UPPER(=UCASE) 대문자로 변환

SELECT LOWER('STIVEN'), LCASE('STIVEN'), UPPER('stiven'), UCASE('stiven');

-- trim : 앞뒤 공백 제거
SELECT LENGTH('   test   '), LENGTH(' t e s t ');
SELECT length(trim('   test   ')), length(trim(' t e s t '));

-- LTRIM : 왼쪽 공백 제거
SELECT LENGTH('   test   '), LENGTH(' t e s t '), length(ltrim('   test   ')), length(ltrim(' t e s t '));

-- LPAD : 왼쪽에 특정 문자로 채워 넣기
SELECT sal, LPAD(ename,20, '#')
FROM emp;

SELECT LPAD(email,20, '123456789')
FROM professor;

-- RPAD: 오른쪽에 특정 문자로 채워 넣기
SELECT sal, RPAD(ename, 20, '*') FROM emp;


-- ----------------------------------------
-- 날짜 함수
-- ----------------------------------------

-- CURDATE, CURRENT_DATE : 현재 DBMS 시스템 날짜
SELECT CURDATE(), CURRENT_DATE();
SELECT CURDATE() +1;

-- adddate, date+add: 연, 월, 일을 더하거나 뺀다.
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL+1 YEAR);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL+1 month);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL+1 DAY);
SELECT CURDATE(), ADDDATE(CURDATE(), +1);

SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL-1 YEAR);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL-1 month);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL-1 DAY);
SELECT CURDATE(), ADDDATE(CURDATE(), -1);

-- 오늘의 이전해, 이전달, 이전일 조회
-- 2025-07-23

SELECT ADDDATE(ADDDATE(adddate(CURDATE(), INTERVAL-1 YEAR), INTERVAL-1 MONTH), INTERVAL-1 DAY);

-- emp 테이블에서 모든 직원의 입사일과 10년 기념일 조회
SELECT hiredate 입사일, ADDDATE(hiredate, INTERVAL+10 YEAR) '10년 기념일'  FROM emp;

-- CURTIME(), CURRENT_TIME()
SELECT CURTIME(), CURRENT_TIME();

-- ADDTIME
SELECT CURTIME(), ADDTIME(CURTIME(), '1:10:50'); -- add 1 hour 10 minute 50 second
SELECT CURTIME(), ADDTIME(CURTIME(), '-1:10:50'); -- minus 1 hour 10 minute 50 second

-- NOW() : 현재 날짜 & 시간
SELECT NOW();
SELECT NOW(), ADDTIME(NOW(),'2 1:10:20'); -- add 2days 1 hour 10 minute 20 second

-- DATEDIFF : 날짜 간격 계산
SELECT hiredate, DATEDIFF(CURDATE(), hiredate) 입사일수 FROM emp;
SELECT DATEDIFF(CURDATE(), '1972-04-03');

-- emp 테이블에서 각 직원의 사번, 이름, 입사일, 입사연차 조회
SELECT empno, ename, hiredate, format(DATEDIFF(CURDATE(), hiredate)/365,0) 입사연차  FROM emp;

-- date_format : 날짜 형식 지정
SELECT DATE_FORMAT(CURDATE(), '%M %D %Y');
SELECT DATE_FORMAT(CURDATE(), '%c %d %Y %1:%i:%s %a');

-- 월: %M(March), %b(Mar), %m(03), %c(3)
-- 연: %Y(2026), %y(26)
-- 일: %d(09), %e(9), %D(9th)
-- 요일: %W(Monday), %a(mon)
-- 시간: %H(16), %L(4) -- 오후 4시
-- %r : hh:mm:ss AM, PM
-- 분:%i
-- 초: %S

-- DATE_SUB : 날짜 빼기
SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY);

-- DAY, DAYOFMONTH : 날짜에서 일 추출
SELECT CURDATE(), DAY(CURDATE()), DAYOFMONTH(CURDATE());

-- emp2 테이블에서 25일이 생일인 직원의 사번, 이름, 생일 조회
SELECT empno, NAME, birthday FROM emp2 WHERE DAY(birthday) = 25;

-- MONTH, YEAR : 날짜에서 연, 월 추출
SELECT MONTH(CURDATE()), YEAR(CURDATE());

-- student 테이블에서 이번 달이 생일인 학생의 학번, 이름, 생년월일 조회
SELECT studno, NAME, birthday FROM student WHERE MONTH(birthday) = MONTH(CURDATE());

-- student 테이블에서 1976년생학생의 학번, 이름, 생년월일 조회
SELECT studno, NAME, birthday FROM student WHERE YEAR(birthday) = 1976;

-- HOUR, MINUTE, SECOND: 시간에서 시, 분, 초, 추출
SELECT CURTIME(), HOUR(CURTIME());
SELECT CURTIME(), MINUTE(CURTIME());
SELECT CURTIME(), SECOND(CURTIME());

SELECT NOW(), HOUR(NOW());
SELECT NOW(), MINUTE(NOW());
SELECT NOW(), SECOND(NOW());

-- DAYNAME, DAYOFWEEK(요일을 숫자로 표시(일요일:1, 월요일:2... 토요일: 7) : 날짜에서 요일 추출
SELECT CURDATE(),DAYNAME(CURDATE()), DAYOFWEEK(CURDATE());
SELECT DAYNAME('1972-04-03');

-- emp 테이블에서 직원의 사번, 이름,입사일,입사요일 조회
SELECT empno, ename, hiredate, DAYNAME(hiredate) FROM emp;

-- student 테이블에서월요일이 생일인 학생들의 학번, 이름, 생일 조회
SELECT studno, NAME, birthday FROM student
WHERE DAYNAME(birthday) = 'Monday';

-- WEEK : 한 해 중 몇 번째 주인지 
SELECT WEEK(CURDATE());

-- EXTRACT : 특정 부분만 추출하는 것
SELECT CURDATE(), EXTRACT(YEAR FROM CURDATE()) AS YEAR;
SELECT CURDATE(), EXTRACT(MONTH FROM CURDATE()) AS MONTH;
SELECT CURDATE(), EXTRACT(DAY FROM CURDATE()) AS DAY; 
SELECT CURDATE(), EXTRACT(WEEK FROM CURDATE()) AS WEEK; -- 한 해 중 몇 번째 주인지
SELECT CURDATE(), EXTRACT(QUARTER FROM CURDATE()) AS QUARTER; -- 분기
SELECT CURDATE(), EXTRACT(YEAR_MONTH FROM CURDATE()) AS 'Year_month';

SELECT NOW(), EXTRACT(HOUR FROM NOW()) AS 'HOUR';
SELECT NOW(), EXTRACT(MINUTE FROM NOW()) AS 'MINUTE';
SELECT NOW(), EXTRACT(SECOND FROM NOW()) AS 'SECOND';

-- ----------------------------------------
-- 숫자 함수
-- ----------------------------------------




