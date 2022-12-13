declare 
begin
  p_univer.add_email(p_student => '������', p_email => 'andro@gmail.com');
end;


declare 
begin
  p_univer.add_stud_inf( p_student => '�����', p_email => null, p_rec_date => to_date('17.06.2017','dd.mm.yyyy')
                       , p_teacher => '�����', p_course => 'JavaScript');
end;


declare 
  v_stud_cours_inf   varchar2(512);
begin
  v_stud_cours_inf := p_univer.stud_cours_inf(p_student => '������', p_separator => ';');
  dbms_output.put_line('v_stud_cours_inf = '||v_stud_cours_inf);   
end;


declare 
begin
  p_univer.stud_cours_inf_kv(p_student => '������', p_tag => 'courses');
end;


