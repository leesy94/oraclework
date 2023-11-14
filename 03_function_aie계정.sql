/*
    함수
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과 반환
    
    - 단일행 함수 : n개의 값을 읽어서 n개의 결과값 반환 (매 행마다 함수 실행)
    - 그룹 함수 : n개의 값을 읽어들여 1개의 결과값을 반환(그룹별로 함수 실행)
    
    => SELECT절에 단일행 함수와 그룹함수 함께 사용X

    => 함수식을 기술 할 수 있는 위치 : SELECT , WHERE , ORDER BY, HAVING 절
*/

--------------------------------------------------------- 단일 행 함수 ----------------------------------------------------------
/* 문자처리함수
 LENGTH / LENGTHB => NUMBER 로 반환
LENGTH(컬럼 or '문자열') : 글자수 반환
LENGTHB(컬럼 or '문자열') : byte로 반환
    - 한글 : XE버전 => 1글자당 3byte (ex. 김.ㄱ => 3byte)
                 EE버전 => 1글자당 2byte 
    - 그 외 : 1글자당 1byte
*/

SELECT LENGTH('오라클'),LENGTHB('오라클')
FROM DUAL;
//DUAL => 오라클에서 제공하는 가상 테이블

SELECT LENGTH('ORACLE') FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME) || '글자' 글자수  , LENGTHB(EMP_NAME)  || 'byte' BYTE,
EMAIL, LENGTH(EMAIL) 글자수,LENGTHB(EMAIL) BYTE
FROM  EMPLOYEE;

/*
    INSTR : 문자열로부터 특정 문자의 시작위치(INDEX)를 찾아서 반환(반환명 : NUMBER)
    
    //[] => 필요하면 추가
    INSTR(컬럼 or '문자열','찾고자하는 문자열',[찾을 위치의 시작값],[순번])
    띄어쓰기도 먹음
    
    찾을 위치의 시작값
    1 : 앞에서 부터 찾기(default)
    -1 : 뒤에서 부터 찾기
    
    값이 0 이면 없는거
*/

SELECT INSTR('자바스크립트JAVAORACLE','A') FROM DUAL;
SELECT INSTR('자바스크립트 JAVA ORACLE','A') FROM DUAL;
SELECT INSTR('자바스크립트JAVAORACLE','A',-1) FROM DUAL;
SELECT INSTR('자바스크립트JAVAORACLE','A',1,3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'@') "@위치" , INSTR(EMAIL,'_') "_위치" FROM EMPLOYEE ;

--------------------------------------------------------- ----------------------------------------------------------

/*
    SUBSTR : 문자열에서 특정 문자열을 추출하여 반환(CHARACTER)
    
    SUBSTR('문자열',POSITION,[LENGTH]) ;
    - POSITION : 문자열 추출 할 시작위치 INDEX
    - LENGTH : 추출 할 문자의 개수(생략 시 다 들고옴)
*/
SELECT SUBSTR('ORACLEJSPHTMLCSS',10,4) FROM DUAL;
SELECT SUBSTR('ORACLEJSPHTMLCSS',-7,4) FROM DUAL;

SELECT EMP_NO ,EMP_NAME,SUBSTR(EMP_NO,8,1) 성별
FROM EMPLOYEE WHERE SUBSTR(EMP_NO,8,1) = 2;

SELECT EMP_NAME,EMAIL,SUBSTR(EMAIL,1, INSTR(EMAIL,'@')) 아이디 
FROM EMPLOYEE;

/*
    LPAD / RPAD  : 문자열을 조회할 때 통일감있게 조회하고자 할 때 (CHARACTER : 반환)
    
    LPAD/RPAD ('문자열',최종적으로 반환할 문자의 길이,[덧붙이고자하는 문자])
    문자열에 덧붙이고자하는 문자를 왼쪽 혹은 오른쪽에 덧붙여서 최종 길이만큼의 문자열 반환
*/
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME,LPAD(EMAIL,20) 이메일 FROM EMPLOYEE;

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,0,8),13,'*') FROM EMPLOYEE;

SELECT EMP_NAME,SUBSTR(EMP_NO,0,8) || '******' FROM EMPLOYEE;

