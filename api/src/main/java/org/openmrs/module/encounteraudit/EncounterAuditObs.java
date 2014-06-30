package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;
import org.openmrs.Obs;
import org.openmrs.User;

import java.io.Serializable;


public class EncounterAuditObs extends BaseOpenmrsData implements Serializable {


    private Integer id;

    private EncounterAuditEncounter encounterAuditEncounter;

    private Obs obs;

    private String originalValue;

    private String auditValue;

    private EncounterAuditProject.EncounterAuditProjectStatus obsAuditStatus;

    private EncounterAuditEncounter.EncounterAuditCodeType obsAuditCodeType;

    private User auditor;

    @Override
    public Integer getId() {
        return this.id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public EncounterAuditEncounter getEncounterAuditEncounter() {
        return encounterAuditEncounter;
    }

    public void setEncounterAuditEncounter(EncounterAuditEncounter encounterAuditEncounter) {
        this.encounterAuditEncounter = encounterAuditEncounter;
    }

    public Obs getObs() {
        return obs;
    }

    public void setObs(Obs obs) {
        this.obs = obs;
    }

    public String getOriginalValue() {
        return originalValue;
    }

    public void setOriginalValue(String originalValue) {
        this.originalValue = originalValue;
    }

    public String getAuditValue() {
        return auditValue;
    }

    public void setAuditValue(String auditValue) {
        this.auditValue = auditValue;
    }

    public EncounterAuditProject.EncounterAuditProjectStatus getObsAuditStatus() {
        return obsAuditStatus;
    }

    public void setObsAuditStatus(EncounterAuditProject.EncounterAuditProjectStatus obsAuditStatus) {
        this.obsAuditStatus = obsAuditStatus;
    }

    public EncounterAuditEncounter.EncounterAuditCodeType getObsAuditCodeType() {
        return obsAuditCodeType;
    }

    public void setObsAuditCodeType(EncounterAuditEncounter.EncounterAuditCodeType obsAuditCodeType) {
        this.obsAuditCodeType = obsAuditCodeType;
    }

    public User getAuditor() {
        return auditor;
    }

    public void setAuditor(User auditor) {
        this.auditor = auditor;
    }
}
