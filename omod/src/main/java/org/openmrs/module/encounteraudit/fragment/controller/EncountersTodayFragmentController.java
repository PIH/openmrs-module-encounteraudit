package org.openmrs.module.encounteraudit.fragment.controller;

import ca.uhn.hl7v2.model.v23.segment.LOC;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.api.EncounterService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.springframework.web.bind.annotation.RequestParam;
import sun.util.logging.resources.logging_zh_CN;

import javax.xml.stream.Location;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

public class EncountersTodayFragmentController {

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
                           @FragmentParam(value="location", required=false) org.openmrs.Location Location,
                           @RequestParam(value="encountertype", required=false) Collection<EncounterType> encounterType,
                           @FragmentParam(value="end", required=false) Date endDate) {

        if (startDate == null)
            startDate = defaultStartDate();
        if (endDate == null)
            endDate = defaultEndDate(startDate);

        model.addAttribute("fromDate", startDate);
        model.addAttribute("toDate", endDate);
        model.addAttribute("loc", Location);
        model.addAttribute("encounterTypes", encounterType);

        model.addAttribute("encounters", service.getEncounters(null, (org.openmrs.Location) Location, startDate, endDate, null, encounterType, null, false));
    }

    public List<SimpleObject> getEncounters(@RequestParam(value="start", required=false) Date startDate,
                                            @RequestParam(value="end", required=false) Date endDate,
                                            @RequestParam(value="location", required=false) org.openmrs.Location Location,
                                            @RequestParam(value="encountertype", required=false) Collection<EncounterType> encounterType,
                                            @RequestParam(value="properties", required=false) String[] properties,
                                            @SpringBean("encounterService") EncounterService service,
                                            UiUtils ui) {

        if (startDate == null)
            startDate = defaultStartDate();
        if (endDate == null)
            endDate = defaultEndDate(startDate);
        if (properties == null || properties.length == 0) {
            properties = new String[] { "encounterType", "encounterDatetime", "location", "provider" };
        }

        List<Encounter> encs = service.getEncounters(null, Location, startDate, endDate, null, encounterType, null, false);
        return SimpleObject.fromCollection(encs, ui, properties);
    }

}