-- CRUD
-- Create : 데이터 삽입(Insert)
-- Read : 데이터 조회(Select)
-- Update : 데이터 변경(Update)
-- Delete : 데이터 삭제(Delete)

USE kostadb26_2;
-- select 컬럼1, 컬럼2  from 테이블 명: 테이블의 데이터를 조회할때 사용

SELECT * -- *: 전체 칼럼을 의미
FROM emp;  -- from 뒤에는 조회하고 싶은 테이블 이름이 온다.

SELECT empno, ename, job 
FROM emp;

-- dept 테이블에 있는 전체 칼럼 조회
SELECT *
FROM dept;

-- dept 테이블에서 부서번호, 부서명 조회
SELECT deptno, dname
FROM dept;

-- student 테이블에서 학번, 이름, 생일, 전화번호 조회
SELECT studno AS 학번, NAME AS 이름, birthday AS 생일,  tel AS 전화번호
FROM student;

-- where : 행에 대한 조건문(조건에 만족하는 행만 조회할 때 사용)
SELECT * FROM emp WHERE deptno = 10;

-- 부서번호가10인 사원의 사번, 이름, 담당업무, 부서번호 조회
SELECT empno, ename, job, deptno FROM emp WHERE deptno = 10;

-- student 테이블에서 4학년 학생들의 학번, 이름, 생일, 전화번호, 학년 조회
SELECT studno, NAME, birthday, tel, grade FROM student WHERE grade = 4;

-- where 절 연산자
SELECT * 
FROM student 
WHERE grade = 2 
OR grade = 3;

SELECT * 
FROM student 
WHERE grade >= 2 
OR grade <= 3;

SELECT * FROM student WHERE grade IN(2, 3);
SELECT * FROM student WHERE grade NOT IN(1,4);

-- emp 테이블에서 담당업무가 CLERK이거나 SALESMAN인 직원의 사번, 이름, 업무 조회
SELECT empno, ename, job FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN' ORDER BY job;

-- dept 테이블의 전체 칼럼을 조회하되 칼럼명을 부서번호, 부서명, 위치로 변경
SELECT deptno AS '부서 번호', dname AS 부서명, loc AS 위치 FROM dept;

-- emp 테이블에서 1985년이후에 입사한 직원 조회
SELECT * FROM emp WHERE hiredate>='1985-01-01';

-- student 테이블에서 1976년생 학생 조회
SELECT * FROM student WHERE birthday >= '1976-01-01' AND birthday < '1977-01-01';
-- between A and B
SELECT * FROM student WHERE birthday BETWEEN '1976-01-01' AND '1976-12-31';

-- professor 테이블에서 급여가 500대인 교수의 정보 조회
SELECT * FROM professor WHERE pay >= 500 AND pay < 600 ORDER BY pay;
SELECT * FROM professor WHERE pay BETWEEN 500 AND 599 ORDER BY pay;

-- order by : 정렬
SELECT * FROM emp ORDER BY sal; -- 오름차순 정렬(Ascending) 기본
SELECT * FROM emp ORDER BY sal DESC; -- 내림차순 정렬(Descending)

-- emp 테이블에서 부서번호가 10인 사원들의 사번,이름,업무, 부서번호, 급여를 급여 기준 내림차순으로 조회
SELECT empno, ename, job, deptno, sal 
FROM emp 
WHERE deptno = 10 
ORDER BY sal DESC;

SELECT empno, ename, job, deptno, sal 
FROM emp 
WHERE deptno = 10 
ORDER BY 5 DESC;

-- student 테이블에서 4학년인 학생들을 생일 순으로 조회
SELECT *
FROM student
WHERE grade = 4
ORDER BY birthday;

-- student 테이블에서 학생들을 학과 번호(deptno1) 순으로 조회하되 같은 학과 학생은 학년 순으로 조회
SELECT *
FROM student
ORDER BY deptno1, grade;

-- professor 테이블에서 교수번호, 이름, 학과번호, 급여를 학과번호순으로조회
-- 단 같은 학과번호는 급여가 높은 순으로 조회
SELECT profno, NAME, deptno, pay
FROM professor
ORDER BY deptno, 
			pay DESC;
			
-- distict
SELECT distinct(deptno) FROM emp ;

-- student 테이블에서 학생들이 제2전공으로 선택한 학과 번호 조회
SELECT deptno2 FROM student WHERE deptno2 IS NOT NULL;

-- like 연산자: 컬럼의 문자열에 특정 문자열이 포함된 것을 거를 때 사용
-- student 테이블에서 이름이 '서'로 시작하는 학생조회
SELECT * FROM student WHERE NAME LIKE '서%';
SELECT * FROM student WHERE NAME LIKE '%은%';
SELECT * FROM student WHERE NAME LIKE '서_수';

-- student 테이블에서 76년생 학생들 조회
SELECT * FROM student WHERE birthday LIKE '1976%';

-- student 테이블에서 8월생 학생들 조회
SELECT * FROM student WHERE birthday LIKE '_____08%';

-- professor 테이블에서 naver 이메일을 사용하는 교수의 교수번호, 이름, 이메일 조회
SELECT profno, NAME, email FROM professor WHERE email LIKE '%naver.com';

-- 칼럼의 null 값 비교는 is null 사용
-- emp 테이블에서 최고 관리자 조회
SELECT * FROM emp WHERE mgr IS NULL;

-- is null의 반대는 is not null
-- emp 테이블에서 커미션이 있는 사원의 사번, 이름, 급여, 커미션 조회
SELECT empno, ename, sal, comm FROM emp WHERE comm IS NOT NULL and comm != 0; 

-- emp 테이블에서 사번, 이름, sal + comm 조회
SELECT empno, ename, sal+ IFNULL(comm, 0) AS salary FROM emp; -- null과 더해지는 값은 모두 null이 된다. 따라서 ifnull 사용해서 null값을 숫자로 바꾸어야 한다.

-- emp 테이블에서 커미션이 없는 사람은 10으로 곗나해서연봉을 조회
-- 조회 칼럼은 사번, 이름, 부서 번호, 급여, 커미션, 연봉(급여*12+커미션)	
SELECT empno, ename, deptno, sal, comm, sal*12+IFNULL(0, 10) AS 연봉 FROM emp;

-- professor 테이블에서 교수번호, 이름, 직급, 급여, 보너스, 총 급여(급여+보너스) 조회
SELECT profno, NAME, POSITION, pay, bonus, pay+IFNULL(bonus, 0) AS 총급여 FROM professor;

