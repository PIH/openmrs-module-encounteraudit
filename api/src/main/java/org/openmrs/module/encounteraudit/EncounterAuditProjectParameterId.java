package org.openmrs.module.encounteraudit;

import java.io.Serializable;

/**
 * Created by pochedls on 30/07/2014.
 */
public class EncounterAuditProjectParameterId implements Serializable {

    private EncounterAuditProject project;
    private EncounterAuditParameter parameter;

    public EncounterAuditProjectParameterId(){
        super();
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
}
