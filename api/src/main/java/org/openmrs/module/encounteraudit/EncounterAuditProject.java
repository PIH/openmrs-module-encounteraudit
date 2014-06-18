package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;

import java.io.Serializable;

/**
 * Created by cosmin on 6/18/14.
 */
public class EncounterAuditProject extends BaseOpenmrsData implements Serializable {

    public enum EncounterAuditProjectType {
        RANDOM, SAMPLE, LQAS, USER_AUDIT, LOCATION_AUDIT, CUSTOM
    }

    public enum EncounterAuditProjectStatus {
        COMPLETED, AUDITED, CORRECTED, INCOMPLETE, NOT_ASSESSED, RECORD_MISSING, NO_SUCH_ENCOUNTER
    }

    private Integer id;

    private String name;

    private EncounterAuditProjectType projectType;

    private EncounterAuditProjectStatus projectStatus;



    @Override
    public Integer getId() {
        return null;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public EncounterAuditProjectType getProjectType() {
        return projectType;
    }

    public void setProjectType(EncounterAuditProjectType projectType) {
        this.projectType = projectType;
    }

    public EncounterAuditProjectStatus getProjectStatus() {
        return projectStatus;
    }

    public void setProjectStatus(EncounterAuditProjectStatus projectStatus) {
        this.projectStatus = projectStatus;
    }
}
