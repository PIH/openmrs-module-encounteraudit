package org.openmrs.module.encounteraudit.fragment.controller;


import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.*;
import org.openmrs.api.EncounterService;
import org.openmrs.module.encounteraudit.EncounterAudit;
import org.openmrs.module.encounteraudit.EncounterAuditParameter;
import org.openmrs.module.encounteraudit.EncounterAuditProject;
import org.openmrs.module.encounteraudit.EncounterAuditProjectParameter;
import org.openmrs.module.encounteraudit.api.EncounterAuditService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.ui.framework.fragment.action.FragmentActionResult;
import org.openmrs.ui.framework.fragment.action.SuccessResult;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

public class EncounterLayoutFragmentController {
    protected final Log log = LogFactory.getLog(getClass());

    private Date defaultStartDate() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    private Date defaultEndDate(Date startDate) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(startDate);
        cal.add(Calendar.DAY_OF_MONTH, 1);
        cal.add(Calendar.MILLISECOND, -1);
        return cal.getTime();
    }

    public void controller(FragmentModel model,
                           @SpringBean("encounterService") EncounterService service,
                           @SpringBean("encounterAuditService") EncounterAuditService auditService,
                           @FragmentParam(value="start", required=false) Date startDate,
                           @FragmentParam(value="location", required=false) Location Location,
                           @RequestParam(value="encountertype", required=false) Collection<EncounterType> encounterType,
                           @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
                           @RequestParam(value="creatorId", required=false) String creatorId,
                           @FragmentParam(value="end", required=false) Date endDate) {

        if (startDate == null)
            startDate = defaultStartDate();
        if (endDate == null)
            endDate = defaultEndDate(startDate);

        model.addAttribute("fromDate", startDate);
        model.addAttribute("toDate", endDate);
        model.addAttribute("loc", Location);
        model.addAttribute("encounterTypes", encounterType);
        model.addAttribute("numOfRecords", numOfRecords);
        model.addAttribute("creatorId", creatorId);

        List<EncounterAuditProject> projects = auditService.getAuditProjects();
        for (EncounterAuditProject project : projects) {
            Set<EncounterAuditProjectParameter> projectParameters = project.getProjectParameters();
            for (EncounterAuditProjectParameter projectParameter : projectParameters) {
                log.debug("parameterName = " + projectParameter.getParameter().getName());
                log.debug("parameterClassName = " + projectParameter.getParameter().getClassName());
                log.debug("parameterValue = " + projectParameter.getParameterValue());
            }
        }
        model.addAttribute("projects",projects);

        List<EncounterAuditParameter> projectParameters = auditService.getAuditProjectParameters();
        for (EncounterAuditParameter projectParameter : projectParameters) {
            log.debug("parameterName = " + projectParameter.getName());
            log.debug("parameterClassName = " + projectParameter.getClassName());

        }
        model.addAttribute("projectParameters",projectParameters);


        model.addAttribute("encounters", service.getEncounters(null, (org.openmrs.Location) Location, startDate, endDate, null, encounterType, null, false));
    }

    public List<SimpleObject> getEncounters(@RequestParam(value="start", required=false) Date startDate,
                                            @RequestParam(value="end", required=false) Date endDate,
                                            @RequestParam(value="location", required=false) Location location,
                                            @RequestParam(value="encountertype", required=false) EncounterType encounterType,
                                            @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
                                            @RequestParam(value="creatorId", required=false) String creatorId,
                                            @RequestParam(value="properties", required=false) String[] properties,
                                            @SpringBean("encounterAuditService") EncounterAuditService service,
                                            UiUtils ui) {

        if (startDate == null)
            startDate = defaultStartDate();
        if (endDate == null)
            endDate = defaultEndDate(startDate);
        if (properties == null || properties.length == 0) {
            properties = new String[] { "encounterType", "encounterDatetime", "location", "provider" };
        }
        List<EncounterType> encounterTypes = null;
        if (encounterType != null) {
            encounterTypes = (new ArrayList<EncounterType>(Collections.singletonList(encounterType)));
        }


        List<Encounter> encs = service.getAuditEncounters(startDate, endDate, numOfRecords, location, encounterType, creatorId);
        return SimpleObject.fromCollection(encs, ui, properties);
    }

    public FragmentActionResult updateProject(@SpringBean("encounterAuditService") EncounterAuditService service,
                                              @RequestParam("projectId") EncounterAuditProject project,
                                              @RequestParam("projectName") String name,
                                              @RequestParam("locationId") Location location,
                                              UiUtils uiUtils) {
        String projectName = name;

        return new SuccessResult();
    }

    public List<SimpleObject> getAuditEncounters(
                                            @RequestParam(value="projectId", required = false) String projectId,
                                            @RequestParam(value="projectName", required = false) String name,
                                            @RequestParam(value="projectDescription", required = false) String projectDescription,
                                            @RequestParam(value="start", required=false) Date startDate,
                                            @RequestParam(value="end", required=false) Date endDate,
                                            @RequestParam(value="location", required=false) Location location,
                                            @RequestParam(value="encountertype", required=false) EncounterType encounterType,
                                            @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
                                            @RequestParam(value="creatorId", required=false) String creatorId,
                                            @RequestParam(value="properties", required=false) String[] properties,
                                            @SpringBean("encounterAuditService") EncounterAuditService service,
                                            UiUtils ui) {

        if (startDate == null)
            startDate = defaultStartDate();
        if (endDate == null)
            endDate = defaultEndDate(startDate);
        if (numOfRecords == null)
            numOfRecords =  25;
        if (properties == null || properties.length == 0) {
            properties = new String[] { "encounterId", "patientId", "encounterType", "encounterDatetime", "location", "provider", "form", "creator"};
        }
        List<EncounterType> encounterTypes = null;
        if (encounterType != null) {
            encounterTypes = (new ArrayList<EncounterType>(Collections.singletonList(encounterType)));
        }

        EncounterAuditProject encounterAuditProject = null;
        if (StringUtils.isNotBlank(projectId)) {
            encounterAuditProject = service.getAuditProjectById(new Integer(projectId));
        }
        if (encounterAuditProject == null) {
            encounterAuditProject = new EncounterAuditProject();
        }

        if (StringUtils.isNotBlank(name)) {
            encounterAuditProject.setName(name);
        }
        if (StringUtils.isNotBlank(projectDescription)) {
            encounterAuditProject.setDescription(projectDescription);
        }
        encounterAuditProject.setProjectType(EncounterAuditProject.EncounterAuditProjectType.LQAS);
        encounterAuditProject.setProjectStatus(EncounterAuditProject.EncounterAuditProjectStatus.INCOMPLETE);

        EncounterAuditProjectParameter startDateProjectParameter = new EncounterAuditProjectParameter();
        EncounterAuditParameter startDateParameter = service.getParameterByName("start_date");
        startDateProjectParameter.setParameter(startDateParameter);
        startDateProjectParameter.setParameterValue(startDate.toString());
        encounterAuditProject.addProjectParameter(startDateProjectParameter);

        EncounterAuditProjectParameter endDateProjectParameter = new EncounterAuditProjectParameter();
        EncounterAuditParameter endDateParameter = service.getParameterByName("end_date");
        endDateProjectParameter.setParameter(endDateParameter);
        endDateProjectParameter.setParameterValue(endDate.toString());
        encounterAuditProject.addProjectParameter(endDateProjectParameter);

        if (location != null) {
            EncounterAuditProjectParameter locationProjectParameter = new EncounterAuditProjectParameter();
            EncounterAuditParameter locationParameter = service.getParameterByName("location");
            locationProjectParameter.setParameter(locationParameter);
            locationProjectParameter.setParameterValue(location.getName());
            encounterAuditProject.addProjectParameter(locationProjectParameter);
        }

        if (encounterType != null ) {
            EncounterAuditProjectParameter encounterTypeProjectParameter = new EncounterAuditProjectParameter();
            EncounterAuditParameter encounterTypeParameter = service.getParameterByName("encounter_type");
            encounterTypeProjectParameter.setParameter(encounterTypeParameter);
            encounterTypeProjectParameter.setParameterValue(encounterType.getName());
            encounterAuditProject.addProjectParameter(encounterTypeProjectParameter);
        }


        encounterAuditProject = service.saveEncounterAuditProject(encounterAuditProject);

        List<Encounter> encs = service.getAuditEncounters(startDate, endDate, numOfRecords, location, encounterType, creatorId);
        return simplify(ui, encs, properties);
    }

    List<SimpleObject> simplify(UiUtils ui,  List<Encounter> results, String[] properties) {
        List<SimpleObject> encounters = new ArrayList<SimpleObject>(results.size());
        for (Encounter encounter : results) {
            encounters.add(simplify(ui, encounter, properties));
        }
        return encounters;
    }

    SimpleObject simplify(UiUtils ui, Encounter encounter, String[] properties) {
//        Set<Obs> obs = encounter.getObs();

        SimpleObject o = SimpleObject.fromObject(encounter, ui, properties);
//        o.put("obs", SimpleObject.fromCollection(obs, ui, "id","valueNumeric", "valueAsString"));


        Form form = encounter.getForm();
        Integer formId = form.getFormId();
        o.put("formId", SimpleObject.fromObject(form, ui, "formId"));

        return o;
    }

}