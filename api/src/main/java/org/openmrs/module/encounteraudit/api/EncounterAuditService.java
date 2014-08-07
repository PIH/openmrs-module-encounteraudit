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
package org.openmrs.module.encounteraudit.api;

import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.api.APIException;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.encounteraudit.EncounterAudit;
import org.openmrs.module.encounteraudit.EncounterAuditParameter;
import org.openmrs.module.encounteraudit.EncounterAuditProject;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * This service exposes module's core functionality. It is a Spring managed bean which is configured in moduleApplicationContext.xml.
 * <p>
 * It can be accessed only via Context:<br>
 * <code>
 * Context.getService(EncounterAuditService.class).someMethod();
 * </code>
 * 
 * @see org.openmrs.api.context.Context
 */
@Transactional
public interface EncounterAuditService extends OpenmrsService {
     
	/*
	 * Add service methods here
	 * 
	 */
    public List<Encounter> getAuditEncounters(Date fromDate, Date toDate, int sampleSize, Location location, EncounterType encounterType, String creatorId);

    public List<EncounterAuditProject> getAuditProjects();

    public List<EncounterAuditParameter> getAuditProjectParameters();

    public EncounterAuditProject saveEncounterAuditProject(EncounterAuditProject encounterAuditProject);

    public EncounterAuditParameter getParameterByName(String name) throws APIException;
}