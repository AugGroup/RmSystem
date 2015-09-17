package com.aug.controllers;

import java.io.Serializable;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ExceptionControllerPage implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/*-------------- error page (by throws)---------------------*/
	@RequestMapping(value = "/exception/custom", method = { RequestMethod.GET })
	public String errorPageCustom() {
		return "errorPages/errorPageCustom";
	}
	
	@RequestMapping(value = "/exception/400", method = { RequestMethod.GET })
	public String errorPage400() {
		return "errorPages/errorPage400";
	}

	@RequestMapping(value = "/exception/404", method = { RequestMethod.GET })
	public String errorPage404() {
		return "errorPages/errorPage404";
	}

	@RequestMapping(value = "/exception/415", method = { RequestMethod.GET })
	public String errorPage415() {
		return "errorPages/errorPage415";
	}

	@RequestMapping(value = "/exception/500", method = { RequestMethod.GET })
	public String errorPage500() {
		return "errorPages/errorPage500";
	}
	
	/*-------------- error page (web.xml)---------------------*/
	@RequestMapping(value = "/errorPages/error400", method = { RequestMethod.GET })
	public String errorPage400ByWebXML() {
		return "errorPages/errorPage400";
	}

	@RequestMapping(value = "/errorPages/error401", method = { RequestMethod.GET })
	public String errorPage401ByWebXML() {
		return "errorPages/errorPage401";
	}
	
	@RequestMapping(value = "/errorPages/error404", method = { RequestMethod.GET })
	public String errorPage404ByWebXML() {
		return "errorPages/errorPage404";
	}
	
	@RequestMapping(value = "/errorPages/error405", method = { RequestMethod.GET })
	public String errorPage405ByWebXML() {
		return "errorPages/errorPage405";
	}
	
	@RequestMapping(value = "/errorPages/error500", method = { RequestMethod.GET })
	public String errorPage500ByWebXML() {
		return "errorPages/errorPage500";
	}
	
	@RequestMapping(value = "/errorPages/error503", method = { RequestMethod.GET })
	public String errorPage503ByWebXML() {
		return "errorPages/errorPage503";
	}
	
	@RequestMapping(value = "/errorPages/errorCustom", method = { RequestMethod.GET })
	public String errorPageCustomByWebXML() {
		return "errorPages/errorPageCustom";
	}
}
