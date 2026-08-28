-- ----------------------------------------------------------------------------------------------------------------
-- RANK() : 순위를 매김, 동급은 같은 등수로 처리, 동급이 있을 경우 다음 등수로 건너뛰기 : 1,2,3,3,5
-- DENSE_RANK() : RANK()와 같으나, 동급은 같은 등수로 처리하되 다음 등수를 건너뛰지 않는다. : 1, 2, 3, 3, 4, 5
-- ROW_NUMBER() : 동급을 반영하지 않는다. 즉, 동일한 등수는 존재하지 않고 모든 행은 다른 등수를 가진다.
-- ----------------------------------------------------------------------------------------------------------------
-- 사용법
-- RANK() OVER([PARTITION BY 그룹기준명] ORDER BY 순위 기준 칼럼 {ASC/DESC})
-- DENSE_RANK() OVER[PARTITION BY 그룹기준명] ORDER BY 순위 기준 칼럼 {ASC/DESC})
-- ROW_NUMBER() OVER[PARTITION BY 그룹기준명] ORDER BY 순위 기준 칼럼 {ASC/DESC})
-- ----------------------------------------------------------------------------------------------------------------

SELECT studno, total,
RANk() OVER(ORDER BY total DESC) RANK,
DENSE_RANK() OVER(ORDER BY total desc) DENSE_RANK,
ROW_NUMBER() OVER(ORDER BY total DESC) ROW_RANK
FROM exam_01;

SELECT 
RANK() OVER(PARTITION BY deptno ORDER BY sal DESC)RANK,
DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) DENSE_RANK,
ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) ROW_RANK
FROM emp;

-- sum(누적할 칼럼) over([partition by 그룹 기준명] order by 순위 기준 칼럼 {asc/desc})
SELECT deptno, empno, ename, sal,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ASC) total
FROM emp;

-- professor : 직급 교수들의 급여 순위(직급, 교수번호, 교수명)
SELECT POSITION, profno, NAME, pay,
RANK() OVER(partition by position ORDER BY pay DESC) 급여순위
FROM professor;

-- student, exam_01
-- 학과별, 학년별 등수 구하기: rank()
-- 학과번호, 학년, 이름, 점수, 등수)
SELECT s.deptno1, s.grade, s.`name`, e.total, 
RANK() OVER(PARTITION BY s.deptno1, s.grade ORDER BY total DESC)등수
FROM student s LEFT JOIN exam_01 e
ON(s.studno = e.studno);
