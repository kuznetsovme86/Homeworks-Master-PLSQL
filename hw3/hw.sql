/*
Автор: Кузнецов Дмитрий Павлович.
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”.
*/

--Создание платежа.
declare
  v_payment_action_message varchar2(300 char):= 'Платеж создан. '; 
  c_status_payment_success_creation constant number(1):=0;
begin
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_creation||'.');
end;
/

--Сброс платежа в "ошибочный статус".
declare
  v_payment_action_message varchar2(300 char):= 'Сброс платежа в "ошибочный статус" с указанием причины. '; 
  c_status_payment_reset_error constant number(1):=2;
  v_reason_message varchar2(300 char):= 'Причина: недостаточно средств.';
begin
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_reset_error|| '. '||v_reason_message);
end;
/

--Отмена платежа.
declare
  v_payment_action_message varchar2(300 char):= 'Отмена платежа с указанием причины. '; 
  c_status_payment_cancel constant number(1):=3;
  v_reason_message varchar2(300 char):= 'Причина: ошибка пользователя.';
begin
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_cancel|| '. '||v_reason_message);
end;
/

--Успешное завершение платежа.
declare
  v_payment_action_message varchar2(300 char):= 'Успешное завершение платежа. '; 
  c_status_payment_success_end constant number(1):=1;
begin
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_end||'.');
end;
/

--Данные платежа добавлены или обновлены.
declare
  v_data_payment_action_message varchar2(300 char):= 'Данные платежа добавлены или обновлены '; 
  c_payment_param_list_id_value constant varchar2(300 char):='по списку id_поля/значение.';
begin
  dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id_value);
end;
/

--Детали платежа удалены.
declare
  v_data_payment_action_message varchar2(300 char):= 'Детали платежа удалены '; 
  c_payment_param_list_id constant varchar2(300 char):='по списку id_полей.';
begin
  dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id);
end;
/