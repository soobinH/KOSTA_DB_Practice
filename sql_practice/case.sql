-- CASE
-- emp 테이블에서
-- deptno가 10이면 'ACCOUNTING'
-- deptno가 20이면 'RESEARCH'
-- deptno가 30이면 'SALES'
-- deptno가 40이면 'OPERATIONS' 으로 변경하여 조회

SELECT empno, ename, deptno,
	case 
		when deptno = 10 then 'ACCOUNTING'
		when deptno= 20 then 'RESEARCH'
		when deptno = 30 then 'SALES'
		when deptno = 40 then 'OPERATIONS'	
	END AS dname
FROM emp;

-- 상단에 바꿀 변수를 적어두고 when 절에 조건만 작성해도 됨

SELECT empno, ename, deptno,
	case deptno
		when 10 then 'ACCOUNTING'
		when 20 then 'RESEARCH'
		when 30 then 'SALES'
		when 40 then 'OPERATIONS'	
	END AS dname
FROM emp;

-- exam_01 테이블에서 total 값이 90 이상이면 A, 80 -> B, 70 -> C, 60 -> D, 나머지 F로 조회
SELECT studno, total, 
	case 
		when total>= 90 then 'A'
		when total>= 80 then 'B'
		when total>= 70 then 'C'
		when total>= 60 then 'D'
		when total<= 59 then 'F'
	END AS grade
FROM exam_01;

-- student 테이블에서 주민번호를 이용하여 성별을 조회
-- 주민번호 7번째 자리가 1이나 3이면 man, 2거나 4면 woman으로 조회
-- 학번, 이름, 주민번호, 성별
SELECT studno, NAME, jumin, 
	case
		when substr(jumin, 7, 1) IN (1, 3) then 'man'
		when substr(jumin, 7, 1) IN (2, 4) then 'woman'
	END AS gender
FROM student;

-- student 테이블에서 학생의 이름, 전화번호, 지역을 조회
-- 단 지역은 전화번호의 지역 번호로
-- 02: 서울, 031: 경기, 051: 부산, 052: 울산, 053: 대구, 055: 경남으로 조회
SELECT NAME, tel, 
	case SUBSTR(tel, 1, INSTR(tel, ')')-1)
		when 02 then '서울'
		when 031 then '경기'
		when 051 then '부산'
		when 052 then '울산'
		when 053 then '대구'
		when 055 then '경남'
	END AS 지역번호 
FROM student;

-- student 테이블에서 생년월일을 참조하여 태어난 달과 분기 조회
-- 태어난 달이 1~3월이면 1/4분기
-- 태어난 달이 4~6월이면 2/4분기
-- 태어난 달이 7~9월이면 3/4분기
-- 태어난 달이 10~12월이면 4/4분기
-- 조회 칼럼: 이름, 생년월일, 태어난 달, 분기
SELECT NAME, birthday, MONTH(birthday), 
	case 
		when MONTH(birthday) < 4 then'1/4 분기'
		when MONTH(birthday) < 7 then '2/4 분기'
		when MONTH(birthday) < 9 then '3/4 분기'
		when MONTH(birthday) < 13 then '4/4 분기'
	END AS 분기
FROM student;

SELECT NAME, birthday, MONTH(birthday), 
	CONCAT(EXTRACT(QUARTER FROM birthday), '/4분기') 분기
FROM student;


-- professor 테이블에서 학과번호, 교수명, 학과명 조회
-- 단, 학과번호가 101인 교수만 학과명을 'Computer Engineering'으로 하고 나머지는 아무것도 출력하지 않는다.
SELECT deptno, NAME, 
	case deptno
		when 101 then 'Computer Engineering'
		ELSE ''
	END AS 학과명
FROM professor;
