package com.aug.controllers;

import java.io.Reader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.context.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
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
import com.aug.hrdb.services.LoginService;
import com.aug.hrdb.services.MailTemplateService;
import com.aug.services.EmailService;

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
	
	@Transactional
	@RequestMapping(value="/email/send/{email}", method={RequestMethod.GET})
	public String sendAppointmentMail(@RequestParam(value="appointmentId",defaultValue="1") Integer appointmentId,
			@RequestParam(value="templateName",defaultValue="java") String templateName ,HttpServletRequest request,@PathVariable String email) throws UnsupportedEncodingException{
		
		//find employee
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("userName : " + userDetails.getUsername());
		Login login = loginService.findByUserName(userDetails.getUsername());
		Employee employee = login.getEmployee();
		System.out.println("employee: " + employee.getNameEng());
		
		//find appointment
		Appointment appointment = appointmentService.find(appointmentId);
		System.out.println("appointment: " + appointment.getDetail());
		
		//find applicant
		Applicant applicant = appointment.getApplicant();
		System.out.println("applicant: " + applicant.getFirstNameEN());
		
		//find template
		MailTemplate mailTemplate = mailTemplateService.findByName(templateName);
		System.out.println("mailTemplate: " + mailTemplate.getName());
		
		emailService.sendAppointmentMail(employee, appointment, applicant, mailTemplate, request,email+".com");
		
		return "redirect:/email/create"; 
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
	
	@ModelAttribute("mailTemplate")
	public List<MailTemplate> getListDepartment(){		
		return mailTemplateService.findAll();
	}
}
