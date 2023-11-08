--테이블 칼럼의 정보 조회
/*
(') 홑따옴표 : 문자열 일 때
(") 쌍따옴표 : 컬럼명 일 때

select : 데이터 조회
>> RESULT SET : SELECT문을 통해 조회된 결과물(조회된 행들의 집합)
[표현법] SELECT 컬럼명1,컬럼명2,... OR * FROM 테이블명  

*/

SELECT * FROM EMPLOYEE;

SELECT EMP_ID,EMP_NAME FROM EMPLOYEE;

SELECT * FROM JOB;
SELECT * FROM DEPARTMENT;
SELECT DEPT_ID,DEPT_TITLE FROM DEPARTMENT;
SELECT * FROM JOB WHERE JOB_CODE = 'J1';


/*
    칼럼값을 통한 산술연산
    SELECT절 컬럼명 작성부분에 산술연산 기술 가능(이때 산술연산된 결과 조회)
*/

-- EMPLOYEE에서 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME,SALARY*12 
FROM EMPLOYEE; 

SELECT EMP_NAME , TO_CHAR(SALARY*12, 'FM999,999,999,999') AS val 
FROM EMPLOYEE; 

SELECT EMP_NAME, TO_CHAR(SALARY, 'FM999,999,999,999') AS val , BONUS , TO_CHAR(SALARY*12, 'FM999,999,999,999') AS val ,TO_CHAR((SALARY+BONUS*SALARY)*12, 'FM999,999,999,999') AS val
FROM EMPLOYEE;
//SYSDATE = 오늘날짜
SELECT EMP_NAME, HIRE_DATE,(SYSDATE-HIRE_DATE)
FROM EMPLOYEE



--------------------------------------------------------------------------------

/*\
    칼럼명에 별칭 지정
    => 산술연산시 컬럼명이 산술에 들어간 수식 그대로 컬럼명이됨
    이때 별칭을 부여하면 깔끔하게 처리
    
    [표현법] 컬럼명 별칭 / 컬럼명 AS 별침 / 컬럼명 "별칭"
    
    띄어쓰기,특수기호 포함시 반드시 "" 넣어야됨
*/

SELECT EMP_NAME 사원명, BONUS AS "★★보너스★★", HIRE_DATE 입사일 FROM EMPLOYEE;

--------------------------------------------------------------------------------


/*
    리터럴
    임의로 시정된 문자열(')
    SELECT절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반본적으로 출력
*/

SELECT EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE ;

//한줄로 나옴
SELECT EMP_NAME || SALARY || HIRE_DATE 사원정보
FROM EMPLOYEE ;

SELECT EMP_NAME || '의 월급은 '||SALARY||'원 입니다.'
FROM EMPLOYEE ;

SELECT EMP_NAME||'의 전화번호는 '||PHONE|| '이고 이메일은 ' ||EMAIL|| '입니다.'
FROM EMPLOYEE ;