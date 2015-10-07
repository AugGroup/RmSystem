package com.aug.controllers;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aug.hrdb.entities.Applicant;
import com.aug.hrdb.entities.Appointment;
import com.aug.hrdb.entities.Employee;
import com.aug.hrdb.entities.Login;
import com.aug.hrdb.entities.MailTemplate;
import com.aug.hrdb.services.ApplicantService;
import com.aug.hrdb.services.AppointmentService;
import com.aug.hrdb.services.EmployeeService;
import com.aug.hrdb.services.LoginService;
import com.aug.hrdb.services.MailTemplateService;
import com.aug.services.EmailService;

import groovy.lang.MetaClassImpl.Index;

@Controller
public class EmailController {
	
	@Autowired
	private MailTemplateService mailTemplateService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private AppointmentService appointmentService;
	
	@Autowired
	private ApplicantService applicantService;
		
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private EmployeeService employeeService;
	
	@ModelAttribute(value="applicants")
	public List<Applicant> getApplicants() {
		return applicantService.findAll();
	}
	
	@ModelAttribute(value="mailTemplate")
	public List<MailTemplate> getListDepartment(){		
		return mailTemplateService.findAll();
	}
	
	@RequestMapping(value="/email/create", method={RequestMethod.GET})
	public String createEmail(){ 
		return "email-create";
	}
	
	@RequestMapping(value="/email/create", method={RequestMethod.POST})
	public @ResponseBody String setTemplate(@RequestBody MailTemplate mailTemplate) throws UnsupportedEncodingException{
		try {
			
	        //encoding template
			mailTemplate.setTemplate(new String(mailTemplate.getTemplate().getBytes("UTF-8"),"UTF-8"));
			
	        //console input
			System.out.println("templateName : " + mailTemplate.getName());
			System.out.println("finalTemplate : " + mailTemplate.getTemplate());
			
			//
			List<MailTemplate> mailTemplates = mailTemplateService.findAll();
			
			for(MailTemplate m : mailTemplates){
				if(null == m.getName()|| m.getName().equalsIgnoreCase(mailTemplate.getName())){
					return "error";
				}
			}
			
			mailTemplateService.create(mailTemplate);
			
		} catch (Exception exception) {
			
			exception.printStackTrace();
			System.out.println(exception.toString());
			
		}
		
		return "success";
	}
	
	@RequestMapping(value="/email/write", method={RequestMethod.GET})
	public String writeEmail() {
		return "email-write";
	}
	
	@RequestMapping(value="/email/write/appointment/{appointmentId}", method={RequestMethod.GET})
	public ModelAndView writeAppointmentMail(@PathVariable(value="appointmentId") Integer appointmentId) {
		
		Appointment appointment = appointmentService.find(appointmentId);
		Applicant applicant = appointment.getApplicant();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("email-appointment");
		modelAndView.addObject("email", applicant.getEmail());
		modelAndView.addObject("appointmentId", appointmentId);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/email/send/appointment", method={RequestMethod.POST})
	public @ResponseBody String sendAppointmentMail(@RequestParam(value="appointmentId") Integer appointmentId, @RequestParam(value="cc") String cc,
			@RequestParam(value="subject") String subject, @RequestParam(value="content") String content, HttpServletRequest request) throws UnsupportedEncodingException{
		
		try {
			//find employee
			UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			System.out.println("userName : " + userDetails.getUsername());
			Login login = loginService.findByUserName(userDetails.getUsername());
			Employee employee = login.getEmployee();
			Applicant sender = employee.getApplicant();
			System.out.println("sender: " + sender.getFirstNameEN());
			
			//find appointment
			Appointment appointment = appointmentService.find(appointmentId);
			System.out.println("appointment: " + appointment.getDetail());
			
			//find applicant
			Applicant receiver = appointment.getApplicant();
			System.out.println("applicant: " + receiver.getFirstNameEN());
			
			//find template
//			MailTemplate mailTemplate = mailTemplateService.findByName(templateName);
//			System.out.println("mailTemplate: " + mailTemplate.getName());
			
			emailService.sendAppointmentMail(sender, receiver, appointment, cc, subject, content, request);
		} catch(Exception exception) {
			exception.printStackTrace();
			System.out.println(exception);
		}
		
		return "redirect:/calendar"; 
	}
	
	
	@RequestMapping(value="/email/send", method={RequestMethod.POST})
	public @ResponseBody String sendMail(@RequestParam(value="receiver") String receiver, @RequestParam(value="cc") String cc,
			@RequestParam(value="subject") String subject, @RequestParam(value="content") String content, HttpServletRequest request) throws UnsupportedEncodingException{
		
		String status = "fail";
		try {
			//send mail
			emailService.sendEmail(receiver, cc, subject, content, request);
			
			//set status
			status = "success";
			
		} catch(Exception exception) {
			exception.printStackTrace();
			System.out.println(exception);
		}
				
		return status; 
	}
	
	@RequestMapping(value="/email/find/waitAppointment", method={RequestMethod.GET})
	public @ResponseBody List<Appointment> findWaitAppointment(){
		
		List<Appointment> appointments = appointmentService.findAll();
		List<Appointment> result = new ArrayList<Appointment>();
		
		for (Appointment appointment : appointments) {
			if (appointment.getMailStatus() == 0) {
				result.add(appointment);
			}
		}
		
		if (result.isEmpty()) {
			return null;
		}
		
		return result;
	}
	
	@RequestMapping(value="/email/find/updateAppointment", method={RequestMethod.GET})
	public @ResponseBody List<Appointment> findUpdateAppointment(){
		
		List<Appointment> appointments = appointmentService.findAll();
		List<Appointment> result = new ArrayList<Appointment>();
		
		for (Appointment appointment : appointments) {
			if (appointment.getMailStatus() == 2) {
				result.add(appointment);
			}
		}
		
		if (result.isEmpty()) {
			return null;
		}
		return result;
	}
	
	@RequestMapping(value="/email/findTemplate/{id}", method={RequestMethod.GET})
	public @ResponseBody MailTemplate findTemplate(@PathVariable(value="id") Integer id) {
		return mailTemplateService.findById(id);
	}

	@RequestMapping(value="/email/edit", method={RequestMethod.GET})
	public String editEmail(){ 
		return "email-edit";
	}
	
	@RequestMapping(value="/email/edit/update", method={RequestMethod.POST})
	public @ResponseBody void updateDbEmail(@RequestBody MailTemplate mailTemplate){ 
		mailTemplateService.update(mailTemplate);
	}
	
	@RequestMapping(value="/email/edit/update/{id}", method={RequestMethod.GET},produces = "text/plain;charset=UTF-8")
	public @ResponseBody String editEmailId(@PathVariable Integer id){ 
		return mailTemplateService.findById(id).getTemplate();
	}
	
	@RequestMapping(value="/email/edit/delete/{id}", method={RequestMethod.GET})
	public @ResponseBody void deleteEmail(@PathVariable Integer id){ 
		mailTemplateService.deleteById(id);
	}
}
