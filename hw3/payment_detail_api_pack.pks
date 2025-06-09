create or replace package payment_detail_api_pack is
--Автор: Кузнецов Дмитрий Павлович.
--Описание: API для сущности “Детали платежа”.
--Важно: В схеме должен быть создан пакет payment_api_package

  c_payment_update_discription      constant varchar2(200 char) := 'Данные платежа добавлены или обновлены.';
  c_payment_delete_discription      constant varchar2(200 char) := 'Детали платежа удалены.';
/*Данные платежа добавлены или обновлены.*/
procedure insert_or_update_payment_detail( p_payment_id              payment.payment_id%type
                                         , p_payment_detail_data     t_payment_detail_array
                                         );

/*Детали платежа удалены.*/
procedure delete_payment_detail( p_payment_id               payment.payment_id%type
                               , p_delete_payment_filelds   t_number_array
                               );                                                         
end payment_detail_api_pack;
/