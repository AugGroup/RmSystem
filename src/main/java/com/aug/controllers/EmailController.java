package com.aug.controllers;

import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.context.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aug.hrdb.entities.MailTemplate;
import com.aug.hrdb.services.MailTemplateService;

@Controller
public class EmailController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private VelocityEngine velocityEngine;
	
	@Autowired
	private MailTemplateService mailTemplateService;
	
	@RequestMapping(value="/email/create", method={RequestMethod.GET})
	public String createEmail(){ 
		return "email-create";
	}
	
	@RequestMapping(value="/email/send", method={RequestMethod.GET})
	public String sendEmail(Model model) throws UnsupportedEncodingException {
		
		String firstName = "Anat";
	    String date = "15 June 2015";
	    String time = "9.30 AM.";
	    String recruitName = "Achiraya Janjiratavorn";
	    String recruitPosition = "Recruitment Professional";
	    String recruitPhone = "66 8 4751 6665";
	    
	    final String recipientAddress = "anat.pantera@gmail.com";
        final String subject = "test ckeditor mail template in db";
        //final String path = request.getSession().getServletContext().getRealPath("/") + "/mail-attachment/";
        
        //create mail
        velocityEngine.init();
        StringWriter writer = new StringWriter();
        
        //define variable in mail template
        Context context = new VelocityContext();
        context.put("firstName", firstName);
        context.put("date", date);
        context.put("time", time);
        context.put("recruitName", recruitName);
        context.put("recruitPosition", recruitPosition);
        context.put("recruitPhone", recruitPhone);
        
        MailTemplate mailTemplate = mailTemplateService.findById(2);
        //String encodeTemplate = new String(mailTemplate.getTemplate().getBytes("UTF-8"),"UTF-8");
        
        model.addAttribute("text",mailTemplate.getTemplate());
        
        //merge context and writer to String 
        velocityEngine.evaluate(context, writer, "SimpleVelocity", mailTemplate.getTemplate()); 
        
        
        String mailHeader = "<!DOCTYPE html><html><head><meta charset='UTF-8'></head>";
         
        //define finalTemplate
        String finalTemplate = mailHeader + "<body>" + writer.toString() + "</body></html>";
        
        final String encode = new String(finalTemplate.getBytes("UTF-8"),"UTF-8");
	        //create mime message
	    MimeMessagePreparator preparator = new MimeMessagePreparator() {
	      public void prepare(MimeMessage mimeMessage) throws Exception {
	              
	            MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	              message.setTo(recipientAddress);
	              message.setSubject(subject);
	              
//	              FileSystemResource logo = new FileSystemResource(path + "logo.png");
//	              message.addAttachment(logo.getFilename(), logo);
//	              
//	              FileSystemResource map = new FileSystemResource(path + "map.jpg");
//	              message.addAttachment(map.getFilename(), map);
	              
	              message.setText(encode, true);
	      }
	    };
	    
	    //send email
        mailSender.send(preparator);
    
        System.out.println("templateName : " + mailTemplate.getName());
        System.out.println("finalTemplate : " + mailTemplate.getTemplate());
    
        return "email-create";
	}
	
	@RequestMapping(value="/email/setTemplate", method={RequestMethod.POST})
	public @ResponseBody String setTemplate(final HttpServletRequest request, 
			@RequestParam(value="template") String template, 
			@RequestParam(value="name") String name) throws UnsupportedEncodingException{
        		
        //create template
        velocityEngine.init();
        StringWriter writer = new StringWriter();
        //define variable in mail template
        Context context = new VelocityContext();
        velocityEngine.evaluate(context, writer, name, template); 
        
        String mailHeader = "<!DOCTYPE html><html><head><meta charset='UTF-8'></head>";
         
        //define finalTemplate
        String finalTemplate = mailHeader + "<body>" + writer.toString() + "</body></html>";
        
        //encoding
        final String encode = new String(finalTemplate.getBytes("UTF-8"),"UTF-8");

        //add template to db
        MailTemplate mailTemplate = new MailTemplate();
		mailTemplate.setName(name);
		mailTemplate.setTemplate(encode);
		
        //console input
		System.out.println("templateName : " + name);
		System.out.println("finalTemplate : " + encode);
		
		mailTemplateService.create(mailTemplate);
		
		return template;
	}
	

	@RequestMapping(value="/email/edit", method={RequestMethod.GET})
	public String editEmail(){ 
		return "email-edit";
	}
	
	@RequestMapping(value="/email/edit/update", method={RequestMethod.POST})
	public void updateDbEmail(@RequestBody MailTemplate mailTemplate){ 
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