/*
�����: �������� ������� ��������
�������� �������: API ��� ��������� ������� � ������� ��������
*/

--�������� ���������� � ��������� � ���� ��������� �����:
--��� ���������� ����������� ����������;
--��� ������� - ��������� ����������;
--��� ��������� - ���������.

--�������� �������
declare
  v_message varchar2(200):='������ ������. ';
  c_active constant number:= 1;
  c_not_blocked constant number:=0;
begin
  dbms_output.put_line(v_message|| '������:' || c_active || '. ����������: '||c_not_blocked);
end;
/

--���������� �������
declare
  v_message varchar2(200):='������ ������������. ';
  c_blocked constant number:= 1;
  c_reason varchar2(200):=' �������������� �������.';
begin
  dbms_output.put_line(v_message || '����������: '|| c_blocked || '. �������:' ||c_reason);
end;
/

--������������� �������
declare
  v_message varchar2(200):='������ �������������. ';
  c_not_blocked constant number:=0;
begin
  dbms_output.put_line(v_message||'����������: '||c_not_blocked);
end;
/

--���������� ������ ��������� ��� ���������
declare
  v_action varchar2(200) :='���������� ������ ��������� ��� ���������';
  c_criteria constant varchar2(200) :='  �� ������ id ����/��������.';
begin
  dbms_output.put_line(v_action||c_criteria);
end;
/

--���������� ������ �������
declare
  v_action varchar2(200) :='���������� ������ �������';
  c_criteria constant varchar2(200) :='  �� ������ id ����/��������.';
begin
  dbms_output.put_line(v_action||c_criteria);
end;
/