/*
    LTRIM / RTRIM : 문자열에서 특정 문자를 제거한 나머지 문자 반환(CHARACTER)
    TRIM : 문자열의 앞/뒤 양쪽에 있는 지정한 문자를 제거한 나머지 문자 반환
    
    LTRIM / RTRIM('문자열',[제거하고자하는 문자열])
    TRIM([LEADING or TRAILING or BOTH] 제거하고자하는 문자열 FROM '문자열')
*/

 SELECT LTRIM('     A I       E     ') FROM DUAL; //왼쪽공백제거
SELECT RTRIM('     A I       E     ') || '애드인에듀' FROM DUAL; // 오른쪽공백제거

 SELECT LTRIM('JAVAJAVA SCRIPT SPRING','JAVA') FROM DUAL;
 SELECT LTRIM('ADACABDSSDBAABAABC' ,'ABC') FROM DUAL; // 결과 : DACABDSSDBAABAABC
  SELECT LTRIM('8324234324ㅣㅑㅑㅜ342342334','012345678') FROM DUAL; // 반환할 문자가 있을때 까지 하나씩 비교하면서 반환
  
   SELECT RTRIM('ADACABDSSDBAABAABC' ,'ABC') FROM DUAL; // 결과 : ADACABDSSD // 오른쪽부터 비교
  SELECT RTRIM('8324234324ㅣㅑㅑㅜ342342334','012345678') FROM DUAL;
  
SELECT TRIM('     A I       E     ') || '애드인애듀' FROM DUAL; // 양 쪽 다 제거
 
 SELECT TRIM('A' FROM 'ADACABDSSDBAABAABCA') FROM DUAL; // 양쪽 제거 (제거 할 글자 하나만) BOTH DEFAULT
 SELECT TRIM('A' FROM 'ADACABDSSDBAABAABCA') FROM DUAL;
 
 /*
    LOWER : 소문자
    UPPER  : 대문자
    INITCAP : 첫번째 문자 대문자로
 */
 
 /*
    CONCAT : 문자열 두개를 하나로 합친 결과
    
    CONCAT('문자열','문자열')
 */
 
 SELECT CONCAT('오','라클') FROM DUAL;
 
 
 ------------------------------------------------------------------숫자 처리 함수--------------------------------------------------------------
 
 /*
    ABS : 절대값을 구하는 함수
    ABS(NUMBER)
 */
 
 SELECT ABS(-10) FROM DUAL;
 
 /*
    MOD : 나머지
 */
 
 /*
    ROUND : 반울림 
    CEIL : 올림
    FLOOR : 내림
    TRUNC : 위치 지정 가능한 버림처리 함수
    
   TRUNC  or FLOOR or ROUND(NUMBER,[위치])
 */
SELECT ROUND(1234.56) FROM DUAL;
SELECT ROUND(1234.56,1) FROM DUAL;
SELECT TRUNC(1234.56,1) FROM DUAL;
SELECT TRUNC(1234.5635,-1) FROM DUAL;

--------------------------------------------------------날짜처리함수--------------------------------------------------------------
 /*
    SYSDATE : 시스템 날짜와 시간반환
    MONTHS_BETWEEN(DATE1,DATE2) : 두 날짜 사이의 개월 수 반환
    ADD_MONTHS(DATE,NUMVER) : 특정날짜에 해당 숫자만큼의 개월수를 더해 그 날짜 반환
    LAST_DAY(DATE) : 해당월의 마지막 날짜 반환
    EXTRACT(DAY FROM DATE) : 특정 날짜로 부터 년,월,일 값을 추출하여 반환(NUMBER)
 */
 SELECT EMP_NAME, ROUND(MONTHS_BETWEEN(SYSDATE , HIRE_DATE)) 근무월 FROM EMPLOYEE;
 SELECT EMP_NAME, ADD_MONTHS(HIRE_DATE,6) "정직원된 날짜" FROM EMPLOYEE;
 
 SELECT EMP_NAME,HIRE_DATE ,EXTRACT(YEAR FROM HIRE_DATE) 입사년도, EXTRACT(MONTH FROM HIRE_DATE) 입사월, EXTRACT(DAY FROM HIRE_DATE) 입사일 FROM EMPLOYEE;
 
 -----------------------------------------------------------------형변환함수----------------------------------------------------------------------------
 /*
    TO_CHAR : 숫자 또는 날짜의 값을 문자타입으로 변환
    
    TO_CHAR(숫자 or 날짜 ,[포맷])
    //포맷 : 반환 결과를 특정 형식에 맞게 출력하도록 함
 */
 
 //숫자 -> 문자
 /*
    9:해당 자리의 숫자를 의미 
    => 값이 없을 경우 소수점 이상은 공백, 소수점 이하는 0으로 표시
    0 : 해당 자리의 숫자를 의미
    => 값이 없을 경우 0표시, 숫자의 길이를 고정적으로 표시할 때 주로 사용
    FM : 좌우 9로 치환된 소수점 이상의 공백 및 소수점 이하의 0 제거
    => 해당 자리에 값이 없을 경우 자리 차지 X
 */
  //기본적으로 숫자는 오른쪽정렬, 문자는 왼쪽정렬
 SELECT TO_CHAR(1234) FROM DUAL; //문자로 변환됨
