# 🗄️ KOSTA DB Practice

KOSTA(한국소프트웨어기술진흥협회) 교육 과정 및 데이터베이스(DB) 실습 레포지토리입니다. 
관계형 데이터베이스(RDBMS)의 핵심 개념을 이해하고, 실무에 쓰이는 복잡한 SQL 쿼리 작성과 데이터베이스 모델링 역량을 기르기 위해 작성된 코드들을 기록합니다.

## 🛠 Tech Stack
- **Database:** MariaDB
- **Language:** SQL
- **Design Tool:** draw.io (ERD 및 다이어그램 설계)

## 📝 Key Topics
이 레포지토리에서는 다음과 같은 데이터베이스 핵심 스킬을 다룹니다.
- **데이터베이스 모델링:** 요구사항 분석 및 ERP 시스템 ERD(Entity-Relationship Diagram) 설계
- **SQL 기초 및 심화:** `SELECT`, `DDL`, `DML`, `DCL` 구문 마스터
- **고급 데이터 조회:** 복잡한 `JOIN` 연산, 서브쿼리(Subquery), 그룹화 및 조건 처리(`CASE`)
- **분석 함수 활용:** 윈도우 함수(`RANK` 등)와 내장 함수(`FUNCTION`)를 활용한 데이터 가공
- **무결성 관리:** 데이터베이스 제약조건(`CONSTRAINT`) 설정 및 트랜잭션 실습

## 📂 Repository Structure

```text
📦 KOSTA_DB_Practice
┣ 📂 diagram_practice
┃ ┗ 📜 ERP_practice.drawio.pdf  # ERP 시스템 요구사항 분석 및 ERD 설계 다이어그램
┣ 📜 case.sql                   # CASE문을 활용한 조건 분기 및 데이터 가공 실습
┣ 📜 constraint.sql             # PK, FK, UNIQUE, NOT NULL 등 제약조건 설정 실습
┣ 📜 dcl.sql                    # 사용자 권한 부여(GRANT) 및 회수(REVOKE) 실습
┣ 📜 ddl.sql                    # 테이블 생성(CREATE), 수정(ALTER), 삭제(DROP) 실습
┣ 📜 dml.sql                    # 데이터 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 실습
┣ 📜 function.sql               # 각종 내장 함수(문자, 숫자, 날짜) 활용 실습
┣ 📜 join.sql                   # 다중 테이블 조인 (INNER JOIN, OUTER JOIN 등) 실습
┣ 📜 rank_1.sql                 # 순위 함수(RANK, DENSE_RANK, ROW_NUMBER) 실습
┣ 📜 select.sql                 # 기본 데이터 조회, 정렬 및 조건 필터링 실습
┣ 📜 subquary.sql               # 단일행, 다중행 및 스칼라 서브쿼리 실습
┣ 📜 SQL_Practice_Problem.sql   # 실무와 유사한 종합 마이그레이션/조회 실습 문제 풀이
┗ 📜 README.md
