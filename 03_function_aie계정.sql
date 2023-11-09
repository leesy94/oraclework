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
    
    찾을 위치의 시작값
    1 : 앞에서 부터 찾기(default)
    -1 : 뒤에서 부터 찾기
    
    값이 0 이면 없는거
*/

SELECT INSTR('자바스크립트JAVAORACLE','A') FROM DUAL;
SELECT INSTR('자바스크립트JAVAORACLE','A',-1) FROM DUAL;
SELECT INSTR('자바스크립트JAVAORACLE','A',1,3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'@') "@위치" , INSTR(EMAIL,'_') "_위치" FROM EMPLOYEE ;

