package com.aug.controllers;

import java.io.StringWriter;
import java.io.UnsupportedEncodingException;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping(value="/email/setTemplate", method={RequestMethod.POST})
	public ModelAndView setTemplate(@RequestParam(value="template") String template, 
			@RequestParam(value="name") String name) throws UnsupportedEncodingException{
        	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("email-create");
		
		try {
			
	        //set template's header
	        String mailHeader = "<!DOCTYPE html><html><head><meta charset='UTF-8'></head>";
	         
	        //set finalTemplate
	        String finalTemplate = mailHeader + "<body>" + template + "</body></html>";
	        
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
			
			//set callback data
			modelAndView.addObject("sendStatus", true);
		} catch (Exception exception) {
			
			exception.printStackTrace();
			System.out.println(exception.toString());
			
		}
		
		return modelAndView;
	}
	
	@RequestMapping(value="/email/send", method={RequestMethod.GET})
	public String sendEmail(Model model, HttpServletRequest request, 
			@RequestParam(value="name",required=false) String name) throws UnsupportedEncodingException {
		
		String firstName = "Chalisa";
	    String date = "15 June 2015";
	    String time = "9.30 AM.";
	    String recruitFirstName = "Achiraya";
	    String recruitLastName = "Janjiratavorn";
	    String recruitPosition = "Recruitment Professional";
	    String recruitPhone = "66 8 4751 6665";
	    
	    final String recipientAddress = "bp_clash@hotmail.com";
        final String subject = "Test & Interview with Augmentis (Thailand) Limited (Java Consultant - New Grad)";
        final String path = request.getSession().getServletContext().getRealPath("/") + "/resources/mail-attachment/";
        
        //create mail
        velocityEngine.init();
        StringWriter writer = new StringWriter();
        
        //define variable in mail template
        Context context = new VelocityContext();
        context.put("FIRST_NAME", firstName);
        context.put("DATE", date);
        context.put("TIME", time);
        context.put("RECRUIT_FIRST_NAME", recruitFirstName);
        context.put("RECRUIT_LAST_NAME", recruitLastName);
        context.put("RECRUIT_POSITION", recruitPosition);
        context.put("RECRUIT_PHONE", recruitPhone);
        
        MailTemplate mailTemplate = mailTemplateService.findByName("table");
        //String encodeTemplate = new String(mailTemplate.getTemplate().getBytes("UTF-8"),"UTF-8");
        
        model.addAttribute("text",mailTemplate.getTemplate());
        
        //merge context and writer to String 
        velocityEngine.evaluate(context, writer, "SimpleVelocity", mailTemplate.getTemplate()); 
        
        
        String mailHeader = "<!DOCTYPE html><html><head><meta charset='UTF-8'></head>";
         
        //define finalTemplate
        String finalTemplate = mailHeader + "<body>" + writer.toString() + "</body></html>";
        
        //encode finalTemplate
        final String encode = new String(finalTemplate.getBytes("UTF-8"),"UTF-8");
        
        //create mime message
	    MimeMessagePreparator preparator = new MimeMessagePreparator() {
	      public void prepare(MimeMessage mimeMessage) throws Exception {
	              
	            MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	              message.setTo(recipientAddress);
	              message.setSubject(subject);
	              
	              FileSystemResource logo = new FileSystemResource(path + "logo.png");
	              message.addAttachment(logo.getFilename(), logo);
	              
	              FileSystemResource map = new FileSystemResource(path + "map.jpg");
	              message.addAttachment(map.getFilename(), map);
	              
	              message.setText(encode, true);
	      }
	    };
	    
	    //send email
        mailSender.send(preparator);
    
        System.out.println("templateName : " + mailTemplate.getName());
        System.out.println("finalTemplate : " + mailTemplate.getTemplate());
    
        return "email-create";
	}
}
