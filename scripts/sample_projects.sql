delete from encounteraudit_project_parameter;
delete from encounteraudit_project;
delete from encounteraudit_parameter;
INSERT INTO encounteraudit_project (id, name, project_type, project_status, creator, uuid, date_created)
VALUES (1, "Fall Assessment", "SAMPLE", "INCOMPLETE", 58324, "b71bb89a-2695-102d-b4c2-001d929acb54", "2013-09-01");
INSERT INTO encounteraudit_project (id, name, project_type, project_status, creator, uuid, date_created)
VALUES (2, "Joji Quality Review", "USER_AUDIT", "INCOMPLETE", 58324, "b71bb89a-2695-102d-b4c2-001d929acb55", "2014-01-01");
INSERT INTO encounteraudit_project (id, name, project_type, project_status, creator, uuid, date_created)
VALUES (3, "Magaleta Review", "LOCATION_AUDIT", "INCOMPLETE", 58324, "b71bb89a-2695-102d-b4c2-001d929acb56", "2014-01-01");
INSERT INTO encounteraudit_project (id, name, project_type, project_status, creator, uuid, date_created)
VALUES (4, "LQAS NDH", "LQAS", "INCOMPLETE", 58324, "b71bb89a-2695-102d-b4c2-001d929acb57", "2014-01-01");



INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (1, "description", "java.lang.String", "");
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (2, "start_date", "java.util.Date", NULL);
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (3, "end_date", "java.util.Date", NULL);
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (4, "location", "org.openmrs.Location", NULL);
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (5, "encounter_type", "org.openmrs.EncounterType", NULL);
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (6, "creator", "org.openmrs.User", NULL);
INSERT INTO encounteraudit_parameter (parameter_id, name, class_name, default_value)
VALUES (7, "number_of_records", "java.lang.Integer", 25);


INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (1, 1, "Annual district-wide data quality assessment.");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (1, 2, "2014-09-01");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (1, 3, "2014-12-31");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (1, 5, "ART_FOLLOWUP");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (1, 7, 550);

INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 1, "Quality assessment for Joji.");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 2, "2014-09-01");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 3, "2014-12-31");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 4, "Neno District Hospital");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 5, "ART_FOLLOWUP");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 6, "45635");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (2, 7, 550);

INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 1, "ART eMastercard Review for Magaleta.");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 2, "2014-09-01");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 3, "2014-12-31");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 4, "Magaleta Health Center");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 5, "ART_INITIAL");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (3, 7, 30);

INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 1, "Neno District Hospital LWAS.");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 2, "2014-09-01");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 3, "2014-12-31");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 4, "Neno District Hospital");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 5, "ART_INITIAL");
INSERT INTO encounteraudit_project_parameter (project_id, parameter_id, parameter_value)
VALUES (4, 7, 25);



