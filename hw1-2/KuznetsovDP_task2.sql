/*
�����: �������� ������� ��������
�������� �������: API ��� ��������� ������� � ������� ��������
*/

--�������� �������
declare
  v_status number(1);
begin
  v_status := 0;
  dbms_output.put_line('������ ������. ������: '||v_status);
end;
/

--����� ������� � "��������� ������"
begin
  dbms_output.put_line('����� ������� � "��������� ������" � ��������� �������. ������: 2. �������: ������������ �������');
end;
/

--������ �������
declare
  v_msg_desc varchar2(100):='������: 3. �������: ������ ������������';
begin
  dbms_output.put_line('������ ������� � ��������� �������. '||v_msg_desc);
end;
/

--�������� ���������� �������.
declare
  v_msg_desc varchar2(100):='�������� ���������� �������.';
begin
  declare
    v_status_desc varchar2(100):= '������: 1';
  begin
    dbms_output.put_line(v_msg_desc || v_status_desc);
  end;
end;
/

--������ ������� ��������� ��� ���������.
declare
  procedure print_msg is
    v_msg varchar2(200):= '������ ������� ��������� ��� ��������� �� ������ id_����/��������';   
  begin
    dbms_output.put_line(v_msg);
  end;
begin
  print_msg;
end;
/

--#������ ������� �������
begin
  dbms_output.put_line('������ ������� ������� �� ������ id_�����');
end;
/