SELECT TO_CHAR(1234,'9999999999') 자리 FROM DUAL;  // 10자리 공간 차지, 오른쪽 정렬, 빈칸공백
SELECT TO_CHAR(1234,'0000000000') 자리 FROM DUAL; // 10자리 공간 차지, 오른쪽 정렬, 빈칸은 0으로 채움 

SELECT TO_CHAR(1234, 'L99999') 자리 FROM DUAL;  -- L(LOCAL) 현재 설정된 나라의 화폐단위(빈칸공백)

SELECT TO_CHAR(123412, 'L999,999,999') 자리 FROM DUAL;

-- 사번, 이름, 급여(\1,111,111), 연봉(\123,234,234) 조회
SELECT EMP_ID, EMP_NAME, TO_CHAR(SALARY, 'L99,999,999') 급여, TO_CHAR(SALARY*12, 'L999,999,999') 연봉
FROM EMPLOYEE;


/*여기서 부터 복습하면 됨!!!*/
-- FM
SELECT TO_CHAR(123.456, 'FM99990.999'),
              TO_CHAR(1234.56, 'FM9990.99'),
              TO_CHAR(0.1000, 'FM9990.999'),
              TO_CHAR(0.1000, 'FM9990.00'),
              TO_CHAR(0.1000, 'FM9999.999')
FROM DUAL;
    
SELECT TO_CHAR(123.456, '99990.999'),
              TO_CHAR(1234.56, '9990.99'),
              TO_CHAR(0.1000, '9990.999'),
              TO_CHAR(0.1000, '9990.00'),
              TO_CHAR(0.1000, '9999.999')
    FROM DUAL;

---------------------------------------- 날짜 => 문자 --------------------------------------------
-- 시간
SELECT TO_CHAR(SYSDATE, 'AM') "한국날짜",
              TO_CHAR(SYSDATE, 'PM', 'nls_date_language=american') "미국날짜"
    FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;  -- 12시간 형식
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;

-- 날짜
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 " DD"일 " DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;

-- 사원명, 입사일(23-02-02), 입사일(2023년 2월 2일 금요일) 조회

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD') 입사일, TO_CHAR(HIRE_DATE, 'DL') 입사년월일
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD') 입사일, TO_CHAR(HIRE_DATE, 'YYYY"년 "MM"월 " DD"일 " DAY') 입사년월일
FROM EMPLOYEE;

-- 년도
SELECT TO_CHAR(SYSDATE, 'YYYY'),
             TO_CHAR(SYSDATE, 'YY'),
             TO_CHAR(SYSDATE, 'RRRR'),
             TO_CHAR(SYSDATE, 'YEAR')       -- 영문으로
  FROM DUAL; 
  
 -- 월
 SELECT TO_CHAR(SYSDATE, 'MM'),
              TO_CHAR(SYSDATE, 'MON'),
              TO_CHAR(SYSDATE, 'MONTH'),
              TO_CHAR(SYSDATE, 'RM')        -- 로마기호
    FROM DUAL;

-- 일
SELECT TO_CHAR(SYSDATE, 'DD'),      -- 월 기준으로 몇일째
              TO_CHAR(SYSDATE, 'DDD'),   -- 년 기준으로 몇일째
              TO_CHAR(SYSDATE, 'D')        -- 주 기준(일요일)으로 몇일째
