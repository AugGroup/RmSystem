package com.aug.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aug.hrdb.entities.Appointment;
import com.aug.hrdb.services.AppointmentService;

@Controller
public class CalendarController {
	
	@Autowired
	private AppointmentService appointmentService;
	///////////////////////////////// CALENDAR PAGE ///////////////////////////////// 
		
	@RequestMapping(value = "calendar",method = RequestMethod.GET)
	public ModelAndView getCalendar(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("calendar");
		return modelAndView;
	}
	
	@RequestMapping(value = "calendar/insertAppointment")
	public String insertAppointment() {
		return "success";
	}
	
	
	
	
	@RequestMapping(value = "findAllAppointment", method = RequestMethod.GET)
		public @ResponseBody List<Appointment> findAllApplicant() {
		return appointmentService.findAll();
	}
	
	////////////////////////////////////////////////////////////////////////////////
}
