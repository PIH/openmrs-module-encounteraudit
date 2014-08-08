package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;
import org.openmrs.util.OpenmrsUtil;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

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

    private Set<EncounterAuditProjectParameter> projectParameters = null;


    @Override
    public Integer getId() {
        return id;
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

    public Set<EncounterAuditProjectParameter> getProjectParameters() {
        if (projectParameters == null ) {
            projectParameters = new TreeSet<EncounterAuditProjectParameter>();
        }
        return this.projectParameters;
    }

    public void setProjectParameters(Set<EncounterAuditProjectParameter> projectParameters) {
        this.projectParameters = projectParameters;
    }

    public void addProjectParameter(EncounterAuditProjectParameter projectParameter) {
        if (projectParameter != null ) {
            projectParameter.setProject(this);
            if (projectParameters == null ) {
                projectParameters = new TreeSet<EncounterAuditProjectParameter>();
            }
            projectParameters.add(projectParameter);
        }
    }
}
