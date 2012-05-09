# --- First database schema

# --- !Ups

create table task (
  id                        bigint not null AUTO_INCREMENT,
  label                     varchar(255),
  constraint pk_task primary key (id))
;


# --- !Downs

SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists task;

SET REFERENTIAL_INTEGRITY TRUE;
