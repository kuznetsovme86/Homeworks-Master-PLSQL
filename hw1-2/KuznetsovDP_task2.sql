/*
Автор: Кузнецов Дмитрий Павлович
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”
*/

--Создание клиента
declare
  v_status number(1);
begin
  v_status := 0;
  dbms_output.put_line('Платеж создан. Статус: '||v_status);
end;
/

--Сброс платежа в "ошибочный статус"
begin
  dbms_output.put_line('Сброс платежа в "ошибочный статус" с указанием причины. Статус: 2. Причина: недостаточно средств');
end;
/

--Отмена платежа
declare
  v_msg_desc varchar2(100):='Статус: 3. Причина: ошибка пользователя';
begin
  dbms_output.put_line('Отмена платежа с указанием причины. '||v_msg_desc);
end;
/

--Успешное завершение платежа.
declare
  v_msg_desc varchar2(100):='Успешное завершение платежа.';
begin
  declare
    v_status_desc varchar2(100):= 'Статус: 1';
  begin
    dbms_output.put_line(v_msg_desc || v_status_desc);
  end;
end;
/

--Данные платежа добавлены или обновлены.
declare
  procedure print_msg is
    v_msg varchar2(200):= 'Данные платежа добавлены или обновлены по списку id_поля/значение';   
  begin
    dbms_output.put_line(v_msg);
  end;
begin
  print_msg;
end;
/

--#Детали платежа удалены
begin
  dbms_output.put_line('Детали платежа удалены по списку id_полей');
end;
/