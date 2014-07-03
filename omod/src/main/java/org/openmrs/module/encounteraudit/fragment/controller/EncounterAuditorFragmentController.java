package org.openmrs.module.encounteraudit.fragment.controller;


import org.openmrs.*;
import org.openmrs.api.EncounterService;
import org.openmrs.module.encounteraudit.api.EncounterAuditService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

public class EncounterAuditorFragmentController {

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
                           @FragmentParam(value="start", required=false) Date startDate,
                           @FragmentParam(value="location", required=false) Location Location,
                           @RequestParam(value="encountertype", required=false) Collection<EncounterType> encounterType,
                           @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
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

        model.addAttribute("encounters", service.getEncounters(null, (org.openmrs.Location) Location, startDate, endDate, null, encounterType, null, false));
    }

    public List<SimpleObject> getEncounters(@RequestParam(value="start", required=false) Date startDate,
                                            @RequestParam(value="end", required=false) Date endDate,
                                            @RequestParam(value="location", required=false) Location location,
                                            @RequestParam(value="encountertype", required=false) EncounterType encounterType,
                                            @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
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


        List<Encounter> encs = service.getAuditEncounters(startDate, endDate, numOfRecords, location, encounterType);
        return SimpleObject.fromCollection(encs, ui, properties);
    }

    public List<SimpleObject> getAuditEncounters(@RequestParam(value="start", required=false) Date startDate,
                                            @RequestParam(value="end", required=false) Date endDate,
                                            @RequestParam(value="location", required=false) Location location,
                                            @RequestParam(value="encountertype", required=false) EncounterType encounterType,
                                            @RequestParam(value="numofrecords", required=false) Integer numOfRecords,
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


        List<Encounter> encs = service.getAuditEncounters(startDate, endDate, numOfRecords, location, encounterType);
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
        Set<Obs> obs = encounter.getObs();

        SimpleObject o = SimpleObject.fromObject(encounter, ui, properties);
        o.put("obs", SimpleObject.fromCollection(obs, ui, "id","valueNumeric"));
        

        Form form = encounter.getForm();
        Integer formId = form.getFormId();
        o.put("formId", SimpleObject.fromObject(form, ui, "formId"));

        return o;
    }

}