/*
    TCL : TRANSACTION CONTROL LANGUAGE
    트랜잭션 제어
    
    * 트랜잭션
    - DB의 논리적 연산단위
    - 데이터의 변경사항(DML) 들을 하나의 트랜잭션에 묶어서 처리
        DML문 한개를 수행할 때 트랜잭션이 존재하면 -> 해당 트랜잭션에 같이 묶어서 처리
        트랜잭션 존재하지 않으면 -> 트랜잭션을 만들어서 묶음
        COMMIT하기 전까지의 변경사항들을 하나의 트랜잭션에 담음
    - 트랜잭션의 대상이 되는 SQL : INSET,UPDATE,DELETE
    
    COMMIT : 트랜잭션 종료 처리 후 확성
    ROLLBACK : 트랜잭션 취소
    SAVEPOINT : 임시저장
    
    - COMMIT : 한 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영시킴
    - ROLLBACK : 한 트랜잭션에 담겨있는 변경사항들을 삭제(취소)한 후 마지막 COMMIT시점으로 돌아감
    - SAVEPOINT 포인트명 : 현재 이 시점에 해당 포인트명으로 임시저장 점을 정의해두는 것
                                                => ROLLBACK 진행시 전체 변경 사항들을 다 삭제X 일부만 롤백가능
*/

SELECT * FROM EMP_01;

DELETE FROM EMP_01 WHERE EMP_ID = 301;

INSERT INTO EMP_01 VALUES('300', '홍길동','');
DELETE FROM EMP_01 WHERE EMP_ID = 300;

ROLLBACK;

DELETE FROM EMP_01 WHERE EMP_ID = 200;
INSERT INTO EMP_01 VALUES('500','얍얍얍','총무부');
SELECT * FROM EMP_01;

COMMIT;

SELECT * FROM EMP_01;

DELETE FROM EMP_01 WHERE EMP_ID IN(216,217,214); 

SAVEPOINT sp;

SELECT * FROM EMP_01;

INSERT INTO EMP_01 VALUES(501,'안녕','');
DELETE FROM EMP_01 WHERE EMP_ID = 218;

SELECT * FROM EMP_01 ORDER BY 1;

ROLLBACK TO sp;

SELECT * FROM EMP_01 ORDER BY 1;

/*
    자동 COMMIT되는 경우
    - 정상 종료
    - DCL과 DDL 명령문이 수행된 경우
    
    자동 ROLLBACK되는 경우
    -비정상 종료
    -전원꺼짐,정전,컴퓨터  DOWN등
*/

DELETE FROM EMP_01 WHERE EMP_ID IN(300,500,302);

CREATE TABLE TEST(
    T_ID NUMBER
);

ROLLBACK;

SELECT * FROM TEST;