-- 한줄 주석(ctrl + /)
/*
여러줄 주석
alt shift c
*/
-- 커서가 깜박거릴때 ctrl + enter

--나의 계정 보기
show user;

//SELECT * FROM dba_users;

--계정 만들기
-- CREATE USER 사용자명 IDENTIFIED BY 비밀번호;
--오라클 12버전부터 일반사용자는 C##을 붙여 이름 작명
CREATE USER c##user1 IDENTIFIED BY user1234;

-- 사용자 이름에 C##붙이는거 회피
ALTER SESSION SET "_oracle_script"= true;
CREATE USER user7 IDENTIFIED BY "user7";
create USER aie IDENTIFIED BY aie;

--권한 생성
--[표현법] GRANT 권한1,권한2....TO 계정명 ;
GRANT RESOURCE, CONNECT TO aie;

--삭제
--[표현법] DROP USER 사용자명 ; => 테이블이 없는상태
--[표현법] DROP USER 사용자명 CASCADE; => 테이블이 있을때 테이블까지 삭제
DROP USER c##user1;

--테이블스페이스에 얼마만큼의 영역을 할당할 것인지 부여
--[표현법] ALTER USER 사용자명 DEFAULT 권한1
ALTER USER aie DEFAULT TABLESPACE USERS quota UNLIMITED on users;

--테이블스페이스의 영역을 특정 용량만큼 할당
alter USER user7 quota 30M ON USERS;