package com.aug.controllers;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aug.hrdb.dto.ApplicantDto;
import com.aug.hrdb.entities.Appointment;
import com.aug.hrdb.services.ApplicantService;
import com.aug.hrdb.services.AppointmentService;

@Controller
public class CalendarController {
	
	@Autowired
	private AppointmentService appointmentService;
	
	@Autowired
	private ApplicantService applicantService;
	
	
	///////////////////////////////// CALENDAR PAGE ///////////////////////////////// 
	
	@RequestMapping(value = "calendar",method = RequestMethod.GET)
	public ModelAndView getCalendar(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("calendar");
		
		/*Date date = new Date();
		DateFormat formatter = new SimpleDateFormat("dd MMM yyyy HH:mm:ss z");
		formatter.setTimeZone(TimeZone.getTimeZone("GMT"));
		System.out.println(formatter.format(date));
		
		*/
		
		return modelAndView;
	}
	
	@RequestMapping(value = "calendar/insertAppointment",method = RequestMethod.POST)
	public @ResponseBody Appointment insertAppointment(@RequestBody Appointment appointment) {
		System.out.println(appointment);
		
		Date dateStart = appointment.getStart();//get date from appointment
		Date dateEnd = appointment.getEnd();
		
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
		formatter.setTimeZone(TimeZone.getTimeZone("GMT"));//set Timezone to be GMT
		
		
		
		String startString = formatter.format(dateStart);//convert date's timezone but it return String
		String endString = formatter.format(dateEnd);
		
		System.out.println(startString);
		System.out.println(endString);
		
//		appointment.setStart(formatter.format(dateStart));
//		appointment.setEnd(formatter.format(dateEnd));
		
		//String string = "January 2, 2010";
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);//new format to convert String to Date
		try {
			System.out.println(format.parse(startString));
			appointment.setStart(format.parse(startString));//set date with new timezone 
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			System.out.println(format.parse(endString));
			appointment.setEnd(format.parse(endString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		appointmentService.create(appointment);
		return appointment;
	}
	
	

	@RequestMapping(value = "calendar/getAppointment/{id}",method = RequestMethod.GET)
	public @ResponseBody Appointment getAppointmentData(@PathVariable Integer id) {
		//appointmentService.create(appointment);
		System.out.println(id);
		return appointmentService.findById(id);
		
	}
	


	@RequestMapping(value = "findAllAppointment", method = RequestMethod.GET)
		public @ResponseBody List<Appointment> findAllAppointment() {
		return appointmentService.findAll();
	}
	
	
	@RequestMapping(value = "findByTrackingStatus/{trackingStatus}", method = RequestMethod.GET)
	public @ResponseBody List<ApplicantDto> findByTrackingStatus(@PathVariable String trackingStatus){
		
		if (trackingStatus.equals("test")) {
			return applicantService.findByTrackingStatus("Pending Test/Interview");
		}
		if (trackingStatus.equals("pendingapprove")){
			return  applicantService.findByTrackingStatus("Pending Approve");
		}
		if (trackingStatus.equals("all")) {
			return applicantService.findAllApplicant();
		}
		
		return null;
	}
	
	////////////////////////////////////////////////////////////////////////////////
}
