create table awaiting_mfas (id int primary key auto_increment, token text not null, idAccounts int not null, generated_at datetime not null default current_timestamp());
alter table awaiting_mfas add constraint fk_awaiting_mfas_accounts foreign key (idAccounts) references accounts(idAccounts);
alter table awaiting_mfas add unique index uq_mfa_token (token);
alter table awaiting_mfas add unique index uq_mfa_uniqueAccount (idAccounts);