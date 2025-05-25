/*
Автор: Кузнецов Дмитрий Павлович.
Описание скрипта: API для сущностей “Платеж” и “Детали платежа”.
*/

--Создание платежа.
declare
    v_payment_action_message varchar2(200 char):= 'Платеж создан. '; 
    c_status_payment_success_creation payment.status%type:=0;
  
    v_payment_id payment.payment_id%type;
    v_create_dtime timestamp := systimestamp;
    v_summa payment.summa%type := 100;
    v_currency_id payment.currency_id%type := 840;
    v_from_client_id payment.from_client_id%type := 1;
    v_to_client_id payment.to_client_id%type := 2;
    
    v_payment_detail_data t_payment_detail_array := t_payment_detail_array( t_payment_detail(1,'Миобильное приложение банка X.')
                                                                        , t_payment_detail(2,'217.158.3.5')
                                                                        , t_payment_detail(3,'Оплата за домашний интернет за май.')
                                                                        );     
begin
  if v_payment_detail_data is not empty then
    for i in v_payment_detail_data.first .. v_payment_detail_data.last
    loop
        if v_payment_detail_data(i).field_id is null then 
            dbms_output.put_line('ID поля не может быть пустым');
        end if;
        if v_payment_detail_data(i).field_value is null then
            dbms_output.put_line('Значение в поле не может быть пустым');
        end if;
        dbms_output.put_line ('Field_id: ' || v_payment_detail_data(i).field_id || '. Field_value: ' || v_payment_detail_data(i).field_value);
    end loop;
    
  else 
    dbms_output.put_line('Коллекция не содержит данных');
  end if;

        insert into payment(payment_id, create_dtime, summa, currency_id, from_client_id, to_client_id, status) 
             values (
                        payment_seq.nextval,
                        v_create_dtime,
                        v_summa,
                        v_currency_id,
                        v_from_client_id,
                        v_to_client_id,
                        c_status_payment_success_creation
                    )
        returning payment_id into v_payment_id;
        
        insert into payment_detail(payment_id, field_id, field_value) 
        select v_payment_id, field_id, field_value
        from table (v_payment_detail_data);
        
    dbms_output.put_line('v_payment_id='||v_payment_id);
    dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_creation||'.');
    dbms_output.put_line(to_char(v_create_dtime,'dd.mm.yyyy hh24'));
end;
/

--Сброс платежа в "ошибочный статус".
declare
  v_payment_action_message varchar2(200 char):= 'Сброс платежа в "ошибочный статус" с указанием причины. '; 
  c_status_payment_success_creation payment.status%type:=0;
  c_status_payment_reset_error constant payment.status%type:=2;
  v_reason_message payment.status_change_reason%type:= 'Причина: недостаточно средств.';
  v_current_dtime timestamp := systimestamp;
  v_payment_id  payment.payment_id%type := 105;
  v_payment_exist number(5):=0;
begin
  if v_payment_id is not null then
    if v_reason_message is not null then
        dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_reset_error|| '. '||v_reason_message);
        dbms_output.put_line(to_char(v_current_dtime,'dd.mm.yyyy hh24:mi:ss'));
        dbms_output.put_line('v_payment_id='||v_payment_id);
        
        select count(1) into v_payment_exist
        from payment p
        where p.payment_id = v_payment_id
        and p.status = c_status_payment_success_creation;
        
        if v_payment_exist = 1
        then
            update payment p
            set
                p.status = c_status_payment_reset_error,
                p.status_change_reason = v_reason_message
            where
                p.payment_id = v_payment_id
            and p.status = c_status_payment_success_creation;
        else
            dbms_output.put_line('Невозможно выполнить операцию.');
        end if;
    else dbms_output.put_line('Причина не может быть пустой.');
    end if;
  else dbms_output.put_line('ID объекта не может быть пустым');
  end if;
end;
/

--Отмена платежа.
declare
  v_payment_action_message varchar2(200 char):= 'Отмена платежа с указанием причины. '; 
  c_status_payment_success_creation payment.status%type:=0;
  c_status_payment_cancel constant payment.status%type:=3;
  v_reason_message payment.status_change_reason%type:= 'Причина: ошибка пользователя.';
  v_current_dtime timestamp := systimestamp;
  v_payment_id  payment.payment_id%type := 777;
  v_payment_exist number(5):=0;
