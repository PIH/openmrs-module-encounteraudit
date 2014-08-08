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
package org.openmrs.module.encounteraudit.api.db.hibernate;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.encounteraudit.EncounterAuditParameter;
import org.openmrs.module.encounteraudit.EncounterAuditProject;
import org.openmrs.module.encounteraudit.EncounterAuditProjectParameter;
import org.openmrs.module.encounteraudit.api.db.EncounterAuditDAO;

import javax.validation.constraints.Null;
import java.util.Date;
import java.util.List;

/**
 * It is a default implementation of  {@link EncounterAuditDAO}.
 */
public class HibernateEncounterAuditDAO implements EncounterAuditDAO {
	protected final Log log = LogFactory.getLog(this.getClass());
	
	private SessionFactory sessionFactory;
	
	/**
     * @param sessionFactory the sessionFactory to set
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
	    this.sessionFactory = sessionFactory;
    }
    
	/**
     * @return the sessionFactory
     */
    public SessionFactory getSessionFactory() {
	    return sessionFactory;
    }

    @Override
    public List<EncounterAuditProject> getAuditProjects() {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(EncounterAuditProject.class);
        criteria.add(Expression.eq("voided", false));
        List<EncounterAuditProject> list = null;
        try {
            list = (List<EncounterAuditProject>) criteria.list();
        } catch (Exception e) {
            log.error("Error retrieving projects", e);
        }

        return list;

    }

    @Override
    public List<EncounterAuditParameter> getAuditProjectParameters() {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(EncounterAuditParameter.class);
        List<EncounterAuditParameter> list = null;
        try {
             list = criteria.list();
        } catch (Exception e) {
            log.error("Error retrieving parameters", e);
        }

        return list;

    }

    @Override
    public List<Encounter> getAuditEncounters(Date fromDate, Date toDate, int sampleSize, Location location, EncounterType encounterType, String creatorId) {

        if (sampleSize < 1) {
            // by default return 25 records
            sampleSize = 25;
        }

        StringBuilder sql = new StringBuilder("select * from encounter e where ");
        sql.append(" encounter_datetime > :fromDate and ");
        sql.append(" encounter_datetime < :toDate ");
        if (location != null) {
            sql.append(" and location_id = :locationId ");
        }
        if (encounterType != null) {
            sql.append(" and encounter_type = :encounterType ");
        }
        if (creatorId.length() != 0) {
            sql.append(" and creator = :creatorId and changed_by IS NULL ");
        }
        sql.append(" order by rand() ");
        sql.append("limit 0,:sampleSize ");

        SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql.toString()).addEntity(Encounter.class);
        query.setDate("fromDate", fromDate);
        query.setDate("toDate", toDate);
        query.setInteger("sampleSize", new Integer(sampleSize));

        if (location != null) {
            query.setInteger("locationId", new Integer(location.getLocationId()));
        }
        if (encounterType != null) {
            query.setInteger("encounterType", new Integer(encounterType.getEncounterTypeId()));
        }
        if (creatorId.length() != 0) {
            query.setString("creatorId", creatorId);
        }

        List<Encounter> encounterList = query.list();

        return encounterList;
    }

    @Override
    public EncounterAuditProject saveEncounterAuditProject(EncounterAuditProject encounterAuditProject) {
        try{
            sessionFactory.getCurrentSession().saveOrUpdate(encounterAuditProject);
        } catch (Exception e) {
            log.error("Error saving encounter audit project", e);
        }
        return encounterAuditProject;
    }

    @Override
    public EncounterAuditParameter getParameterByName(String name)  throws DAOException {
        Criteria crit = sessionFactory.getCurrentSession().createCriteria(EncounterAuditParameter.class);
        crit.add(Expression.eq("name", name));
        EncounterAuditParameter encounterAuditParameter = (EncounterAuditParameter) crit.uniqueResult();
        return encounterAuditParameter;
    }

}