package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;

import java.io.Serializable;

/**
 * Created by pochedls on 30/07/2014.
 */
public class EncounterAuditProjectParameter  implements Serializable {

    private EncounterAuditProjectParameterId id = new EncounterAuditProjectParameterId();
    private String parameterValue;

    public EncounterAuditProjectParameter() {

    }

    public EncounterAuditProjectParameterId getId() {
        return id;
    }

    public void setId(EncounterAuditProjectParameterId id) {
        this.id = id;
    }

    public EncounterAuditProject getEncounterAuditProject() {
        return id.getProject();
    }

    public void setEncounterAuditProject( EncounterAuditProject encounterAuditProject) {
       getId().setProject(encounterAuditProject);
    }

    public EncounterAuditParameter getEncounterAuditParameter() {
        return id.getParameter();
    }

    public void setEncounterAuditParameter( EncounterAuditParameter encounterAuditParameter) {
        getId().setParameter(encounterAuditParameter);
    }

    public String getParameterValue() {
        return parameterValue;
    }

    public void setParameterValue(String parameterValue) {
        this.parameterValue = parameterValue;
    }


}
