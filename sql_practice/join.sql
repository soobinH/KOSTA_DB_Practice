-- JOIN
CREATE TABLE test1 (
	A VARCHAR(10)
);

CREATE TABLE test2 (
	B VARCHAR(10)
);

INSERT INTO test1 VALUE('a1');
INSERT INTO test1 VALUE('a2');

INSERT INTO test2 VALUE('b1');
INSERT INTO test2 VALUE('b2');
INSERT INTO test2 VALUE('b3');

SELECT *
FROM test1 t1, test2 t2
ORDER BY 1, 2;


-- Ansi join(표준 조인)
SELECT *
FROM test1 JOIN test2
ORDER BY 1, 2;

-- emp 테이블에서 사원번호, 사원명, 부서명을 조회
SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d
USING(deptno); -- 두 테이블의 조인 칼럼이 같을 경우

SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d
ON(e.deptno = d.deptno); 

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.DEPTNO = d.deptno;

-- student, department : 학생의 학번, 이름, 주전공 학과 조회
SELECT s.studno, s.name, d.dname
FROM student s join department d
ON(s.deptno1 = d.deptno);

-- student, department : 학생의 학번, 이름, 주전공학과, 부전공 학과 조회
SELECT s.studno, s.name, ifnull(d.dname, '') 주전공, ifnull(d1.dname, '') 부전공
FROM student s join department d
ON(s.deptno1 = d.deptno)
left JOIN department d1 -- LEFT JOIN: 조인 조건에 해당하는 칼럼이 null인 왼쪽 테이블의 행은 무조건 조회
ON(s.deptno2 = d1.deptno);


-- LEFT JOIN: 왼쪽 테이블에서 조인 조건의 항목에 null인 행도 포함
-- student department : 학생의 학번, 이름, 부전공학과 조회
SELECT s.studno, s.name, ifnull(d.dname, '')
FROM student s LEFT JOIN department d
ON(s.deptno2 = d.deptno);

-- RIGHT JOIN: 오른쪽 테이블에서 조인 조건의 항목에 NULL인 행도 포함
SELECT s.studno, s.name, ifnull(d.dname, '')
FROM department d RIGHT JOIN student s
ON(s.deptno2 = d.deptno);

-- student, professor : 학번, 이름, 학년, 담당교수 번호, 담당 교수 이름 조회
SELECT s.studno, s.name, s.grade, s.profno, p.name
FROM student s LEFT JOIN professor p
USING(profno);

-- student, department, professor : 학번, 이름, 주전공 이름, 담당교수명 조회
SELECT s.studno, s.name, d.dname, p.name
FROM student s JOIN department d
ON(s.deptno1 = d.deptno)
JOIN professor p
USING(profno);

-- student, exam_01 : 학번, 이름, 시험 점수 조회
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e
USING(studno);

-- exam_01, hakjum : 학번, 점수, 학점 조회
SELECT e.studno, e.total, h.grade
FROM exam_01 e LEFT JOIN hakjum h
ON(e.total BETWEEN h.min_point AND h.max_point);

-- 학번, 이름, 점수, 학점 조회
SELECT s.studno, s.name, e.total, h.grade
FROM student s left JOIN exam_01 e
USING(studno)
left JOIN hakjum h
ON(e.total BETWEEN h.min_point AND h.max_point);

-- emp : 사번, 이름, 관리자 사번, 관리자 이름 조회
SELECT e.EMPNO, e.ENAME, e.MGR, m.ENAME
FROM emp e LEFT JOIN emp m
ON(e.mgr = m.EMPNO);

-- emp2 : 사번, 이름, 관리자 사번, 관리자 이름 조회
SELECT e.EMPNO, e.`NAME`, e.PEMPNO, m.`NAME`
FROM emp2 e LEFT JOIN emp2 m
ON(e.PEMPNO = m.EMPNO);

-- gogak, gift : 고객번호, 고객명, 포인트, 보유 포인트로 살 수 있는 가장 비싼 선물
SELECT g.gno, g.gname, g.`point`, gif.gname
FROM gogak g LEFT JOIN gift gif
ON(g.`point` BETWEEN gif.g_start AND gif.g_end);

-- emp2, p_grade
-- 이름, 직위, 급여, 같은 직급의 최소 급여, 같은 직급의 최대 급여 조회 
SELECT e.name, e.position, e.PAY, p.s_pay, p.e_pay
FROM emp2 e LEFT JOIN p_grade p
USING(POSITION);

-- emp2, p_grade
-- 이름,직위, 급여, 같은 직급의 최소 급여, 같은직급의 최대 급여 조회
-- 단, 본인 직급의 최대 급여보다 많이 받는 직원만 조회
SELECT e.name, e.position, e.PAY, p.s_pay, p.e_pay
FROM emp2 e LEFT JOIN p_grade p
USING(POSITION)
WHERE e.PAY > p.e_pay;

-- emp2, p_grade
-- 이름, 나이, 직급, 나이에 해당하는 예상 직급
SELECT e.`NAME`, format(datediff(CURDATE(), e.BIRTHDAY)/365,0) 나이, e.`POSITION`, p.position
FROM emp2 e LEFT JOIN p_grade p
ON( datediff(CURDATE(), e.BIRTHDAY)/365 BETWEEN p.s_age AND p.e_age)
ORDER BY 3 DESC;

-- gogak, gift
-- 노트북을 받을 수 있는 고객의 번호, 이름, 포인트 조회
SELECT g.gno, g.gname, g.point
FROM gogak g LEFT JOIN gift gif
ON(g.point >= gif.g_start)
WHERE gif.gname = '노트북';