begin
  if v_payment_id is null then dbms_output.put_line('ID объекта не может быть пустым');
  elsif v_reason_message is null then dbms_output.put_line('Причина не может быть пустой.');
  else 
    dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_cancel|| '. '||v_reason_message);
    dbms_output.put_line(to_char(v_current_dtime,'day-mon-yy'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
    
    select count(1) into v_payment_exist
    from payment p
    where p.payment_id = v_payment_id
    and p.status = c_status_payment_success_creation;
        
    if v_payment_exist = 1
    then
        update payment p
        set
            p.status = c_status_payment_cancel,
            p.status_change_reason = v_reason_message
        where
            p.payment_id = v_payment_id
            and p.status = c_status_payment_success_creation;
        else
            dbms_output.put_line('Невозможно выполнить операцию.');
        end if;
  end if;
end;
/

--Успешное завершение платежа.
declare
  v_payment_action_message varchar2(200 char):= 'Успешное завершение платежа. '; 
  c_status_payment_success_creation payment.status%type:=0;
  c_status_payment_success_end constant payment.status%type:=1;
  v_current_dtime timestamp := systimestamp;
  v_payment_id  payment.payment_id%type := 55;
  v_payment_exist number(5):=0;
begin
  if v_payment_id is not null then
  dbms_output.put_line(v_payment_action_message||'Статус: '||c_status_payment_success_end||'.');
  dbms_output.put_line(to_char(v_current_dtime,'WW-Q-yy:hh24:mi->ss'));
  dbms_output.put_line('v_payment_id='||v_payment_id);
  
    select count(1) into v_payment_exist
    from payment p
    where p.payment_id = v_payment_id
    and p.status = c_status_payment_success_creation;
        
    if v_payment_exist = 1
    then
        update payment p
        set
            p.status = c_status_payment_success_end,
            p.status_change_reason = null
        where
            p.payment_id = v_payment_id
            and p.status = c_status_payment_success_creation;
        else
            dbms_output.put_line('Невозможно выполнить операцию.');
        end if;
  else dbms_output.put_line('ID объекта не может быть пустым');
  end if;
end;
/

--Данные платежа добавлены или обновлены.
declare
  v_data_payment_action_message varchar2(200 char):= 'Данные платежа добавлены или обновлены '; 
  c_payment_param_list_id_value constant varchar2(200 char):='по списку id_поля/значение.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type := 4;
  v_payment_detail_data t_payment_detail_array := t_payment_detail_array( t_payment_detail(1,'Миобильное приложение банка X.')
                                                                        , t_payment_detail(3,'Оплата за домашний интернет.')
                                                                        );
begin
  if v_payment_detail_data is not empty then
    for i in v_payment_detail_data.first .. v_payment_detail_data.last
    loop
        if v_payment_detail_data(i).field_id is null then 
            dbms_output.put_line('ID поля не может быть пустым');
        end if;
        if v_payment_detail_data(i).field_value is null then
            dbms_output.put_line('Значение в поле не может быть пустым');
        end if;
        dbms_output.put_line ('Field_id: ' || v_payment_detail_data(i).field_id || '. Field_value: ' || v_payment_detail_data(i).field_value);
    end loop;
    
  else 
    dbms_output.put_line('Коллекция не содержит данных');
  end if;
  
  case v_payment_id
    when null then dbms_output.put_line('ID объекта не может быть пустым');
  else 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id_value);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff6'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
    
    merge into payment_detail d
    using (select v_payment_id as payment_id, value(t).field_id as field_id, value(t).field_value as field_value
           from table (v_payment_detail_data) t) t
    on     (d.payment_id = t.payment_id
        and d.field_id = t.field_id)
    when matched then
        update set
            d.field_value = t.field_value
    when not matched then
        insert (d.payment_id, d.field_id, d.field_value)
        values(t.payment_id, t.field_id, t.field_value);
  end case;
end;
/

--Детали платежа удалены.
declare
  v_data_payment_action_message varchar2(200 char):= 'Детали платежа удалены '; 
  c_payment_param_list_id constant varchar2(200 char):='по списку id_полей.';
  v_current_dts timestamp:= systimestamp;
  v_payment_id  payment.payment_id%type:=56;
  v_deleted_payment_fields t_number_array := t_number_array(1,4);
begin
  case 
  when v_payment_id is not null then 
    dbms_output.put_line(v_data_payment_action_message||c_payment_param_list_id);
    dbms_output.put_line(to_char(v_current_dts,'dd.mm.yyyy hh24:mi:ss.ff9'));
    dbms_output.put_line('v_payment_id='||v_payment_id);
    if v_deleted_payment_fields is empty  then
        dbms_output.put_line ('Коллекция не содержит данных.');
    else
        dbms_output.put_line ('Количество удаляемых полей:'||v_deleted_payment_fields.count());
        delete from payment_detail d
        where d.PAYMENT_ID = v_payment_id
        and d.FIELD_ID in (select t.column_value from table(v_deleted_payment_fields) t);
    end if;  
  else dbms_output.put_line('ID объекта не может быть пустым');
  end case;
end;
/
