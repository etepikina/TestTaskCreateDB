declare 
begin
  p_univer.add_email(p_student => 'Андрей', p_email => 'andro@gmail.com');
end;


declare 
begin
  p_univer.add_stud_inf( p_student => 'Роман', p_email => null, p_rec_date => to_date('17.06.2017','dd.mm.yyyy')
                       , p_teacher => 'Лузин', p_course => 'JavaScript');
end;


declare 
  v_stud_cours_inf   varchar2(512);
begin
  v_stud_cours_inf := p_univer.stud_cours_inf(p_student => 'Андрей', p_separator => ';');
  dbms_output.put_line('v_stud_cours_inf = '||v_stud_cours_inf);   
end;


declare 
begin
  p_univer.stud_cours_inf_kv(p_student => 'Андрей', p_tag => 'courses');
end;


