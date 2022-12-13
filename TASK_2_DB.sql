create table students(
    stud_id     number        primary key  -- Ид студента
  , student     varchar2 (80) not null     -- Имя студента
  , constraint stud_uk unique (student)    
);

create table emails(
    email_id    number        primary key  -- Ид email
  , email       varchar2 (80) not null     -- email
  , constraint email_uk unique (email)    
);

create table students_emails(
    email_stud_id  number     primary key  -- Ид 
  , email_id       number     not null references emails   -- Ид email 
  , stud_id        number     not null references students -- Ид студента 
);

create table courses(
    course_id   number        primary key  -- Ид курса
  , course      varchar2 (80) not null     -- email
  , constraint course_uk unique (course) 
);

create table teachers(
    teacher_id   number        primary key  -- Ид учителя
  , teacher      varchar2 (80) not null     -- учитель
  , constraint teacher_uk unique (teacher)   
);

create table students_courses(
    stud_cours_id  number      primary key
  , stud_id        number      not null references students -- Ид студента 
  , teacher_id     number      not null references teachers -- Ид учителя  
  , rec_date       date        not null  -- Ид email
  , course_id      number      not null references courses -- Ид курса
  , constraint stud_cours_uk unique (stud_id, course_id, teacher_id)       
);

--  truncate table ;
-- Вставка данных в таблицу
insert into students(stud_id, student) 
 values (1, 'Андрей');
insert into students(stud_id, student) 
 values (2, 'Михаил');
 insert into students(stud_id, student) 
 values (3, 'Илья');
 
insert into emails(email_id, email) 
 values (1, 'michal@gmail.com');
insert into emails(email_id, email) 
 values (2, 'michal@mail.ru');

insert into students_emails(email_stud_id, email_id, stud_id) 
 values (1, 1, 2);
insert into students_emails(email_stud_id, email_id, stud_id) 
 values (2, 2, 2);
 
insert into courses(course_id, course) 
 values (1, 'математика'); 
insert into courses(course_id, course) 
 values (2, 'алгоритмы'); 
insert into courses(course_id, course) 
 values (3, 'JavaScript'); 
 
insert into teachers(teacher_id, teacher) 
 values (1, 'Иванов');
insert into teachers(teacher_id, teacher) 
 values (2, 'Лузин');

insert into students_courses(stud_cours_id, stud_id, teacher_id, rec_date, course_id) 
 values (1, 1, 1, to_date('11/06/2017','dd/mm/yyyy'), 1); 
insert into students_courses(stud_cours_id, stud_id, teacher_id, rec_date, course_id) 
 values (2, 2, 2, to_date('12/06/2017','dd/mm/yyyy'), 2);  
insert into students_courses(stud_cours_id, stud_id, teacher_id, rec_date, course_id) 
 values (3, 3, 1, to_date('13/06/2017','dd/mm/yyyy'), 1);  
insert into students_courses(stud_cours_id, stud_id, teacher_id, rec_date, course_id) 
 values (4, 1, 2, to_date('14/06/2017','dd/mm/yyyy'), 3);   
commit; 
