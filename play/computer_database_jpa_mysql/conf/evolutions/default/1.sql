# --- First database schema

# --- !Ups

create table Company (
  id                        bigint not null AUTO_INCREMENT,
  name                      varchar(255),
  constraint pk_company primary key (id))
;

create table Computer (
  id                        bigint not null AUTO_INCREMENT,
  name                      varchar(255),
  introduced                timestamp,
  discontinued              timestamp,
  company_id                bigint,
  constraint pk_computer primary key (id))
;

ALTER TABLE Company AUTO_INCREMENT = 1000;
ALTER TABLE Computer AUTO_INCREMENT = 1000;

alter table Computer add constraint fk_computer_company_1 foreign key (company_id) references company (id) on delete restrict on update restrict;
create index ix_computer_company_1 on Computer (company_id);


# --- !Downs

SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists Company;

drop table if exists Computer;

SET REFERENTIAL_INTEGRITY TRUE;
