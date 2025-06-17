alter table login_token drop constraint fk_accounts_login_token;

ALTER TABLE login_token ADD CONSTRAINT fk_token_account FOREIGN KEY (idAccounts) REFERENCES accounts(idAccounts) ON DELETE CASCADE;
