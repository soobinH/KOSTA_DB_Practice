-- ----------------------------------------------------------------------------------------------------------------
-- constraint : 제약 조건
-- ----------------------------------------------------------------------------------------------------------------
-- not null, unique, primary key, foreign key, check
-- ----------------------------------------------------------------------------------------------------------------
CREATE TABLE temp (
	id INT PRIMARY KEY, -- 동일한 데이터를 허용하지 않는다. &null값도 허용하지 않는다.(unique & not null)
	NAME VARCHAR(20) NOT NULL -- null 넣으면 안 됨
);

INSERT INTO temp VALUES(NULL, 'jang'); -- primary key는 null일 수 없다
INSERT INTO temp VALUES(1, 'jang'); 
INSERT INTO temp VALUES(1, 'sang'); -- primary key는 중복을 허용하지 않는다.
INSERT INTO temp VALUES(2, NULL); -- name은 null을 허용하지 않는다.

-- unique
CREATE TABLE temp2(
	email VARCHAR(50) UNIQUE -- 중복값은 들어갈 수 없다. 하지만 null은 허용한다.
);

INSERT INTO temp2 VALUES(NULL);
INSERT INTO temp2 VALUES('kosta@kosta.com');
INSERT INTO temp2 VALUES('kosta@kosta.com'); -- 중복값 허용하지 않는다.

-- check
CREATE TABLE temp3 (
	NAME VARCHAR(20) NOT NULL,
	age INT DEFAULT 1 CHECK(age>0) -- 기본값 1, 값의 범위 제한
);

INSERT INTO temp3 (NAME) VALUES('hong'); -- age default 1
INSERT INTO temp3 (NAME, age) VALUES('song', -1); -- age check 제한범위 벗어남

-- foreign key : 다른테이블의 특정 칼럼에 있는 값만 삽입이가능하도록 관계를 맺는 것
--					  참조되는 테이블을 부모 테이블, 참조하는 테이블을 자식 테이블로 간주
-- 				  참조되는 테이블의 로우를 참조하는데 데이터가 있으면, 삭제나 변경이 불가능

DROP TABLE user;
DROP TABLE article;

CREATE TABLE user (
	id VARCHAR(20) PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL
);

CREATE TABLE article (
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	content VARCHAR(255),
	writer VARCHAR(20) REFERENCES user(id) -- user 테이블에 존재하는 id값만 삽입 가능. 단, null 값은 허용한다.
);

INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article(title, content, writer) VALUES('제목1', '내용1', 'hong'); -- success
INSERT INTO article(title, content, writer) VALUES('제목2', '내용2', 'song'); -- fail('song'은 user 테이블의 id가 아님)
INSERT INTO article(title,content, writer) VALUES('제목3', '내용3', NULL);

-- user : id가 'hong'인 데이터 삭제
DELETE FROM user WHERE id= 'hong'; -- fail : article에서 참조하는 데이터가 있어서 삭제 불가능
DELETE FROM article WHERE writer = 'hong';

INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article (title, content, writer) VALUES('제목1','내용1', 'hong'); -- success

-- user의 id 'hong' 을 'song'으로 변경
UPDATE user SET id='song' WHERE id = 'hong'; -- fail : article에서 참조하는 데이터가 있어서 변경 불가능
UPDATE user SET NAME = '길동이' WHERE id='hong';

DELETE from article WHERE writer = 'hong';
UPDATE user SET id = 'song' WHERE id = 'hong'; -- success: 참조하는 데이터가 없어서 변경 가능

DROP TABLE article;
-- 제약조건방식2
CREATE table article(
	num INT AUTO_INCREMENT, 
	title VARCHAR(50) NOT NULL,
	content VARCHAR(50),
	writer VARCHAR(20),
	PRIMARY KEY(num),
	FOREIGN KEY(writer) REFERENCES user(id)
);

DROP TABLE article;
-- 제약조건방식3
CREATE TABLE article(
	num INT,
	title VARCHAR(50) NOT NULL,
	content VARCHAR(50),
	writer VARCHAR(20)
);

alter table article ADD PRIMARY KEY(num); -- primary key 객체 생성
ALTER TABLE article ADD CONSTRAINT ARICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id);

ALTER TABLE article DROP PRIMARY KEY;
ALTER TABLE article DROP CONSTRAINT ARTICLE_USER_FK;

INSERT INTO article (num, title, content, writer) VALUES(1, '제목1', '내용1', 'park');

CREATE TABLE tcons(
	NO INT,					-- primary key
	NAME VARCHAR(20),		-- not null
	jumin VARCHAR(13),	-- not null, unique
	AREA INT,				-- check 1,2,3, 4
	deptno VARCHAR(6)		-- foreign key
);

-- primary key
ALTER TABLE tcons ADD PRIMARY KEY(NO);
-- not null
ALTER TABLE tcons MODIFY COLUMN NAME VARCHAR(20) NOT NULL;
-- not nul, unique
ALTER TABLE tcons MODIFY COLUMN jumin VARCHAR(13) NOT NULL;
ALTER TABLE tcons ADD CONSTRAINT tcons_jumin_uk UNIQUE(jumin);
-- check 1, 2, 3, 4
ALTER TABLE tcons ADD CONSTRAINT tcons_area_ck CHECK(AREA IN(1,2, 3, 4));
-- foreign key : dept2(dcode)
alter table tcons ADD CONSTRAINT tcons_dept2_fk FOREIGN KEY(deptno) REFERENCES dept2(dcode);  

-- 제약조건 삭제
-- primary key
ALTER TABLE tcons DROP PRIMARY KEY;
-- not null
ALTER TABLE tcons MODIFY COLUMN NAME VARCHAR(20);
-- unique
ALTER TABLE tcons DROP CONSTRAINT tcons_jumin_uk;
-- check
ALTER TABLE tcons DROP CONSTRAINT tcons_area_ck;
-- foreign key
ALTER TABLE tcons DROP CONSTRAINT tcons_dept2_fk;