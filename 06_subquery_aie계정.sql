/*
    서브쿼리(subquery)
    => 하나의 sql문 안에 포함된 또 다른 select문
    메인 sql문의 보조 역할을 하는 쿼리문
*/
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME  = '박정보');

SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >= (
SELECT AVG(SALARY) FROM EMPLOYEE
) ORDER BY DEPT_CODE;

/*
    서브쿼리 구분
    => 서브쿼리를 수행한 결과값이 몇 행, 몇 열이냐 따라 분류
    
    1. 단일행 서브쿼리 : 서브쿼리의 조회 결과값이 오로지 1개일 때
    2. 다중행 서브쿼리 :  서브쿼리의 조회 결과값이 여러행 일 때 (여러행 1열)
    3. 다중열 서브쿼리 :  서브쿼리의 조회 결과값이 여러열 일 때 (1행 여러열)
    4. 다중행 다중열 서브쿼리 :  서브쿼리의 조회 결과값이 여러행 일때 (여러행 여러열)
    
    => 서브쿼리의 종류가 무엇이냐에 따라 서브쿼리 앞에 붙는 연산자가 달라짐
*/

//단일행 SINGLE ROW
// 비교연산자 사용 가능

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY SALARY;

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY  = (SELECT MIN(SALARY) FROM EMPLOYEE);

SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '박정보');

//JOIN + SUBQUERY
SELECT E.* , DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '박정보')
AND DEPT_CODE = DEPT_ID;

SELECT E.* , DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D
ON SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '박정보')
AND DEPT_CODE = DEPT_ID;

------------------------------------------------------------------------------------------------------------------------------
// 다중행 서브쿼리 MULTI ROW
// IN 서브쿼리 : 여러개의 결과값 중 한개라도 일치하는 값이 있다면
//=> ANY 서브쿼리: 여러개의 겨로가값 중 "한개라도" 클 경우 (여러개의 결과값 중 가장 작은 값 보다 큰 경우)

SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME IN('조정연','전지연'));

SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '과장';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' AND SALARY > ANY(2200000);