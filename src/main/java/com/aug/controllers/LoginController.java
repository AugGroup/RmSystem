package com.aug.controllers;

import java.io.Serializable;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aug.hrdb.services.LoginService;

@Controller
@SessionAttributes("login")
public class LoginController implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private LoginService loginService;

	@RequestMapping(value = "/login", method = { RequestMethod.GET })
	public String loginSpring(Model model) {
		model.addAttribute("error", "true");
		return "login";

	}

	@RequestMapping(value = "/applicant", method = { RequestMethod.POST })
	public String loginSpringPost(Model model) {

		return "mainApplicant";
	}
	
	@RequestMapping(value = "/logout", method = { RequestMethod.GET })
	public String logoutSpring(HttpSession session) {
		session.invalidate();
		return "redirect:/login";

	}

}
