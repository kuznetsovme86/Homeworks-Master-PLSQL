create or replace package body payment_detail_api_pack is

/*Данные платежа добавлены или обновлены.*/
procedure insert_or_update_payment_detail( p_payment_id              payment.payment_id%type
                                         , p_payment_detail_data     t_payment_detail_array
                                         )
is
  v_current_dtime                 timestamp := systimestamp;
begin
  if p_payment_id is null then
    dbms_output.put_line(payment_api_pack.c_payment_error_id_is_null);
  end if;

  if p_payment_detail_data is not empty then
    for i in p_payment_detail_data.first .. p_payment_detail_data.last loop
      if p_payment_detail_data(i).field_id is null then
        dbms_output.put_line(payment_api_pack.c_payment_error_id_is_null);
      end if;

      if p_payment_detail_data(i).field_value is null then
        dbms_output.put_line(payment_api_pack.c_payment_error_value_is_null);
      end if;
    end loop;
  else
    dbms_output.put_line(payment_api_pack.c_payment_collection_is_empty);
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


/*Детали платежа удалены.*/
procedure delete_payment_detail( p_payment_id               payment.payment_id%type
                               , p_delete_payment_filelds   t_number_array
                               )
is
  v_current_dtime               timestamp := systimestamp;
begin
  if p_payment_id is null then
    dbms_output.put_line(payment_api_pack.c_payment_error_id_is_null);
  end if;

  if p_delete_payment_filelds is empty or p_delete_payment_filelds is null then
    dbms_output.put_line(payment_api_pack.c_payment_collection_is_empty);
  end if;
  
  dbms_output.put_line('Колличество удаляемых полей: '||p_delete_payment_filelds.count);
  
  delete payment_detail pd
  where pd.payment_id = p_payment_id
    and pd.field_id in ( select t.column_value 
                         from table(p_delete_payment_filelds) t);

  dbms_output.put_line(c_payment_delete_discription||' по списку id_полей. Payment_id: '||p_payment_id||'.');
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end delete_payment_detail;

end payment_detail_api_pack ;
/