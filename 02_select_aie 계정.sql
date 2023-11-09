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


-------------------------------------------------------------------------------

/*
    DISTINT
    - 칼럼의 중복된 값들을 한번씩만 표시하고자 할때
    - 한번만 사용
*/

SELECT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; 

//이 두 조합이 한번만 나오게함
//EX) J1 D9 는 한번만 나옴, 하지만 각각 칼럼은 중복이로 나올수있음
SELECT DISTINCT JOB_CODE , DEPT_CODE
FROM EMPLOYEE; 


--------------------------------------------------------------------------------
/*
    WHERE
    비교연산자
    >,<,>=,<= : 대소비교
    = : 같은지 비교
    !=, ^=,<> : 같지않은지 비교
*/

SELECT * FROM EMPLOYEE WHERE DEPT_CODE <> 'D1';

SELECT EMP_NAME,DEPT_CODE,SALARY FROM EMPLOYEE WHERE SALARY >= 4000000;

SELECT * FROM EMPLOYEE WHERE ENT_YN = 'N' ;

/*연습문제*/
SELECT EMP_NAME,SALARY,HIRE_DATE,SALARY*12 연봉 FROM EMPLOYEE WHERE SALARY >= 3000000;
SELECT EMP_NAME,SALARY,SALARY*12 연봉,DEPT_CODE FROM EMPLOYEE WHERE SALARY*12 >= 50000000;
SELECT EMP_ID,EMP_NAME,JOB_CODE,ENT_YN FROM EMPLOYEE WHERE JOB_CODE != 'J3';


/*
    논리연산자
    여러개의 조건을 묶어서 제시
    
    AND,OR
    NOT : 컬렴명앞 또는 BETWEEN 앞에
*/
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;
SELECT * FROM EMPLOYEE WHERE SALARY >= 3500000 AND SALARY <= 6000000;

SELECT * FROM EMPLOYEE WHERE NOT SALARY >= 3500000 AND SALARY <= 6000000;

SELECT * FROM EMPLOYEE WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/31' ;


--------------------------------------------------------------------------------

/*
    LIKE
    비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족하는 경우 조회
    
    비교대상컬럼명 LIKE '특정패턴' 
    * 특정패턴 : % , _ (와일드카드) 사용
    
    % => 0글자 이상
    A% : A로 시작하는 문자열 검색
    %A : A로 끝나는 문자열 검색
    %A% : A를 포함한 문자열 검색
    A%O : A로 시작해서 O로 끝나는 문자 검색

    A__ : A로 시작하는 3자리 문자 검색
    _A___ : 두번째 글자가 A인 5자리 문자 검색
    ________A : A로 끝나는 9자리 문자 검색
    
    A_%_% : A로 시작하며 최소 3글자인 문자 검색
    
    * 데이터와 와일드카드 구분지어야됨(__% => X)
*/

SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '전%';

SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%하%';
//'하'를 포함하는 값 출력

SELECT * 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '_하_';
//무조건 이름 가운데 '하'가 들어간 값 출력

SELECT * 
FROM EMPLOYEE 
WHERE PHONE LIKE '__1________';
//PHONE에 세번째 숫자가 '1'인 값;

SELECT * 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___@%';
//'@' 앞 글자가 3글자인 값 출력

// 데이터값으로 취금하고자하는 값 앞에 나만의 와일드 카드(문자,숫자,특수문자 등) 제시
// EX) LIKE '__나만의와일드카드_%' ESCAPE '나만의와일드카드'
SELECT * 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

SELECT * 
FROM EMPLOYEE 
WHERE EMAIL NOT LIKE '___D_%' ESCAPE 'D';

/*문제*/
SELECT EMP_ID,EMP_NAME,HIRE_DATE 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%연';

SELECT EMP_NAME,PHONE 
FROM EMPLOYEE 
WHERE PHONE NOT LIKE '010%';

SELECT EMP_NAME,SALARY 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2500000;

SELECT * FROM DEPARTMENT;

SELECT * 
FROM DEPARTMENT WHERE DEPT_TITLE LIKE '해외영업%'; // 또는 LIKE '해외영업%부';


--------------------------------------------------------------------------------

/*
    IS NULL / IS NOT NULL
    => NULL 체크
*/

SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NULL; // BONUS = NULL => 안됨

SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NOT NULL;

SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NOT NULL AND DEPT_CODE IS NULL;


--------------------------------------------------------------------------------

/*
    IN/ NOT IN
    IN : 컬럼값이 내가 제시한 목록 중에 일치하는 값이 있는지
    
    비교대상칼럼 IN ('값1','값2','값3'...)
*/

SELECT * 
FROM EMPLOYEE 
WHERE DEPT_CODE IN ('D5','D6','D8');


--------------------------------------------------------------------------------

/*
    연산자 우선순위
    1. ()
    2. 산술연산자
    3. 연결연산자
    4. 비교 연산자
    5. IS NULL / LIKE / IN
    6. BETWEEN AND
    7. NOT (논리연산자)
    8. AND (논리연산자)
    9. OR (논리연산자)
*/

SELECT * 
FROM EMPLOYEE 
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000;
//AND 먹고 OR  먹음

SELECT * 
FROM EMPLOYEE 
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2' )AND SALARY >= 2000000;
// () 먼저 먹음



//실습문제
SELECT * 
FROM EMPLOYEE 
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

SELECT * 
FROM EMPLOYEE 
WHERE SALARY*12 > 30000000 AND BONUS IS NULL;

SELECT * 
FROM EMPLOYEE 
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

SELECT * 
FROM EMPLOYEE 
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE > '01/01/01' AND BONUS IS NULL;
--WHERE SALARY >= 2000000 AND SALARY <= 5000000 AND HIRE_DATE > '01/01/01' AND BONUS IS NULL;

SELECT EMP_ID,EMP_NAME,SALARY, (SALARY + SALARY*BONUS)*12  AS 보너스포함연봉
FROM EMPLOYEE 
WHERE BONUS IS NOT NULL AND SALARY IS NOT NULL AND EMP_NAME LIKE '%하%' ;
--------------------------------------------------------------------------------

/*
    ORDER BY
    => 정렬
    
    SELECT 컬럼 FROM 테이블명 WHERE 조건식 ORDER BY 정렬기준이 되는 컬럼명,별칭 ASC or DESC NULLS FIRST, NULLS LAST
    
    NULLS FIRST : 정렬하고자하는 컬럼값에 NULL이 있는경우, 해당 데이터를 맨 앞에 배치(생략시 DESC 기본값)
*/

SELECT * 
FROM EMPLOYEE 
ORDER BY MANAGER_ID ASC ;

SELECT EMP_NAME,SALARY*12 연봉
FROM EMPLOYEE
ORDER BY  SALARY*12 DESC;