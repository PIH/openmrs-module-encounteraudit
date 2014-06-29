package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;
import org.openmrs.Encounter;
import org.openmrs.User;


import java.io.Serializable;


public class EncounterAuditEncounter extends BaseOpenmrsData implements Serializable  {

    public enum EncounterAuditCodeType {
        CORRECT, INCORRECT, HAS_VALUE_BUT_BLANK_IN_EMR, MISSING_VALUE_BUT_EXISTS_IN_EMR
    }

    private Integer id;

    private EncounterAuditProject project;

    private Encounter encounter;

    private User auditor;

    private EncounterAuditProject.EncounterAuditProjectStatus encounterAuditStatus;

    private EncounterAuditCodeType encounterAuditCodeType;

    @Override
    public Integer getId() {
        return this.id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public EncounterAuditProject getProject() {
        return project;
    }

    public void setProject(EncounterAuditProject project) {
        this.project = project;
    }

    public Encounter getEncounter() {
        return encounter;
    }

    public void setEncounter(Encounter encounter) {
        this.encounter = encounter;
    }

    public User getAuditor() {
        return auditor;
    }

    public void setAuditor(User auditor) {
        this.auditor = auditor;
    }

    public EncounterAuditProject.EncounterAuditProjectStatus getEncounterAuditStatus() {
        return encounterAuditStatus;
    }

    public void setEncounterAuditStatus(EncounterAuditProject.EncounterAuditProjectStatus encounterAuditStatus) {
        this.encounterAuditStatus = encounterAuditStatus;
    }

    public EncounterAuditCodeType getEncounterAuditCodeType() {
        return encounterAuditCodeType;
    }

    public void setEncounterAuditCodeType(EncounterAuditCodeType encounterAuditCodeType) {
        this.encounterAuditCodeType = encounterAuditCodeType;
    }
}
