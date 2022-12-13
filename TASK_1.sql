-- Задача №1
select t.dept_no  
     , count(t.emp_id) as cnt_emp
     , count(case when to_char(hire_date, 'mm.yyyy')='01.2009' then 1 end) as cnt_emp_jan
     , sum(t.salary) as sal_emp
     , sum(case when to_char(hire_date, 'mm.yyyy')='01.2009' then t.salary else 0 end)/sum(t.salary)*100 as pers_sal_jan
   from emps t
  group by t.dept_no 
  order by t.dept_no;
-- Задача №2 
with t(emp_id, dir_emp_id, dept_no, salary, hire_date) as (
   select p.emp_id, p.dir_emp_id, p.dept_no, p.salary, p.hire_date 
     from emps p
     where p.dir_emp_id = 7698 
     union all
    select e.emp_id, e.dir_emp_id, e.dept_no, e.salary, e.hire_date
      from emps e
      join t
        on e.dir_emp_id = t.emp_id
)
select t.dept_no  
     , count(t.emp_id) as cnt_emp
     , count(case when to_char(hire_date, 'mm.yyyy')='01.2009' then 1 end) as cnt_emp_jan
     , sum(t.salary) as sal_emp
     , sum(case when to_char(hire_date, 'mm.yyyy')='01.2009' then t.salary else 0 end)/sum(t.salary)*100 as pers_sal_jan
   from t
  group by t.dept_no 
  order by t.dept_no;
