/*
1. JOB 테이블의 모든 정보 조회
2. JOB 테이블의 직급 이름 조회
3. DEPARTMENT 테이블의 모든 정보 조회
4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
   고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고 
   고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
*/

--1--
SELECT * FROM JOB;
--2--
SELECT JOB_NAME FROM JOB;
--3--
SELECT * FROM DEPARTMENT;
--4--
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;
--5--
SELECT HIRE_DATE,EMP_NAME,SALARY FROM EMPLOYEE;
--6--
SELECT EMP_NAME,SALARY*12 연봉, SALARY*(1+BONUS)*12 총수령액, (SALARY*(1+BONUS)*12) - (SALARY*12*0.03) 실수령액 FROM EMPLOYEE;
--7--
SELECT EMP_NAME,SALARY,HIRE_DATE,PHONE
FROM EMPLOYEE
WHERE JOB_CODE = 'J1';
--7(원래문제)--
SELECT EMP_NAME,SALARY,HIRE_DATE,PHONE
FROM EMPLOYEE E
INNER JOIN (
    SELECT * 
    FROM SAL_GRADE
    WHERE SAL_LEVEL = 'S1'
) S ON E.SALARY BETWEEN MIN_SAL AND MAX_SAL ;
--8--
SELECT EMP_NAME,SALARY,(SALARY*(1+BONUS)*12) - (SALARY*12*0.03) 실수령액,HIRE_DATE 
FROM EMPLOYEE
WHERE (SALARY*(1+BONUS)*12) - (SALARY*12*0.03) >= 50000000;
--9--
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';
--10--
SELECT EMP_NAME,DEPT_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE =  'D9' OR DEPT_CODE='D5') AND HIRE_DATE >= '02/01/01' ;
--11--
SELECT * 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--12--
SELECT EMP_NAME 
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
--13--
SELECT EMP_NAME , PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%'  ;
--14--
SELECT * 
FROM EMPLOYEE
WHERE EMAIL LIKE '____D_%' ESCAPE 'D' AND DEPT_CODE IN ('D9','D6') AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND SALARY >= 2700000