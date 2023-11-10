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
  
  