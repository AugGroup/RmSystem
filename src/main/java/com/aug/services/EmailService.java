package com.aug.services;

import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;

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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aug.hrdb.entities.Applicant;
import com.aug.hrdb.entities.Appointment;
import com.aug.hrdb.entities.Employee;
import com.aug.hrdb.entities.MailTemplate;

@Service(value="emailService")
public class EmailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private VelocityEngine velocityEngine;
	
	public @ResponseBody String sendAppointmentMail(Employee employee, Appointment appointment, 
			Applicant applicant, MailTemplate mailTemplate, HttpServletRequest request) throws UnsupportedEncodingException {

		//date format
		SimpleDateFormat formatDate = new SimpleDateFormat("dd MMM yyyy");
		
		//time format
		SimpleDateFormat formatTime = new SimpleDateFormat("KK:mm aa");

		////create mail
		velocityEngine.init();
		StringWriter writer = new StringWriter();
		
		//define variable in mail template
		Context context = new VelocityContext();
		context.put("FIRST_NAME", applicant.getFirstNameEN());
		context.put("DATE", formatDate.format(appointment.getStart()));
		context.put("TIME", formatTime.format(appointment.getStart()));
		context.put("RECRUIT_FIRST_NAME", employee.getNameEng());
		context.put("RECRUIT_LAST_NAME", employee.getSurnameEng());
		context.put("RECRUIT_POSITION", employee.getMasJoblevel().getName());
		context.put("RECRUIT_PHONE", employee.getTelMobile());
		
		//set email attr
		final String recipientAddress = "anat.pantera@gmail.com";
		final String subject = appointment.getTopic();
		final String path = request.getSession().getServletContext().getRealPath("/") + "/resources/mail-attachment/";
		
		//merge context and writer to String 
		velocityEngine.evaluate(context, writer, "Email", mailTemplate.getTemplate()); 
		
		//encode Template
		final String encode = new String(writer.toString().getBytes("UTF-8"),"UTF-8");
		
		//create mime message
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
		  public void prepare(MimeMessage mimeMessage) throws Exception {
		          
		        MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		          message.setTo(recipientAddress);
		          message.setSubject(subject);
		          
		          FileSystemResource map = new FileSystemResource(path + "map.jpg");
		          message.addAttachment(map.getFilename(), map);
		          
		          message.setText(encode, true);
		  }
		};
		
		//send email
		mailSender.send(preparator);
		
		return "emailService";
	}
}

