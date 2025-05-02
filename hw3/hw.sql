/*
�����: �������� ������� ��������.
�������� �������: API ��� ��������� ������� � ������� ��������.
*/

--�������� �������.
declare
  v_payment_action_message varchar2(300 char):= '������ ������. '; 
  c_status_payment_success_creation constant number(1):=0;
begin
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_success_creation||'.');
end;
/

--����� ������� � "��������� ������".
declare
  v_payment_action_message varchar2(300 char):= '����� ������� � "��������� ������" � ��������� �������. '; 
  c_status_payment_reset_error constant number(1):=2;
  v_reason_message varchar2(300 char):= '�������: ������������ �������.';
begin
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_reset_error|| '. '||v_reason_message);
end;
/

--������ �������.
declare
  v_payment_action_message varchar2(300 char):= '������ ������� � ��������� �������. '; 
  c_status_payment_cancel constant number(1):=3;
  v_reason_message varchar2(300 char):= '�������: ������ ������������.';
begin
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_cancel|| '. '||v_reason_message);
end;
/

--�������� ���������� �������.
declare
  v_payment_action_message varchar2(300 char):= '�������� ���������� �������. '; 
  c_status_payment_success_end constant number(1):=1;
begin
  dbms_output.put_line(v_payment_action_message||'������: '||c_status_payment_success_end||'.');
end;
/

--������ ������� ��������� ��� ���������.
declare
  v_data_payment_action_message varchar2(300 char):= '������ ������� ��������� ��� ��������� '; 
  c_payment_param_list_id_value constant varchar2(300 char):='�� ������ id_����/��������.';
begin
  dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id_value);
end;
/

--������ ������� �������.
declare
  v_data_payment_action_message varchar2(300 char):= '������ ������� ������� '; 
  c_payment_param_list_id constant varchar2(300 char):='�� ������ id_�����.';
begin
  dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id);
end;
/