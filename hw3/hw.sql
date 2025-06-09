/*
Автор: Кузнецов Дмитрий Павлович.
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”.
*/

/*Создание платежа.*/
create or replace function create_payment( p_payment_from_client_id   payment.from_client_id%type
                                         , p_payment_to_client_id     payment.to_client_id%type
                                         , p_payment_sum              payment.summa%type
                                         , p_currency_id              payment.currency_id%type
                                         , p_payment_date             payment.create_dtime%type
                                         , p_payment_detail_data      t_payment_detail_array
                                         )
return payment.payment_id%type
is
  c_payment_create_discription  constant varchar2(200 char) := 'Платеж создан';
  с_payment_create_status       constant payment.status%type := 0;
  v_payment_id                  payment.payment_id%type;
begin
 if p_payment_detail_data is not empty then
    for i in p_payment_detail_data.first .. p_payment_detail_data.last loop
      if p_payment_detail_data(i).field_id is null then
        dbms_output.put_line('ID поля не может быть пустым.');
      end if;

      if p_payment_detail_data(i).field_value is null then
        dbms_output.put_line('Значение в поле не может быть пустым.');
      end if;

    end loop;
  else
    dbms_output.put_line('Коллекция не содержит данных.');
  end if;

  insert into payment
    (payment_id, create_dtime, summa, currency_id, from_client_id, to_client_id, status)
  values
    (payment_seq.nextval, p_payment_date, p_payment_sum, p_currency_id, p_payment_from_client_id, p_payment_to_client_id, с_payment_create_status)
  returning payment_id into v_payment_id;

  insert into payment_detail
    (payment_id, field_id, field_value)
  select v_payment_id, value(t).field_id, value(t).field_value
  from table(p_payment_detail_data) t;

  dbms_output.put_line(c_payment_create_discription||'. Статус: '||с_payment_create_status||'. Payment_id: '||v_payment_id||'.');
  dbms_output.put_line(to_char(p_payment_date,'dd.mm.yyyy hh24:mi:ss'));

  return v_payment_id;

end create_payment;
/

/*Сброс платежа в "ошибочный статус".*/
create or replace procedure fail_payment( p_payment_id            payment.payment_id%type
                                        , p_payment_error_reason  payment.status_change_reason%type
                                        )
is
  c_payment_error_discription   constant varchar2(200 char) := 'Сброс платежа в "ошибочный статус" с указанием причины.';
  с_payment_create_status       constant payment.status%type := 0;
  с_payment_error_status        constant payment.status%type := 2;
  v_current_dtime               date := sysdate;
