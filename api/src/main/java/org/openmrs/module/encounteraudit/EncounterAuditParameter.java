package org.openmrs.module.encounteraudit;

import org.openmrs.BaseOpenmrsData;

import java.io.Serializable;

/**
 * Created by cosmin on 6/18/14.
 */
public class EncounterAuditParameter extends BaseOpenmrsData implements Serializable {

    private Integer parameterId;
    private String name;
    private String className;
    private String defaultValue;

    @Override
    public Integer getId() {
        return parameterId;
    }

    @Override
    public void setId(Integer id) {
        this.parameterId = id;
    }

    public Integer getParameterId() {
        return parameterId;
    }

    public void setParameterId(Integer parameterId) {
        this.parameterId = parameterId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }
}
