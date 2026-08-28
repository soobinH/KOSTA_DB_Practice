-- 문제 1번

SELECT p.PDNAME 제품카테고리, p.PDSUBNAME 제품명, f.FACNAME 공장명, st.STONAME 판매점명, s.STAMOUNT 재고
FROM product p LEFT JOIN stock s
USING(pdno)
LEFT JOIN factory f
ON(p.FACTNO = f.FACTNO)
LEFT JOIN store st
ON(s.STONO = st.STONO)
WHERE p.FACTNO = (SELECT factno FROM factory WHERE facloc = 'SEOUL') 
AND s.STAMOUNT = 0;


-- 문제 2번
SELECT p.PDSUBNAME 제품명, p.PDCOST 제품원가, p.PDPRICE 제품가격
FROM product p
WHERE p.PDCOST >ANY (SELECT pdcost FROM product WHERE pdname = 'tv')
AND p.PDCOST <ANY (SELECT pdcost FROM product WHERE pdname = 'cellphone')
ORDER BY 3 DESC;

-- 문제 3번
CREATE TABLE DISCARDED_PRODUCT (
	PDNO INT PRIMARY KEY,
	PDNAME VARCHAR(10),
	PDSUBNAME VARCHAR(10),
	FACTNO VARCHAR(5) REFERENCES factory(FACTNO),
	PDDATE DATE,
	PDCOST INT,
	PDPRICE INT,
	PDAMOUNT INT,
	DISCARDED_DATE DATE
);


-- 문제 4번
INSERT INTO discarded_product(pdno, pdname, pdsubname, factno, pddate, pdcost, PDPRICE, pdamount)
SELECT * FROM product WHERE factno = 98712;

UPDATE discarded_product SET DISCARDED_DATE = CURTIME();


START TRANSACTION;
DELETE FROM product WHERE factno = 98712;
ROLLBACK;

