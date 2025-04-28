/*
Автор: Кузнецов Дмитрий Павлович
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”
*/

--Добавьте переменные и константы в ваши анонимные блоки:
--для “сообщений” используйте переменные;
--для “причин” - отдельные переменные;
--для “статусов” - константы.

--Создание клиента
declare
  v_message varchar2(200):='Клиент создан. ';
  c_active constant number:= 1;
  c_not_blocked constant number:=0;
begin
  dbms_output.put_line(v_message|| 'Статус:' || c_active || '. Блокировка: '||c_not_blocked);
end;
/

--Блокировка клиента
declare
  v_message varchar2(200):='Клиент заблокирован. ';
  c_blocked constant number:= 1;
  c_reason varchar2(200):=' подозрительный перевод.';
begin
  dbms_output.put_line(v_message || 'Блокировка: '|| c_blocked || '. Причина:' ||c_reason);
end;
/

--Разблокировка клиента
declare
  v_message varchar2(200):='Клиент разблокирован. ';
  c_not_blocked constant number:=0;
begin
  dbms_output.put_line(v_message||'Блокировка: '||c_not_blocked);
end;
/

--Клиентские данные вставлены или обновлены
declare
  v_action varchar2(200) :='Клиентские данные вставлены или обновлены';
  c_criteria constant varchar2(200) :='  по списку id поле/значение.';
begin
  dbms_output.put_line(v_action||c_criteria);
end;
/

--Клиентские данные удалены
declare
  v_action varchar2(200) :='Клиентские данные удалены';
  c_criteria constant varchar2(200) :='  по списку id поле/значение.';
begin
  dbms_output.put_line(v_action||c_criteria);
end;
/
