-- Cleanup products ig
alter table products drop status;

-- Expiration for tokens & IP (kind of an automatic purge I guess)
alter table login_token add column expires_at date not null;
alter table login_token add column last_ip VARBINARY(16) not null;