package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;

import java.io.Serializable;

/**
 * Created by pochedls on 30/07/2014.
 */
public class EncounterAuditProjectParameter  implements Serializable, Comparable<EncounterAuditProjectParameter> {

    private Integer id;

    private EncounterAuditProject project;

    private EncounterAuditParameter parameter;

    private String parameterValue;

    public EncounterAuditProjectParameter() {}

    public EncounterAuditProjectParameter(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public EncounterAuditProject getProject() {
        return project;
    }

    public void setProject(EncounterAuditProject project) {
        this.project = project;
    }

    public EncounterAuditParameter getParameter() {
        return parameter;
    }

    public void setParameter(EncounterAuditParameter parameter) {
        this.parameter = parameter;
    }

    public String getParameterValue() {
        return parameterValue;
    }

    public void setParameterValue(String parameterValue) {
        this.parameterValue = parameterValue;
    }

    @Override
    public int compareTo(EncounterAuditProjectParameter other) {
        int retValue = 0;
        if (other !=null ){
            retValue = getParameter().getParameterId().compareTo(other.getParameter().getId());
        }
        return retValue;
    }
}
