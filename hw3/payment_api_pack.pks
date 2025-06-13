create or replace package payment_api_pack is
--Автор: Кузнецов Дмитрий Павлович.
--Описание: API для сущности “Платеж”

  с_payment_create_status           constant payment.status%type := 0;
  с_payment_error_status            constant payment.status%type := 2;
  с_payment_cancel_status           constant payment.status%type := 3;
  c_payment_success_status          constant payment.status%type := 1;  
  
  c_payment_create_discription      constant varchar2(200 char) := 'Платеж создан';
  c_payment_error_discription       constant varchar2(200 char) := 'Сброс платежа в "ошибочный статус" с указанием причины.';
  c_payment_cancel_discription      constant varchar2(200 char) := 'Отмена платежа с указанием причины.';
  c_payment_success_discription     constant varchar2(200 char) := 'Успешное завершение платежа';
  
  c_payment_error_id_is_null        constant varchar2(200 char) := 'ID поля не может быть пустым.';
  c_payment_error_value_is_null     constant varchar2(200 char) := 'Значение в поле не может быть пустым.';
  c_payment_collection_is_empty     constant varchar2(200 char) := 'Коллекция не содержит данных.';
  c_payment_reason_is_null          constant varchar2(200 char) := 'Причина не может быть пустой.';
  c_payment_action_is_impossible    constant varchar2(200 char) := 'Невозможно выполнить операцию.';
  
  c_error_code_invalid_input_parameter constant number(10) := -20101;
  e_invalid_input_parameter exception;
  
  pragma exception_init(e_invalid_input_parameter, c_error_code_invalid_input_parameter);
  
/*Создание платежа.*/
function create_payment( p_payment_from_client_id   payment.from_client_id%type
                                         , p_payment_to_client_id     payment.to_client_id%type
                                         , p_payment_sum              payment.summa%type
                                         , p_currency_id              payment.currency_id%type
                                         , p_payment_date             payment.create_dtime%type
                                         , p_payment_detail_data      t_payment_detail_array
                                         )
return payment.payment_id%type;

/*Сброс платежа в "ошибочный статус".*/
procedure fail_payment( p_payment_id            payment.payment_id%type
                                        , p_payment_error_reason  payment.status_change_reason%type
                                        );

/*Отмена платежа.*/                                        
procedure cancel_payment( p_payment_id              payment.payment_id%type
                                          , p_payment_cancel_reason   payment.status_change_reason%type
                                          );
                                          
/*Успешное завершение платежа.*/
procedure successful_finish_payment(p_payment_id payment.payment_id%type);                                                                                  
end payment_api_pack;
/

