create table admin_logs (id int auto_increment primary key, type int not null, created_at datetime not null default current_timestamp, idDetails int not null);
create table admin_log_type (id int auto_increment primary key, name varchar(64) not null);
alter table admin_logs add constraint fk_log_type foreign key (type) references admin_log_type(id);
insert into admin_log_type values (NULL, "Nowe konto"), (NULL, "Nieudane logowanie"), (NULL, "Ok logowanie");
create table admin_log_details (id int auto_increment primary key, idAccount int null, idToken int null);
alter table admin_log_details add constraint fk_log_details_account foreign key (idAccount) references accounts(idAccounts) on delete cascade;
alter table admin_log_details add constraint fk_log_details_tokens foreign key (idToken) references login_token(idLogin_token) on delete cascade;
