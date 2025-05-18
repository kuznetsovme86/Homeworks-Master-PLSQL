/*
�����: �������� ������� ��������.
�������� �������: API ��� ��������� ������� � ������� ��������.
*/

--�������� �������.
declare
  v_payment_action_message varchar2(200 char):= '������ ������. '; 
  c_status_payment_success_creation payment.status%type:=0;
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 1;
  v_payment_detail_data t_payment_detail_array := t_payment_detail_array( t_payment_detail(1,'���������� ���������� ����� X.')
                                                                        , t_payment_detail(2,'217.158.3.5')
                                                                        , t_payment_detail(3,'������ �� �������� �������� �� ���.')
                                                                        );     
begin
  dbms_output.put_line('v_payment_id='||v_payment_id);
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_success_creation||'.');
  dbms_output.put_line(to_char(v_current_dtime,'dd.mm.yyyy hh24'));
end;
/

--����� ������� � "��������� ������".
declare
  v_payment_action_message varchar2(200 char):= '����� ������� � "��������� ������" � ��������� �������. '; 
  c_status_payment_reset_error constant payment.status%type:=2;
  v_reason_message payment.status_change_reason%type:= '�������: ������������ �������.';
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 105;
begin
  if v_payment_id is not null then
    if v_reason_message is not null then
        dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_reset_error|| '. '||v_reason_message);
        dbms_output.put_line(to_char(v_current_dtime,'dd.mm.yyyy hh24:mi:ss'));
        dbms_output.put_line('v_payment_id='||v_payment_id);
    else dbms_output.put_line('������� �� ����� ���� ������.');
    end if;
  else dbms_output.put_line('ID ������� �� ����� ���� ������');
  end if;
end;
/

--������ �������.
declare
  v_payment_action_message varchar2(200 char):= '������ ������� � ��������� �������. '; 
  c_status_payment_cancel constant payment.status%type:=3;
  v_reason_message payment.status_change_reason%type:= '�������: ������ ������������.';
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 777;
begin
  if v_payment_id is null then dbms_output.put_line('ID ������� �� ����� ���� ������');
  elsif v_reason_message is null then dbms_output.put_line('������� �� ����� ���� ������.');
  else 
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_cancel|| '. '||v_reason_message);
  dbms_output.put_line(to_char(v_current_dtime,'day-mon-yy'));
  dbms_output.put_line('v_payment_id='||v_payment_id);
  end if;
end;
/

--�������� ���������� �������.
declare
  v_payment_action_message varchar2(200 char):= '�������� ���������� �������. '; 
  c_status_payment_success_end constant payment.status%type:=1;
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 55;
begin
  if v_payment_id is not null then
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_success_end||'.');
  dbms_output.put_line(to_char(v_current_dtime,'WW-Q-yy:hh24:mi->ss'));
  dbms_output.put_line('v_payment_id='||v_payment_id);
  else dbms_output.put_line('ID ������� �� ����� ���� ������');
  end if;
end;
/

--������ ������� ��������� ��� ���������.
declare
  v_data_payment_action_message varchar2(200 char):= '������ ������� ��������� ��� ��������� '; 
  c_payment_param_list_id_value constant varchar2(200 char):='�� ������ id_����/��������.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type := 55;
  v_payment_detail_data t_payment_detail_array := t_payment_detail_array( t_payment_detail(1,'���������� ���������� ����� X.')
                                                                        , t_payment_detail(3,'������ �� �������� ��������.')
                                                                        );
begin
  case v_payment_id
    when null then dbms_output.put_line('ID ������� �� ����� ���� ������');
  else 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id_value);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff6'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
  end case;
end;
/

--������ ������� �������.
declare
  v_data_payment_action_message varchar2(200 char):= '������ ������� ������� '; 
  c_payment_param_list_id constant varchar2(200 char):='�� ������ id_�����.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type:=56;
  v_deleted_payment_fields t_number_array := t_number_array(1,4);
begin
  case 
  when v_payment_id is not null then 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff9'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
  else dbms_output.put_line('ID ������� �� ����� ���� ������');
  end case;
end;
/
