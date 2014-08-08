delete from encounteraudit_project_parameter;
delete from encounteraudit_parameter;
delete from encounteraudit_project;
delete from encounteraudit_obs;
delete from encounteraudit_encounter;
drop table if exists encounteraudit_project_parameter;
drop table if exists encounteraudit_obs;
drop table if exists encounteraudit_encounter;
drop table if exists encounteraudit_project;
drop table if exists encounteraudit_parameter;

delete from liquibasechangelog where author in ('cioan', 'pochedls') ;
