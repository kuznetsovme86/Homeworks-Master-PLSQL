--#1
declare
  v_status number(1);
begin
  v_status := 0;
  dbms_output.put_line('Платеж создан. Статус: '||v_status);
end;
/

--#2
begin
  dbms_output.put_line('Сброс платежа в "ошибочный статус" с указанием причины. Статус: 2. Причина: недостаточно средств');
end;
/

--#3
declare
  v_msg_desc varchar2(100):='Статус: 3. Причина: ошибка пользователя';
begin
  dbms_output.put_line('Отмена платежа с указанием причины. '||v_msg_desc);
end;
/

--#4
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

--#5
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

--#6
begin
  dbms_output.put_line('Детали платежа удалены по списку id_полей');
end;
/