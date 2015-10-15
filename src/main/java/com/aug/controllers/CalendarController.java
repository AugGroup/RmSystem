package com.aug.controllers;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aug.hrdb.dto.ApplicantDto;
import com.aug.hrdb.dto.AppointmentDto;
import com.aug.hrdb.entities.Appointment;
import com.aug.hrdb.entities.Login;
import com.aug.hrdb.services.ApplicantService;
import com.aug.hrdb.services.AppointmentService;
import com.aug.hrdb.services.LoginService;

@Controller
public class CalendarController {
	
	@Autowired
	private AppointmentService appointmentService;
	
	@Autowired
	private ApplicantService applicantService;
	
	@Autowired
	private LoginService loginService;
	
	///////////////////////////////// CALENDAR PAGE ///////////////////////////////// 
	
	@RequestMapping(value = "calendar",method = RequestMethod.GET)
	public ModelAndView getCalendar(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("calendar");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "calendar/insertAppointment/{id}",method = RequestMethod.POST)
	public @ResponseBody AppointmentDto insertAppointment(@RequestBody Appointment appointment,@PathVariable Integer id) {
		
		/*                                  Get Who's Appoint                                  */		
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//System.out.println("userName : " + userDetails.getUsername());
		Login login = loginService.findByUserName(userDetails.getUsername());
		appointment.setLogin(login);//set login Id
		
		/*                Change time for insert                      */
		Date dateStart = appointment.getStart();//get date from appointment
		Date dateEnd = appointment.getEnd();
		
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
		formatter.setTimeZone(TimeZone.getTimeZone("GMT"));//set Timezone to be GMT
		
		String startString = formatter.format(dateStart);//convert date's timezone but it return String
		String endString = formatter.format(dateEnd);
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);//new format to convert String to Date
		try {
			//System.out.println(format.parse(startString));
			appointment.setStart(format.parse(startString));//set date with new timezone 
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			//System.out.println(format.parse(endString));
			appointment.setEnd(format.parse(endString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		appointment.setApplicant(applicantService.findById(id));
		appointmentService.create(appointment);
		//System.out.println(appointment.getApplicant().getId());
		return appointmentService.findById(appointment.getId());
	}
	
	

	@RequestMapping(value = "calendar/getAppointment/{id}",method = RequestMethod.GET)
	public @ResponseBody AppointmentDto getAppointmentData(@PathVariable Integer id) {
		AppointmentDto apmDto = appointmentService.findById(id);
		return apmDto;
		
	}
	
	@RequestMapping(value = "calendar/update",method = RequestMethod.POST)
	public @ResponseBody AppointmentDto updateAppointment(@RequestBody Appointment appointment) throws ParseException{
		Appointment appointmentToUpdate = appointmentService.find(appointment.getId());
		if(appointment.getMailStatus()==0){
			appointmentToUpdate.setMailStatus(0);
		}else {
			appointmentToUpdate.setMailStatus(2);
		}
		/*                Change time for insert                      */
		Date dateStart = appointment.getStart();//get date from appointment
		Date dateEnd = appointment.getEnd();
		
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
		formatter.setTimeZone(TimeZone.getTimeZone("GMT"));//set Timezone to be GMT
		
		String startString = formatter.format(dateStart);//convert date's timezone but it return String
		String endString = formatter.format(dateEnd);
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);//new format to convert String to Date
		try {
			//System.out.println(format.parse(startString));
			appointmentToUpdate.setStart(format.parse(startString));//set date with new timezone 
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			//System.out.println(format.parse(endString));
			appointmentToUpdate.setEnd(format.parse(endString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		appointmentService.update(appointmentToUpdate);
		return appointmentService.findById(appointmentToUpdate.getId());
	}
	
	@RequestMapping(value = "calendar/updateTopicAndDetail",method = RequestMethod.POST)
	public @ResponseBody AppointmentDto updateTopicAndDetail(@RequestBody Appointment appointment) {
		Appointment appointmentUpdate = appointmentService.find(appointment.getId());
		appointmentUpdate.setTopic(appointment.getTopic());
		appointmentUpdate.setDetail(appointment.getDetail());
		appointmentService.update(appointmentUpdate);
		return appointmentService.findById(appointmentUpdate.getId());
	}
	
	
	
	@RequestMapping(value = "calendar/findAppointment",method = RequestMethod.GET)
		public @ResponseBody List<AppointmentDto> findAppointment(@RequestParam(value="start") String start,
		@RequestParam(value="end") String end, @RequestParam(value="_",required = false) String underscore, 
		@RequestParam(value="timezone",required = false) String timezone, @RequestParam Integer mailStatus) throws ParseException {
		List<AppointmentDto> list = appointmentService.findAppointment(start, end, mailStatus);
		if (list.size()==0) {
			return null;
		}else {
			return list;
		}
		
	}
	
	@RequestMapping(value = "calendar/findByTrackingStatus/{trackingStatus}", method = RequestMethod.GET)
	public @ResponseBody List<ApplicantDto> findByTrackingStatus(@PathVariable String trackingStatus){
		
		if (trackingStatus.equals("test")) {
			return applicantService.findByTrackingStatus("Pending Test/Interview");
		}
		else if (trackingStatus.equals("pendingapprove")){
			return  applicantService.findByTrackingStatus("Pending Approve");
		}
		else if (trackingStatus.equals("all")) {
			return applicantService.findAllApplicant();
		}
		
		return null;
	}
	
	@RequestMapping(value = "calendar/deleteAppointment/{id}", method = RequestMethod.GET)
	public @ResponseBody String findAllApplicant(@PathVariable Integer id) {
		AppointmentDto appointment ;
		String returnTitle ;
		try{
			appointment = appointmentService.findById(id);
			returnTitle = appointment.getTitle();
		}catch(Exception e){
			return e.getMessage();
		}
		appointmentService.deleteById(id);
	return returnTitle;
	}
	
	@RequestMapping(value = "calendar/countMailStatus/{status}", method = RequestMethod.GET)
	public @ResponseBody String countMailStatus(@PathVariable Integer status) {
		return appointmentService.countMailStatus(status)+"";
	}
	
	@RequestMapping(value = "calendar/findByApplicantId/{applId}", method = RequestMethod.POST)
	public @ResponseBody List<Appointment> findByApplicantId(@PathVariable Integer applId) {
		List<Appointment> appointments = appointmentService.findByApplicant(applicantService.findById(applId));
		//System.out.println(appointments.toString());
		return appointments;
	}
	
	////////////////////////////////////////////////////////////////////////////////
}
