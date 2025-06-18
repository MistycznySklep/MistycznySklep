ALTER TABLE carts DROP CONSTRAINT fk_accounts_carts;
ALTER TABLE carts ADD CONSTRAINT fk_accounts_carts FOREIGN KEY(idAccounts) REFERENCES accounts(idAccounts) ON DELETE CASCADE; 


alter table awaiting_mfas drop constraint fk_awaiting_mfas_accounts;
alter table awaiting_mfas add constraint fk_awaiting_mfas_accounts foreign key (idAccounts) references accounts(idAccounts) on delete cascade;

alter table awaiting_mfa_logins drop constraint fk_awaiting_mfa_login_accounts;
alter table awaiting_mfa_logins add constraint fk_awaiting_mfa_login_accounts foreign key (idAccounts) references accounts(idAccounts) on delete cascade;