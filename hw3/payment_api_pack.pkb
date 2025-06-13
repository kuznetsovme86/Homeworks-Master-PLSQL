create or replace package body payment_api_pack  is
/*Создание платежа.*/
function create_payment( p_payment_from_client_id   payment.from_client_id%type
                       , p_payment_to_client_id     payment.to_client_id%type
                       , p_payment_sum              payment.summa%type
                       , p_currency_id              payment.currency_id%type
                       , p_payment_date             payment.create_dtime%type
                       , p_payment_detail_data      t_payment_detail_array
                        )
return payment.payment_id%type
is
  v_payment_id                  payment.payment_id%type;
begin
 if p_payment_detail_data is not empty then
    for i in p_payment_detail_data.first .. p_payment_detail_data.last loop
      
      if p_payment_detail_data(i).field_id is null then
        raise_application_error(c_error_code_invalid_input_parameter,c_payment_error_id_is_null);
      end if;
      
      if p_payment_detail_data(i).field_value is null then
        raise_application_error(c_error_code_invalid_input_parameter,c_payment_error_value_is_null);
      end if;
      
    end loop;
  else
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_collection_is_empty);
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

/*Сброс платежа в "ошибочный статус".*/
procedure fail_payment( p_payment_id            payment.payment_id%type
                      , p_payment_error_reason  payment.status_change_reason%type
                      )
is
  v_current_dtime               date := sysdate;
begin
  if p_payment_id is null then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_error_id_is_null);
  end if;

  if p_payment_error_reason is null then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_reason_is_null);
  end if;

  update payment p
  set p.status = с_payment_error_status, p.status_change_reason = p_payment_error_reason
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;
  
  if sql%rowcount = 0 then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_action_is_impossible);
  else
    dbms_output.put_line(c_payment_error_discription||' Статус: '||с_payment_error_status||'. Причина: '||p_payment_error_reason||'. Payment_id: '||p_payment_id||'.');  
  end if;
  
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end fail_payment;

/*Отмена платежа.*/
procedure cancel_payment( p_payment_id              payment.payment_id%type
                        , p_payment_cancel_reason   payment.status_change_reason%type
                        )
is
  v_current_dtime                date := sysdate;
begin
  if p_payment_id is null then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_error_id_is_null);
  end if;

  if p_payment_cancel_reason is null then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_reason_is_null);
  end if;

  update payment p
  set p.status = с_payment_cancel_status, p.status_change_reason = p_payment_cancel_reason
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;

  if sql%rowcount = 0 then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_action_is_impossible);
  else 
    dbms_output.put_line(c_payment_cancel_discription||' Статус: '||с_payment_cancel_status||'. Причина: '||p_payment_cancel_reason||'. Payment_id: '||p_payment_id||'.');
  end if;
        
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end cancel_payment;


/*Успешное завершение платежа.*/
procedure successful_finish_payment(p_payment_id payment.payment_id%type)
is
  v_current_dtime                 timestamp := systimestamp;
begin
  if p_payment_id is null then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_error_id_is_null);
  end if;

  update payment p
  set p.status = c_payment_success_status, p.status_change_reason = c_payment_success_discription
  where p.payment_id = p_payment_id and p.status = с_payment_create_status;
  
  if sql%rowcount = 0 then
    raise_application_error(c_error_code_invalid_input_parameter,c_payment_action_is_impossible);
  else 
    dbms_output.put_line(c_payment_success_discription||'. Статус: '||c_payment_success_status||'. Payment_id: '||p_payment_id||'.');
  end if;
  
  dbms_output.put_line(to_char(v_current_dtime, 'dd.mm.yyyy hh24:mi:ss'));
end successful_finish_payment;


end payment_api_pack ;
/