/*
Автор: Кузнецов Дмитрий Павлович.
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”.
*/

--Создание платежа.
declare
  v_payment_action_message varchar2(200 char):= 'Платеж создан. '; 
  c_status_payment_success_creation payment.status%type:=0;
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 1;
begin
  dbms_output.put_line('v_payment_id='||v_payment_id);
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_creation||'.');
  dbms_output.put_line(to_char(v_current_dtime,'dd.mm.yyyy hh24'));
end;
/

--Сброс платежа в "ошибочный статус".
declare
  v_payment_action_message varchar2(200 char):= 'Сброс платежа в "ошибочный статус" с указанием причины. '; 
  c_status_payment_reset_error constant payment.status%type:=2;
  v_reason_message payment.status_change_reason%type:= 'Причина: недостаточно средств.';
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 105;
begin
  if v_payment_id is not null then
    if v_reason_message is not null then
        dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_reset_error|| '. '||v_reason_message);
        dbms_output.put_line(to_char(v_current_dtime,'dd.mm.yyyy hh24:mi:ss'));
        dbms_output.put_line('v_payment_id='||v_payment_id);
    else dbms_output.put_line('Причина не может быть пустой.');
    end if;
  else dbms_output.put_line('ID объекта не может быть пустым');
  end if;
end;
/

--Отмена платежа.
declare
  v_payment_action_message varchar2(200 char):= 'Отмена платежа с указанием причины. '; 
  c_status_payment_cancel constant payment.status%type:=3;
  v_reason_message payment.status_change_reason%type:= 'Причина: ошибка пользователя.';
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 777;
begin
  if v_payment_id is null then dbms_output.put_line('ID объекта не может быть пустым');
  elsif v_reason_message is null then dbms_output.put_line('Причина не может быть пустой.');
  else 
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_cancel|| '. '||v_reason_message);
  dbms_output.put_line(to_char(v_current_dtime,'day-mon-yy'));
  dbms_output.put_line('v_payment_id='||v_payment_id);
  end if;
end;
/

--Успешное завершение платежа.
declare
  v_payment_action_message varchar2(200 char):= 'Успешное завершение платежа. '; 
  c_status_payment_success_end constant payment.status%type:=1;
  v_current_dtime date:= sysdate;
  v_payment_id  payment.payment_id%type := 55;
begin
  if v_payment_id is not null then
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_end||'.');
  dbms_output.put_line(to_char(v_current_dtime,'WW-Q-yy:hh24:mi->ss'));
  dbms_output.put_line('v_payment_id='||v_payment_id);
  else dbms_output.put_line('ID объекта не может быть пустым');
  end if;
end;
/

--Данные платежа добавлены или обновлены.
declare
  v_data_payment_action_message varchar2(200 char):= 'Данные платежа добавлены или обновлены '; 
  c_payment_param_list_id_value constant varchar2(200 char):='по списку id_поля/значение.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type := 55;
begin
  case v_payment_id
    when null then dbms_output.put_line('ID объекта не может быть пустым');
  else 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id_value);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff6'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
  end case;
end;
/

--Детали платежа удалены.
declare
  v_data_payment_action_message varchar2(200 char):= 'Детали платежа удалены '; 
  c_payment_param_list_id constant varchar2(200 char):='по списку id_полей.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type;
begin
  case 
  when v_payment_id is not null then 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff9'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
  else dbms_output.put_line('ID объекта не может быть пустым');
  end case;
end;
/