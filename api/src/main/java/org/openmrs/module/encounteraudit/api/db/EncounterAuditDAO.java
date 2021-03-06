/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.encounteraudit.api.db;

import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.encounteraudit.EncounterAuditParameter;
import org.openmrs.module.encounteraudit.EncounterAuditProject;
import org.openmrs.module.encounteraudit.EncounterAuditProjectParameter;
import org.openmrs.module.encounteraudit.api.EncounterAuditService;

import java.util.Date;
import java.util.List;

/**
 *  Database methods for {@link EncounterAuditService}.
 */
public interface EncounterAuditDAO {

	/*
	 * Add DAO methods here
	 */
    public List<Encounter> getAuditEncounters(Date fromDate, Date toDate, int sampleSize, Location location, EncounterType encounterType, String creatorId);

    public List<EncounterAuditProject> getAuditProjects();

    public List<EncounterAuditParameter> getAuditProjectParameters();

    public EncounterAuditProject saveEncounterAuditProject(EncounterAuditProject encounterAuditProject);

    public EncounterAuditParameter getParameterByName(String name) throws DAOException;

    public EncounterAuditProject getEncounterAuditProjectById(Integer projectId) throws DAOException;
}