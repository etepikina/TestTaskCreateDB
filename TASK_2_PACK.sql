create or replace package p_univer is 
  -- добавление email для указанного студента
  procedure add_email( p_student in varchar2
                     , p_email   in varchar2 );
	-- добавлениt информации по новому студенту				  
  procedure add_stud_inf( p_student  in varchar2
                        , p_email    in varchar2 
						            , p_rec_date in date
					             	, p_teacher  in varchar2 
						            , p_course      varchar2 ); 
	-- получения списка курсов, посещаемых указанным студентом					 
  function stud_cours_inf( p_student   in varchar2
                         , p_separator in varchar2 )
     return varchar2;
	-- получения списка курсов, посещаемых указанным студентом JSON   
  procedure stud_cours_inf_kv( p_student   in varchar2
                             , p_tag       in varchar2 );
	 
  end p_univer;	  
/ 
create or replace package body p_univer is
  -- добавление email для указанного студента
  procedure add_email( p_student in varchar2
                     , p_email   in varchar2 )
  is     
    v_stud_id      number;
	  v_email_id       number;
	  v_email_stud_id  number;
  begin

    select stud_id
	    into v_stud_id
	    from students
	   where upper(student) = upper(p_student);
	 
    select nvl(max(email_id), 0) + 1
	    into v_email_id
	    from emails;	 

    insert into emails(email_id, email) 
    values (v_email_id, p_email); 

    select nvl(max(email_stud_id), 0) + 1
	    into v_email_stud_id
	    from students_emails;	
	
    insert into students_emails(email_stud_id, email_id, stud_id) 
    values (v_email_stud_id, v_email_id, v_stud_id);

    commit;	
 	
  exception
    when no_data_found then 
      dbms_output.put_line('Student not found');   
  end;
	-- добавлениt информации по новому студенту	
  procedure add_stud_inf( p_student  in varchar2
                        , p_email    in varchar2 
					             	, p_rec_date in date
						            , p_teacher  in varchar2 
					            	, p_course   in varchar2 )
  is                   
    v_stud_id        number;
	
    v_course_id      number;
    v_teacher_id     number;	
	v_stud_cours_id  number;	
	
  begin
    
    if p_student is not null then 
        select nvl(max(stud_id), 0) + 1
          into v_stud_id
          from students;
	  
        insert into students(stud_id, student) 
        values (v_stud_id, p_student);      
         
		if p_email is not null then      
           p_univer.add_email( p_student => p_student
		                     , p_email => p_email);
        end if;   
        
        if p_rec_date is not null 
          and p_teacher is not null 
          and p_course is not null then 
 
            select course_id
              into v_course_id
              from courses
		     where upper(course) = upper(p_course);			  

            select teacher_id
              into v_teacher_id
              from teachers
		     where upper(teacher) = upper(p_teacher);			
	    
          select nvl(max(stud_cours_id), 0) + 1
            into v_stud_cours_id
            from students_courses; 		   
                   
          insert into students_courses(stud_cours_id, stud_id, teacher_id, rec_date, course_id) 
          values (v_stud_cours_id, v_stud_id, v_teacher_id, p_rec_date, v_course_id);   
        end if;		  
      commit; 
	  end if;
	    
    exception
      when no_data_found then 
        dbms_output.put_line('Not found data of courses or teachers');   
  end;
	-- получения списка курсов, посещаемых указанным студентом  
  function stud_cours_inf( p_student   in varchar2
                         , p_separator in varchar2 )
  return varchar2 
  is     
    v_stud_id          number;    
    v_stud_cours_inf   varchar2(512);          
  begin
    if p_student is not null then 
      select stud_id
	      into v_stud_id
	      from students
	     where upper(student) = upper(p_student);

      select listagg(c.course , p_separator) 
        into v_stud_cours_inf
        from students_courses sc, courses c   
       where sc.course_id = c.course_id 
         and sc.stud_id = v_stud_id;       
    end if;  
      
    return v_stud_cours_inf; 
  end;  
    
	-- получения списка курсов, посещаемых указанным студентом JSON 
  procedure stud_cours_inf_kv( p_student in varchar2
                             , p_tag     in varchar2 )
  is  
    v_stud_id             number; 
    v_stud_cours_inf_kv   varchar2(512);                           
  begin
    
    if p_student is not null then 
      select stud_id
	      into v_stud_id
	      from students
	     where upper(student) = upper(p_student);

      select json_object(p_tag value json_arrayagg(c.course)) 
        into v_stud_cours_inf_kv
        from students_courses sc, courses c   
       where sc.course_id = c.course_id 
         and sc.stud_id = v_stud_id;       
    end if;   
  
    dbms_output.put_line('v_stud_cours_inf_kv = '||v_stud_cours_inf_kv);   
  end;  

end p_univer;