-- student : 교수들이 담당하는 학생 수
-- 교수 번호, 학생 수
SELECT profno, COUNT(*)
FROM student
GROUP BY profno;


SELECT p.profno,p.`name`,  COUNT(s.profno)
FROM professor p LEFT JOIN student s
ON(p.profno = s.profno)
GROUP BY p.profno;

-- emp2, dept2
-- 서울지사에 근무하는 직원의 번호, 이름, 부서명 조회
SELECT e.EMPNO, e.`NAME`, d.DNAME, d.area
FROM emp2 e LEFT JOIN dept2 d
ON(e.deptno = d.DCODE)
WHERE d.AREA = '서울지사';

-- department
-- 공과대학에 해당하는 학부 조회(컴퓨터정보학부, 메카트로닉스학부)
SELECT d2.deptno, d2.dname
FROM department d1 LEFT JOIN department d2
ON(d1.deptno = d2.part)
WHERE d1.deptno = 10;

-- 공과대학에 해당하는 학과
SELECT d3.deptno, d3.dname
FROM department d1 LEFT JOIN department d2
ON(d1.deptno = d2.part)
left JOIN department d3
ON(d2.deptno = d3.part)
WHERE d1.deptno = 10;

-- 담당학생이 없는 교수의 번호, 이름 조회

SELECT p.profno, p.`name`
FROM professor p LEFT JOIN student s
USING(profno)
WHERE s.studno IS NULL;

-- student, department
-- 주전공이나 부전공이 전자공학과인 학생의 번호, 이름, 주전공, 부전공 조회
SELECT s.tel, s.`name`, d.dname, d1.dname
FROM student s LEFT JOIN department d
ON(s.deptno1 = d.deptno)
LEFT JOIN department d1
ON(s.deptno2 = d1.deptno)
WHERE s.deptno1 = 201 OR s.deptno2 = 201;

-- emp, dept2
-- 부서별, 고용형태별 인원수 : 부서이름, 고용형태, 인원수
SELECT d.DNAME,e.emp_type, COUNT(*)
FROM emp2 e LEFT JOIN dept2 d
ON(e.DEPTNO = d.dcode)
GROUP BY e.DEPTNO, e.emp_type;


-- professor, department
-- 인문사회학부에 속한 교수의 번호,이름, 학과명 조회
SELECT p.profno, p.`name`, d.dname
FROM professor p LEFT JOIN department d
ON(p.deptno = d.deptno)
WHERE d.part = 300;

-- exam_01, hakjum
-- 학점ㅁ별 인원수(학점, 인원수)
SELECT h.grade, COUNT(*)
FROM exam_01 e LEFT JOIN hakjum h
ON(e.total BETWEEN h.min_point AND h.max_point)
GROUP BY h.grade;

-- student, exam_01
-- 학년별 평균
SELECT AVG(e.total)
FROM student s LEFT JOIN exam_01 e
ON(s.studno = e.studno)
GROUP BY s.grade;

-- gogak, gift
-- '산악용 자전거' 필요 개수 : 포인트로 산악용 자전거를 살 수 있는 고객 수
SELECT COUNT(*)
FROM gogak g LEFT JOIN gift gif
ON(g.`point` >= gif.g_start)
WHERE gif.gname= '산악용자전거';

-- gogak, gift
-- 모슨 상품의 필요 갯수: 고객이 포인트로 각 선물을 살 수 있는 상품 수
SELECT gif.gname, COUNT(*)
FROM gogak g LEFT JOIN gift gif
ON(g.`point`>= gif.g_start)
GROUP BY gif.gname;

-- student, department
-- 공과대학 학생 수
SELECT COUNT(*)
FROM student s LEFT JOIN department d
ON(s.deptno1 = d.deptno)
LEFT JOIN department d1
ON(d.part = d1.deptno)
LEFT JOIN department d2
ON(d1.part = d2.deptno)
WHERE d2.dname = '공과대학';

-- 서진수 학생의정보 조회: 학번, 이름, id, 주민번호, 생일, 전화번호, 키, 몸무게, 주전공학과명,부전공학과명, 담당교수명, 
-- 성적, 학점 출력
SELECT s.studno, s.`name`, s.id, s.grade, s.jumin, s.birthday, s.tel, s.height, s.weight, d1.dname, d2.dname, p.`name` 담당교수, e.total, h.grade 
FROM student s LEFT JOIN exam_01 e
ON(s.studno = e.studno)
LEFT JOIN professor p
ON(s.profno = p.profno)
LEFT JOIN department d1
ON(s.deptno1 = d1.deptno)
LEFT JOIN department d2
ON(s.deptno2 = d2.deptno)
LEFT JOIN hakjum h
ON(e.total BETWEEN h.min_point AND h.max_point)
WHERE s.`name` = '서진수';

-- 본인의 급여가 직속 상사보다 많은 사원 조회
SELECT e.EMPNO, e.name, e.pay, m.empno, m.name, m.pay
FROM emp2 e LEFT JOIN emp2 m
ON(m.PEMPNO = m.EMPNO)
WHERE e.pay>m.pay;

-- 사원이 한 명도 배정되지 않은 부서 번호, 부서 명 조회
SELECT d.deptno, d.DNAME
FROM dept d LEFT JOIN emp e
ON(d.deptno = e.DEPTNO)
WHERE e.DEPTNO IS NULL;

