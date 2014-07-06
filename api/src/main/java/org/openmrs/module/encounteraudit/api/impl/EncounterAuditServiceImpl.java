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
package org.openmrs.module.encounteraudit.api.impl;

import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.encounteraudit.api.EncounterAuditService;
import org.openmrs.module.encounteraudit.api.db.EncounterAuditDAO;

import java.util.Date;
import java.util.List;

/**
 * It is a default implementation of {@link EncounterAuditService}.
 */
public class EncounterAuditServiceImpl extends BaseOpenmrsService implements EncounterAuditService {
	
	protected final Log log = LogFactory.getLog(this.getClass());
	
	private EncounterAuditDAO dao;
	
	/**
     * @param dao the dao to set
     */
    public void setDao(EncounterAuditDAO dao) {
	    this.dao = dao;
    }
    
    /**
     * @return the dao
     */
    public EncounterAuditDAO getDao() {
	    return dao;
    }

    @Override
    public List<Encounter> getAuditEncounters(Date fromDate, Date toDate, int sampleSize, Location location, EncounterType encounterType, String creatorId) {
        return dao.getAuditEncounters(fromDate, toDate, sampleSize, location, encounterType, creatorId);
    }
}