begin
  if p_payment_id is null then
    dbms_output.put_line('ID объекта не может быть пустым.');
  end if;

  if p_payment_error_reason is null then
    dbms_output.put_line('Причина не может быть пустой.');
  end if;

  update payment p
  set p.status = с_payment_error_status, p.status_change_reason = p_payment_error_reason
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;
  
  if sql%rowcount = 0 then
    dbms_output.put_line('Невозможно выполнить операцию.');
  end if;
  
  dbms_output.put_line(c_payment_error_discription||' Статус: '||с_payment_error_status||'. Причина: '||p_payment_error_reason||'. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end fail_payment;
/

/*Отмена платежа.*/
create or replace procedure cancel_payment( p_payment_id              payment.payment_id%type
                                          , p_payment_cancel_reason   payment.status_change_reason%type
                                          )
is
  c_payment_cancel_discription   constant varchar2(200 char) := 'Отмена платежа с указанием причины.';
  с_payment_create_status        constant payment.status%type := 0;
  с_payment_cancel_status        constant payment.status%type := 3;
  v_current_dtime                date := sysdate;
begin
  if p_payment_id is null then
    dbms_output.put_line('ID объекта не может быть пустым.');
  end if;

  if p_payment_cancel_reason is null then
    dbms_output.put_line('Причина не может быть пустой.');
  end if;

  update payment p
  set p.status = с_payment_cancel_status, p.status_change_reason = p_payment_cancel_reason
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;

  if sql%rowcount = 0 then
     dbms_output.put_line('Невозможно выполнить операцию.');
  end if;
        
  dbms_output.put_line(c_payment_cancel_discription||' Статус: '||с_payment_cancel_status||'. Причина: '||p_payment_cancel_reason||'. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end cancel_payment;
/

/*Успешное завершение платежа.*/
create or replace procedure successful_finish_payment(p_payment_id payment.payment_id%type)
is
  c_payment_success_discription   constant varchar2(200 char) := 'Успешное завершение платежа';
  с_payment_create_status         constant payment.status%type := 0;
  c_payment_success_status        constant payment.status%type := 1;
  v_current_dtime                 timestamp := systimestamp;
begin
  if p_payment_id is null then
    dbms_output.put_line('ID объекта не может быть пустым.');
  end if;

  update payment p
  set p.status = c_payment_success_status, p.status_change_reason = c_payment_success_discription
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;
  
  if sql%rowcount = 0 then
     dbms_output.put_line('Невозможно выполнить операцию.');
  end if;
  
  dbms_output.put_line(c_payment_success_discription||'. Статус: '||c_payment_success_status||'. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end successful_finish_payment;
/

/*Данные платежа добавлены или обновлены.*/
create or replace procedure insert_or_update_payment_detail( p_payment_id              payment.payment_id%type
                                                           , p_payment_detail_data     t_payment_detail_array
                                                           )
is
  c_payment_update_discription    constant varchar2(200 char) := 'Данные платежа добавлены или обновлены.';
  v_current_dtime                 timestamp := systimestamp;
begin
  if p_payment_id is null then
    dbms_output.put_line('ID объекта не может быть пустым.');
  end if;

  if p_payment_detail_data is not empty then
    for i in p_payment_detail_data.first .. p_payment_detail_data.last loop
      if p_payment_detail_data(i).field_id is null then
        dbms_output.put_line('ID поля не может быть пустым.');
      end if;

      if p_payment_detail_data(i).field_value is null then
        dbms_output.put_line('Значение в поле не может быть пустым.');
      end if;
    end loop;
  else
    dbms_output.put_line('Коллекция не содержит данных.');
  end if;

  merge into payment_detail p
  using ( select p_payment_id as payment_id
               , value(d).field_id as field_id
               , value(d).field_value as field_value
          from table(p_payment_detail_data) d ) v_arr
     on (p.payment_id = v_arr.payment_id and p.field_id = v_arr.field_id)
  when matched then
    update set p.field_value = v_arr.field_value
  when not matched then
    insert (payment_id, field_id, field_value)
    values (v_arr.payment_id, v_arr.field_id , v_arr.field_value);

  dbms_output.put_line(c_payment_update_discription||' по списку id_поля/значение. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss.ff'));

end insert_or_update_payment_detail;
/

/*Детали платежа удалены.*/
create or replace procedure delete_payment_detail( p_payment_id               payment.payment_id%type
                                                 , p_delete_payment_filelds   t_number_array
                                                 )
is
  c_payment_delete_discription  constant varchar2(200 char) := 'Детали платежа удалены.';
  v_current_dtime               timestamp := systimestamp;
begin
  if p_payment_id is null then
    dbms_output.put_line('ID объекта не может быть пустым.');
  end if;

  if p_delete_payment_filelds is empty or p_delete_payment_filelds is null then
    dbms_output.put_line('Коллекция не содержит данных.');
  end if;
  
  dbms_output.put_line('Колличество удаляемых полей: '||p_delete_payment_filelds.count);
  
  delete payment_detail pd
  where pd.payment_id = p_payment_id
    and pd.field_id in ( select t.column_value 
                         from table(p_delete_payment_filelds) t);

  dbms_output.put_line(c_payment_delete_discription||' по списку id_полей. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end delete_payment_detail;
/

select t.status
       ,t.*
from user_objects t
where t.object_type in ('FUNCTION', 'PROCEDURE');
/