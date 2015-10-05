package com.aug.controllers;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;







import javax.servlet.http.HttpServletRequest;

import org.h2.mvstore.db.TransactionStore.Change;
import org.hibernate.validator.util.privilegedactions.GetAnnotationParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;


import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.aug.hrdb.entities.Employee;
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
	
	@RequestMapping(value = "calendar/insertAppointment",method = RequestMethod.POST)
	public @ResponseBody AppointmentDto insertAppointment(@RequestBody Appointment apmDto) {
		
		/*                                  Get Who's Appoint                                  */		
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("userName : " + userDetails.getUsername());
		Login login = loginService.findByUserName(userDetails.getUsername());
		apmDto.setLogin(login);//set login Id
		
		/*                Change time for insert                      */
		System.out.println(apmDto);
		Date dateStart = apmDto.getStart();//get date from appointment
		Date dateEnd = apmDto.getEnd();
		
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.ENGLISH);
		formatter.setTimeZone(TimeZone.getTimeZone("GMT"));//set Timezone to be GMT
		
		String startString = formatter.format(dateStart);//convert date's timezone but it return String
		String endString = formatter.format(dateEnd);
		
		System.out.println(startString);
		System.out.println(endString);
		
		//String string = "January 2, 2010";
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);//new format to convert String to Date
		try {
			System.out.println(format.parse(startString));
			apmDto.setStart(format.parse(startString));//set date with new timezone 
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			System.out.println(format.parse(endString));
			apmDto.setEnd(format.parse(endString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		appointmentService.create(apmDto);
		return appointmentService.findById(apmDto.getId());
	}
	
	

	@RequestMapping(value = "calendar/getAppointment/{id}",method = RequestMethod.GET)
	public @ResponseBody AppointmentDto getAppointmentData(@PathVariable Integer id) {
		AppointmentDto apmDto = appointmentService.findById(id);
		return apmDto;
		
	}
	
	@RequestMapping(value = "calendar/update",method = RequestMethod.POST)
	public @ResponseBody AppointmentDto updateAppointment(@RequestBody Appointment appointment){
//		AppointmentDto updateAppointment = appointmentService.findById(appointment.getId());
//		if ( updateAppointment == null){
//			// System.out.println(updateAppointment);
//			return null;
//			
//		} else {
//		AppointmentDto findAppointment	= appointmentService.findById(appointment.getId());
//			appointment.setApplicant(applicantService.findById(findAppointment.getApplicantId()));
//			appointmentService.update(appointment);
//			return updateAppointment;
//		}
		appointmentService.update(appointment);
		
		return appointmentService.findById(appointment.getId());
	}
	
	
	@RequestMapping(value = "calendar/findAppointment",method = RequestMethod.GET)
		public @ResponseBody List<AppointmentDto> findAppointment(@RequestParam(value="start") String start,
		@RequestParam(value="end") String end, @RequestParam(value="_",required = false) String underscore, 
		@RequestParam(value="timezone",required = false) String timezone) throws ParseException {
		
		List<AppointmentDto> list = appointmentService.findAppointment(start, end);
		//System.out.println("test: " + list.get(0).getStart());
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
		appointmentService.deleteById(id);
	return "success";
	}
	
	////////////////////////////////////////////////////////////////////////////////
}