FROM DUAL;

-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),
             TO_CHAR(SYSDATE, 'DY')
FROM DUAL;             
--------------------------------------------------------------------------------------------------
/*
    TO_DATE : 숫자 또는 문자 타입을 날짜타입으로 변환
    
    [표현법]
    TO_DATE(숫자|문자, [포맷])
*/
SELECT TO_DATE(20231110) FROM DUAL;
SELECT TO_DATE(231110) FROM DUAL;

-- SELECT TO_DATE(011110) FROM DUAL;  숫자 형태로 넣을때 앞이 0일때 오류
SELECT TO_DATE('011110') FROM DUAL;

SELECT TO_DATE('070407 020830', 'YYMMDD HHMISS') FROM DUAL; -- 년월일만 출력
SELECT TO_CHAR(TO_DATE('070407 020830', 'YYMMDD HHMISS'), 'YY-MM-DD HH:MI:SS') FROM DUAL;

/*
    YY : 무조건 앞에 '20'이 붙는다
    RR : 50년을 기준으로 50보다 작으면 앞에 '20' 붙이고, 50보다 크면 앞에 '19'를 붙인다
*/
SELECT TO_DATE('041110','YYMMDD'), TO_DATE('981110','YYMMDD') FROM DUAL; 
SELECT TO_DATE('041110','RRMMDD'), TO_DATE('981110','RRMMDD') FROM DUAL;  

--------------------------------------------------------------------------------------------------
/*
    TO_NUMBER : 문자 타입을 숫자 타입으로 변환
    
    TO_NUMBER(문자, [포맷])
*/
SELECT TO_NUMBER('0212341234') FROM DUAL;
SELECT '1000' + '5500' FROM DUAL;  -- 연산이 들어가면 자동으로 숫자로 형변환
SELECT TO_NUMBER('1,000', '9,999,999') + TO_NUMBER('1,000,000', '9,999,999') FROM DUAL;

--===================================================================================
--                                                            <NULL 처리 함수>
--===================================================================================

/*
    NVL(컬럼, 해당컬럼이 NULL일 경우 반환될 값)
*/
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 사원명, 보너스포함 연봉 조회
SELECT EMP_NAME, (SALARY*BONUS + SALARY) * 12
-- SELECT EMP_NAME, (SALARY*(1+BONUS)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*(1+NVL(BONUS, 0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '부서 없음')
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------
/*
    NVL2(컬럼, 반환값1, 반환값2)
    - 컬럼값이 존재할 경우 반환값1
    - 컬럼값이 NULL일때 반환값2
*/

SELECT EMP_NAME, SALARY, BONUS, SALARY*NVL2(BONUS, 0.5, 0.1) 성과급
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '부서 있음', '부서 없음') 부서여부
FROM EMPLOYEE;
--------------------------------------------------------------------------------------------------
/*
    NULLIF(비교대상1, 비교대상2)
    - 두개의 값이 일치하면 NULL반환
    - 두개의 값이 일치하지 않으면 비교대상1을 반환
*/
SELECT NULLIF('1234', '1234') FROM DUAL;
SELECT NULLIF('1234', '5678') FROM DUAL;

--===================================================================================
--                                                                               <선택 함수>
--===================================================================================
/*
    DECODE(비교하고자하는 대상(컬럼|산술연산|함수식), 비교값1, 결과값1, 비교값2, 결과값2, ...)
    
    SWITCH(비교대상) {
        CASE 비교값1:
            결과값1;
        CASE 비교값2 :
            결과값2;
        DEFAULT:  -- 오라클에서는 쓰지않으면 DEFAULT가 됨
            결과값3;
    }
*/
-- 사원명, 성별
SELECT EMP_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1','남자', '2','여자', '3','남자', '4','여자') 성별
FROM EMPLOYEE;

-- 직원의 급여를 직급별로 인상해서 조회
-- J7이면 급여의 10% 인상
-- J6 이면 급여의 15% 인상
-- J5 이면 급여의 20% 인상
-- 그외이면 급여의 5% 인상

-- 사원명, 직급코드, 기존급여, 인상된 급여
SELECT EMP_NAME, JOB_CODE, SALARY 기존급여,
              DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                                                'J6', SALARY * 1.15,
                                                'J5', SALARY * 1.2,
                                                SALARY * 1.05) "인상된 급여"
