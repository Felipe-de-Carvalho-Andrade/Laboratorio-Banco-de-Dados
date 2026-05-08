
alter table customers disable trigger all;
alter table orders disable trigger all;
alter table orderlines disable trigger all;
alter table cust_hist disable trigger all;
alter table inventory disable trigger all;
alter table products disable trigger all;

drop table if exists  inventor, customers, orders, orderlines, cust_hist cascade;
drop table if exists products, categories, reorder cascade;

drop trigger restock on inventory;
drop owned by web cascade;
drop user web;

