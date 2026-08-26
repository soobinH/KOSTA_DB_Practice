-- sub quary

-- select column1, column2...
-- from table
-- where 조건연산자 (select ... from ... where 조건);
-- 조건연산자 : 단일행 연산자 : =, <>(!=), >, <, >=, <=
--					 다중행 연산자 : in, not in, exists, >any, <any, >all, <all

-- student, exam_01, hakjum
-- 학점이 A0인 학생의 학번, 이름, 점수 조회
SELECT s.studno, s.`name`, e.total, h.grade
FROM student s LEFT JOIN exam_01 e
ON(s.studno = e.studno)
LEFT JOIN hakjum h
ON(e.total BETWEEN h.min_point AND h.max_point)
WHERE h.grade = 'A0';


-- 이윤나와 같은 학과 학생의학번, 이름, 학년 조회
SELECT studno, NAME, grade
FROM student
WHERE deptno1 = (SELECT deptno1 FROM student WHERE NAME = '이윤나');

-- emp
-- clark보다 급여를 많이 받는 사원의 사번, 이름, 급여 조회
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename = 'CLARK');

SELECT e1.empno, e1.ename, e1.sal
from emp e1 LEFT JOIN emp e2
ON(e1.SAL > e2.sal)
WHERE e2.ENAME = 'CLARK';

-- emp
-- ward보다 커미션이 작은 사원의 이름과 커미션 조회
SELECT ename, comm
FROM emp
WHERE IFNULL(comm, 0) < (SELECT IFNULL(comm,0) FROM emp WHERE ename = 'WARD');

-- professo, department
-- 박원범ㄱ ㅛ수보다 나중에 입사한 교수의 이름, 입사일, 학과명 조회
SELECT p.`name`, p.hiredate, p.deptno, d.dname
FROM professor p JOIN department d
ON(p.deptno = d.deptno)
WHERE p.hiredate > (SELECT hiredate FROM professor WHERE NAME = '박원범');

-- 컴퓨터공학과 학생들의 평균 몸무게보다 많이 나가는 학생들의학번, 이름, 학과, 몸무게 조회
SELECT s1.studno, s1.name, d1.dname, s1.weight
FROM student s1 LEFT JOIN department d1
ON(s1.deptno1 = d1.deptno)
WHERE s1.weight > (SELECT AVG(s2.weight) FROM student s2 LEFT JOIN department d2 ON(s2.deptno1 = d2.deptno) WHERE d2.dname = '컴퓨터공학과')
ORDER BY 4;

-- gogak, gift
-- 노트북을받을 수 있는 고객의 번호, 이름, 포인트 조회
SELECT gno, gname, point
FROM gogak
WHERE point > (SELECT g_start FROM gift WHERE gname = '노트북');

-- gogak, gift
-- 이윤나 고객이 받을 수 있는 선물 목록
SELECT gname
FROM gift
WHERE g_start<(SELECT point FROM gogak WHERE gname = '이윤나');

-- emp
-- BLAKE가 관리하는사원의 사번, 이름, 담당업무 조회
SELECT empno, ename, job
FROM emp
WHERE MGR = (SELECT empno FROM emp WHERE ename = 'BLAKE'); 

-- emp, dept
-- new york에서 근무하는 직원 목록 조회
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'NEW YORK');

-- student, exam_01, hakjum
-- 학점이 B0 미만인 학생의 학번, 이름, 점수 조회
SELECT s.studno, s.`name`, e.total
FROM student s LEFT JOIN exam_01 e
USING(studno)
WHERE e.total < (SELECT min_point FROM hakjum WHERE grade = 'B0');

-- emp2
-- '최일도'와같은직급인 사람들의 평균 급여보다 많이 받는 사람들의 사번, 이름, 직급, 급여조회
SELECT empno, NAME, POSITION, pay
FROM emp2
WHERE pay > (SELECT AVG(pay) 
				FROM emp2 
				WHERE POSITION = (SELECT POSITION FROM emp2 WHERE NAME = '최일도'));
				
-- '박승곤 교수가 담당하는 학생들의 학번, 이름, 학년 조회
SELECT studno, NAME, grade
FROM student
WHERE profno = (SELECT profno FROM professor WHERE NAME = '박승곤');

-- department
-- 컴퓨터 정보학부에 속하는 학과 목록 조회(학과 번호, 학과명)
SELECT deptno, dname

FROM department
WHERE part = (SELECT deptno FROM department WHERE dname = '컴퓨터정보학부');

-- '공과대학'에 속하는 학과목록 조회
SELECT deptno, dname
FROM department
WHERE part in(SELECT deptno FROM department WHERE part in(SELECT deptno FROM department WHERE dname = '공과대학'));

-- emp2, dept2
-- '포항본사'에서 근무하는 직원의 사번, 이름, 부서번호, 부서명 조회
SELECT e.empno, e.NAME, e.deptno, d.DNAME, d.AREA
FROM emp2 e LEFT JOIN dept2 d
ON(e.DEPTNO = d.DCODE)
WHERE e.deptno in(SELECT dcode FROM dept2 WHERE AREA='포항본사');