FROM EMPLOYEE;

/*\
    CASE WHEN THEN
    END
    
    CASE WHEN 조건식1 THEN 결과값1
                WHEN 조건식2 THEN 결과값2
                ...
                ELSE 결과값N
    END
*/
SELECT EMP_NAME,SALARY
                ,CASE WHEN SALARY >= 500000 THEN 'PRO'
                            WHEN SALARY >= 350000 THEN 'MIDDLE'
                            ELSE 'NEWB'
                END AS 급수
FROM EMPLOYEE;

--------------------------------------------------------- 그룹 함수 ----------------------------------------------------------
// => 단일 값만 나옴
 /*
    SUM(숫자타입의 컬럼) : 해당칼럼값들의 합계를 구해서 반환
*/
SELECT SUM(SALARY) "총 급여액" 
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE;

SELECT SUM(SALARY) "남자사원 총 급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('1','3');

SELECT TO_CHAR(SUM(SALARY),'L999,999,999') "D5사원의 총급여액"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


/*
    AVG(숫자타입컬럼) : 해당 컬럼 값들의 평균을 반환
*/
  
SELECT ROUND(AVG(SALARY),-1) "평균 급여액" 
FROM EMPLOYEE;

/*
    MIN(모든타입컬럼) : 해당 컬럼값들 중에 가장 작은 값 반환
    MAX
*/
SELECT MIN(SALARY) "급여 중 가장 적은 값"
FROM EMPLOYEE;

SELECT MIN(EMP_NAME) "오름차순 중 가장 위 이름", MIN(SALARY) "급여 중 가장 적은 값"
FROM EMPLOYEE;

/*
    COUNT(*or컬럼orDISTINCT 컬럼) : 행의 갯수 반환
    
    COUNT(*) : 조회된 결과의 모든 행의 개수 반환
    COUNT(컬럼) : NULL 제외한 행의 개수 반환
    COUNT(DISTINCT 컬럼) : 해당 컬럼값에서 중복 제거한 행의 개수
*/

SELECT COUNT(*) 
FROM EMPLOYEE;

SELECT COUNT(*) "여성사원수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT COUNT(BONUS) "보너스를 받은 사원 수"
FROM EMPLOYEE;

SELECT COUNT(DEPT_CODE) "부서배치를 받은 사원 수"
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "부서 수"
FROM EMPLOYEE;




------------------------------------------------------EXAM---------------------------------------------------------------------

//24.EMPLOYEE 테이블에서 부서 코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT SUM(SALARY +SALARY*BONUS) 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

//25.직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회]
//(전체직원수,2001년,2002년,2003년,2004년)

SELECT COUNT(*) 전체직원수
                , COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2001',1)) "2001년 입사 직원수"
                , COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2002',1)) "2002년 입사 직원수"
                , COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2003',1)) "2003년 입사 직원수"
                , COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2004',1)) "2004년 입사 직원수"
FROM EMPLOYEE;

SELECT COUNT(*) 전체직원수
                , COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2001' THEN '1' END) "2001년 입사 직원수"
                , COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2002' THEN '1' END) "2002년 입사 직원수"
                , COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2003' THEN '1' END) "2003년 입사 직원수"
                , COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2004' THEN '1' END) "2004년 입사 직원수"
FROM EMPLOYEE;

SELECT COUNT(*) 전체직원수
                , COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY') = '2001' THEN '1' END) "2001년 입사 직원수"
                , COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY') = '2002' THEN '1' END) "2002년 입사 직원수"
                , COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY')= '2003' THEN '1' END) "2003년 입사 직원수"
                , COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY') = '2004' THEN '1' END) "2004년 입사 직원수"
FROM EMPLOYEE;

SELECT COUNT(*) 전체직원수
                , COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY') , '2001' ,1))  "2001년 입사 직원수"
                , COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY') , '2002' ,1)) "2002년 입사 직원수"
                , COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY') , '2003' ,1))  "2003년 입사 직원수"
                , COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY') , '2004' ,1)) "2004년 입사 직원수"
FROM EMPLOYEE;