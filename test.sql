--2
CREATE TABLE MEMBER (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(10) NOT NULL,
    AGE NUMBER,
    ADDRESS VARCHAR2(60) NOT NULL
)
COMMENT ON COLUMN MEMBER.ID IS '회원 id';
COMMENT ON COLUMN MEMBER.NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.AGE IS '회원 나이';
COMMENT ON COLUMN MEMBER.ADDRESS IS '회원 주소';

CREATE TABLE ORDERS (
    ORDER_NO VARCHAR2(10) PRIMARY KEY,
    ORDER_ID VARCHAR2(10) NOT NULL,
    ORDER_PRODECT VARCHAR2(20) NOT NULL,
    COUNT NUMBER NOT NULL,
    ORDER_DATE DATE,
     FOREIGN KEY(ORDER_ID) REFERENCES MEMBER(ID)
)
COMMENT ON COLUMN ORDERS.ORDER_NO IS '주문번호';
COMMENT ON COLUMN ORDERS.ORDER_ID IS '주문고객';
COMMENT ON COLUMN ORDERS.ORDER_PRODECT IS '주문제품';
COMMENT ON COLUMN ORDERS.COUNT IS '주문 수량';
COMMENT ON COLUMN ORDERS.ORDER_DATE IS '주문일자';

--3
INSERT INTO ORDERS VALUES('dragon','박문수',20,'서울시');
INSERT INTO ORDERS VALUES('sky','김유신',30,'부산시');
INSERT INTO ORDERS VALUES('blue','이순신',25,'인천시');

INSERT INTO ORDERS VALUES('o01','sky','케익',1,'2023-11-05');
INSERT INTO ORDERS VALUES('o02','blue','고로케',3,'2023-11-10');
INSERT INTO ORDERS VALUES('o03','sky','단팥빵',5,'2023-11-22');
INSERT INTO ORDERS VALUES('o04','blue','찹쌀도넛',2,'2023-11-30');
INSERT INTO ORDERS VALUES('o05','dragon','단팥빵',4,'2023-11-02');
INSERT INTO ORDERS VALUES('o06','sky','마늘바게트',2,'2023-11-10');
INSERT INTO ORDERS VALUES('o07','dragon','라이스번',7,'2023-11-25');

--4
SELECT NAME FROM MEMBER WHERE NAME LIKE '%신%' ORDER BY NAME DESC;

--5
-- ORACLE
SELECT ORDER_PRODECT,COUNT FROM MEMBER, ORDERS WHERE ORDER_ID = ID AND NAME = '김유신';
-- ANSI
SELECT ORDER_PRODECT,COUNT FROM MEMBER JOIN ORDERS ON ORDER_ID = ID WHERE NAME = '김유신';

--6
CREATE OR REPLACE VIEW great_order
AS SELECT ID,ORDER_PRODECT,COUNT,ORDER_DATE FROM MEMBER JOIN ORDERS ON ORDER_ID = ID WHERE COUNT >= 3 WITH CHECK OPTION;   

--7
ALTER TABLE ORDERS ADD RELEASE CHAR(1) DEFAULT 'Y';
ALTER TABLE ORDERS MODIFY ORDER_PRODECT VARCHAR2(50);
ALTER TABLE ORDERS RENAME COLUMN COUNT TO ORDER_NAME;