-- emp2
-- '과장'직급의 최소 연봉자보다 연봉이 높은 직원의사번, 이름, 연봉, 직급 조회
SELECT e.EMPNO, e.`NAME`, e.PAY, e.`POSITION`
FROM emp2 e
WHERE e.PAY > (SELECT MIN(pay) FROM emp2 WHERE POSITION = '과장');

-- student
-- 각 학년별 키가 가장 큰 학생의 이름과 학년, 키 조회
SELECT grade, NAME, height
FROM student
WHERE (grade, height) IN (SELECT grade, MAX(height) FROM student GROUP BY grade)
ORDER BY 2;

-- professor
-- 직급별, 학과별 급여가 가장 많은 교수의 번호, 이름, 직급, 학과, 급여 조회
SELECT p.profno, p.name, p.`position`, d.dname, p.pay
FROM professor p LEFT JOIN department d
USING(deptno)
WHERE (POSITION, deptno, pay) IN (SELECT POSITION, deptno, MAX(pay) FROM professor GROUP BY POSITION, deptno);

-- student 
-- 2학년 학생들중 몸무게가 가장 적게 나가는 학생보다 더 적게 나가는 학생의 이름, 학년, 몸무게 조회
SELECT NAME, grade, weight
from student
WHERE weight < (SELECT MIN(weight) FROM student WHERE grade=2);

-- student 
-- 3학년 학생들 중 키가 가장 큰 학생보다작은 학생의 이름, 학년, 키 조회
SELECT NAME, grade, height
FROM student
WHERE height < (SELECT MAX(height) FROM student WHERE grade=3)
ORDER BY 3;

-- emp
-- job이 zlerk인 직원을 모두보다 급여가 큰 직원의 사번, 이름, 급여 조회
SELECT empno, ename, sal
FROM emp
WHERE sal >ALL (SELECT MAX(sal) FROM emp WHERE job = 'CLERK');

-- student, exam_01, department
-- 같은 학과같은 학년 학생의평균 점수보다 점수가 높은 학생의 학번, 이름, 학과, 학년, 점수 조회
SELECT s.studno, s.`name`, s.deptno1, s.grade, e.total, d.dname
FROM student s LEFT JOIN exam_01 e
ON(s.studno = e.studno)
LEFT JOIN department d
ON(s.deptno1 = d.deptno)
WHERE e.total>(SELECT AVG(e1.total) 
					FROM student s1 LEFT JOIN exam_01 e1 
					ON(s1.studno = e1.studno) 
					WHERE s1.deptno1 = s.deptno1 AND s1.grade = s.grade)
ORDER BY 3;

-- student, professor
-- 담당 학생이 있는 교수들의 교수 번호, 교수명 조회
SELECT p.profno, p.`name`
FROM professor p
WHERE EXISTS(SELECT * FROM student WHERE profno = p.profno);

-- emp2
-- 직원들 중 자신의 직급의평균 연봉과 같거나 많이 받는 사람들의 이름, 직급, 연봉 조회
SELECT NAME, POSITION, pay
FROM emp2 e
WHERE pay >= (SELECT AVG(pay) FROM emp2 WHERE e.`POSITION` = POSITION);

-- student, department 
-- 전자제어관 건물에있는 학과 소속인 학생의 학번, 이름, 학과 조회
SELECT s.studno, s.`name`, d.dname
FROM student s LEFT JOIN department d
ON(s.deptno1 = d.deptno)
WHERE d.build = '전자제어관';

-- emp2, p_grade
-- 이름, 직위, 급여, 같은 직급의 최소급여, 최대급여 조회
SELECT e.name, e.position, e.PAY, p.s_pay, p.e_pay
FROM emp2 e LEFT JOIN p_grade p
ON(e.`POSITION` = p.`position`)
WHERE pay > p.s_pay;

-- emp2
-- 이름, 직위, 급여, 같은 직급의 최소 급여, 최대 급여 조회
SELECT e1.EMPNO, e1.pay, e1.`POSITION`, MIN(e2.PAY),MAX(e2.pay)
FROM emp2 e1 LEFT JOIN emp2 e2 
ON(e1.`POSITION` = e2.`POSITION`)
GROUP BY e1.empno 
ORDER BY 1;


-- emp
-- 사번, 이름,입사일, 자신보다 먼저 입사한 사람의 인원수 조회
SELECT e1.EMPNO, e1.ename, e1.HIREDATE, COUNT(*)
FROM emp e1 JOIN emp e2
ON(e1.HIREDATE>e2.HIREDATE)
GROUP BY empno
ORDER BY 3;
-- 위 결과는제일먼저 입사한 스미스가 포함되지 않음
-- 그래서 left join으로 smith까지 포함시키고 count(e2.HIREDATE)으로 먼저 입사한 인원을 0으로 처리함

SELECT e1.EMPNO, e1.ename, e1.HIREDATE, COUNT(e2.hiredate)
FROM emp e1 LEFT JOIN emp e2
ON(e1.HIREDATE>e2.HIREDATE)
GROUP BY empno
ORDER BY 3;

-- limit
SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5 OFFSET 0; -- 첫 번째 인덱스가 0임 원래는 무조건 1부터 시작함(첫 번째 0부터 5개)

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 0, 5; -- 첫 번째 인덱스가 0임 원래는 무조건 1부터 시작함(첫 번째 0부터 5개)

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5, 5; -- 다섯 번째부터 5개







