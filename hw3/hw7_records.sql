/*
Автор: Кузнецов Дмитрий Павлович.
*/

/*Задания:
1) Создайте тип record с тремя полями. Тип полей на ваш выбор.
Одно поле без ограничений и без значения по умолчанию.
Одно поле с ограничением на not null и значением по умолчанию.
Одно поле без ограничений и со значением по умолчанию.

2) Создайте несколько переменных с этим типом в обычном анонимном блоке.

3) Присвойте значения первому полю всех переменных из п.2.
4) Выведите значения полей в буфер вывода.
5) Присвойте одной из переменных значение null. Попробуйте сделать условие, если переменная равна null, то выводится сообщение “It’s null”. Если не null, то сообщение “It’s not null”. Можно использовать case из предыдущей лекции.
*/
declare 
    type t_payment_type is record(
    payment_id      number(38),
    create_dtime    date not null :=sysdate,
    amount          number(30,2):=0);
    
    v_payment_from_terminal t_payment_type;
    v_payment_from_partners t_payment_type;
    
    procedure print_payment_values (p_rec t_payment_type)
    is
    begin
    dbms_output.put_line('payment_id='||p_rec.payment_id||', payment_id='||to_char(p_rec.create_dtime,'dd.mm.yyyy hh24:mi:ss')||', amount='||p_rec.amount);
    end;
    
    /*procedure print_payment_null_check (p_rec t_payment_type)
    is
    begin
    dbms_output.put_line('payment_id='||nvl2(p_rec.payment_id,'It’s not null','It’s null')||
                         ', create_dtime='||nvl2(p_rec.create_dtime,'It’s not null','It’s null')||
                         ', amount='||nvl2(p_rec.amount,'It’s not null','It’s null'));
    end;*/
      
begin
    v_payment_from_terminal.payment_id :=1;
    v_payment_from_partners.payment_id :=2;
    
    print_payment_values(v_payment_from_terminal);
    print_payment_values(v_payment_from_partners);
    
    v_payment_from_partners :=null;
    print_payment_values(v_payment_from_partners);
    
    --напечатает It’s not null
    case 
      when v_payment_from_partners.payment_id is null and
           v_payment_from_partners.create_dtime is null and
           v_payment_from_partners.amount is null
      then dbms_output.put_line('It’s null');
      else dbms_output.put_line('It’s not null');
    end case;   
end;
/

/*Задания:
6) Создайте запись с использованием rowtype от таблицы payment_detail_field. 
Создайте переменную, через select получите в неё строку из таблицы, выведите несколько полей в буфер вывода.
*/
declare
    v_payment_rec payment%rowtype;
    v_payment_id number;
begin
    v_payment_id :=1;
    
    select * into v_payment_rec
    from payment p
    where p.PAYMENT_ID = v_payment_id;
    
    dbms_output.put_line('payment_id='||v_payment_rec.payment_id ||', summa='||v_payment_rec.summa);
exception
     when NO_DATA_FOUND THEN dbms_output.put_line('No data in table payment with PAYMENT_ID='||v_payment_id);
     when TOO_MANY_ROWS THEN dbms_output.put_line('There are more then 1 row in table payment with PAYMENT_ID='||v_payment_id);
     when OTHERS THEN dbms_output.put_line(SQLCODE); 
end;