/*
 */
package com.aug.controllers;

import java.io.Serializable;
import java.text.ParseException;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aug.hrdb.dto.AugRequestDto;
import com.aug.hrdb.entities.AugRequest;
import com.aug.hrdb.entities.Employee;
import com.aug.hrdb.entities.Login;
import com.aug.hrdb.services.AugRequestService;
import com.aug.hrdb.services.EmployeeService;
import com.aug.hrdb.services.LoginService;

@Controller
public class RequestApproveController implements Serializable {

	private static final long serialVersionUID = 1L;
	@Autowired
	private AugRequestService augRequestService;
	@Autowired
	private LoginService loginService;
	@Autowired
	private EmployeeService employeeService;

	
	/*--------------------Approve ------------------*/
	@Transactional
	@RequestMapping(value = "/approve", method = { RequestMethod.GET })
	public String listApprove(Model model) {
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("userName : " + userDetails.getUsername());
		Login login = loginService.findByUserName(userDetails.getUsername());
		Employee employee = login.getEmployee();
		Hibernate.initialize(employee.getApplicant());
		
		model.addAttribute("employee", employee);
		
		
		return "requestApprove";
	}

	/*--------------------Search All Request ------------------*/
	/*@RequestMapping(value = "/request/search", method = { RequestMethod.GET })
	public @ResponseBody Object findAllApprove() {
		final List<AugRequestDTO> data = augRequestService.findAllAugRequest();
		return new Object() {
			public List<AugRequestDTO> getData(){
				return data;
			}
		};
	}*/

	/*--------------------Update Approve Status ------------------*/
	@Transactional
	@RequestMapping(value = "/approve/update/{id}", method = { RequestMethod.POST })
	public @ResponseBody AugRequestDto editApprove(@RequestBody AugRequestDto augRequestDTO,
			@PathVariable Integer id) throws Exception{
		
		Employee employee = employeeService.findById(augRequestDTO.getApproverId());
		Hibernate.initialize(employee.getApplicant());
			
		AugRequest augRequest = augRequestService.findById(augRequestDTO.getId());
		augRequest.setStatus(augRequestDTO.getStatus());
		augRequest.setApprover(employee);
		augRequest.setApproveDate(augRequestDTO.getApproveDate());
		augRequestService.update(augRequest);
		
		return augRequestService.findAugRequestById(id);
	}
	
	/*--------------------Update Approve Status (Test throws ParseException)------------------*/
	/*@RequestMapping(value = "/approve/update/{id}", method = { RequestMethod.POST })
	public @ResponseBody AugRequestDTO editApproveTest(
			@RequestBody AugRequestDTO augRequestDTO, @PathVariable Integer id)
			throws ParseException{

		AugRequest augRequest = augRequestService.findById(augRequestDTO.getId());
		augRequest.setStatus(augRequestDTO.getStatus());
		augRequestService.update(augRequest);
		
		return augRequestService.findAugRequestById(id);
	}*/

}
