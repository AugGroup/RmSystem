package com.aug.controllers;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Hibernate;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.aug.hrdb.dto.AugRequestDto;
import com.aug.hrdb.entities.AugRequest;
import com.aug.hrdb.entities.Employee;
import com.aug.hrdb.entities.Login;
import com.aug.hrdb.entities.MasJoblevel;
import com.aug.hrdb.entities.MasTechnology;
import com.aug.hrdb.services.AugRequestService;
import com.aug.hrdb.services.LoginService;
import com.aug.hrdb.services.MasJoblevelService;
import com.aug.hrdb.services.MasTechnologyService;


/**
 *
 * @author Supannika Pattanodom
 */
@Controller
@EnableWebMvc
public class AugRequestController implements Serializable {

	private static final long serialVersionUID = 1L;
	@Autowired 
	private AugRequestService augRequestService;
	@Autowired
	private MasTechnologyService masTechnologyService;
	@Autowired
	private MasJoblevelService masJoblevelService;
	@Autowired
	private LoginService loginService;

	@Transactional
	@RequestMapping(value = "/request", method = { RequestMethod.GET })
	public String listRequest(Model model){
		
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("userName : " + userDetails.getUsername());
		Login login = loginService.findByUserName(userDetails.getUsername());
		Employee employee = login.getEmployee();
		Hibernate.initialize(employee.getApplicant());

		model.addAttribute("employee", employee);
		
		return "augRequest";
	}

	/*-------------------- Search All Request ----Exception handler-------------*/
	@RequestMapping(value = "/request/search", method = { RequestMethod.GET })
	public @ResponseBody Object findAllRequest() throws Exception{
		final List<AugRequestDto> data = augRequestService.findAllAugRequest();
		if(data == null){
			throw new NullPointerException();
		}
		return new Object() {
			public List<AugRequestDto> getData() {
				return data;
			}
		};
	}
	
	
	/*-------------------- Search Request By Id--------------------*/
	@RequestMapping(value = "/request/search/{id}", method = { RequestMethod.POST, RequestMethod.GET  })
	public @ResponseBody AugRequestDto searchRequestById(
			@PathVariable Integer id, Model model){
		//AugRequestDTO augRequest = augRequestService.findAugRequestById(500);//test 404 resource not found
		AugRequestDto augRequest = augRequestService.findAugRequestById(id);
		
		return augRequest;
	}

	

	/*-------------------- Save Request--------------------*/
	@Transactional
	@RequestMapping(value = "/request/save", method = RequestMethod.POST)
	public @ResponseBody AugRequest saveRequest(@RequestBody AugRequest augRequest,HttpSession session,Model model){
		
		augRequestService.create(augRequest);
		AugRequest augRe = augRequestService.findById(augRequest.getId());
		
		return augRe;
	}

	/*-------------------- Update Request--------------------*/
	@RequestMapping(value = "/request/edit/{id}", method = { RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody AugRequestDto editAugRequest(
			@RequestBody AugRequestDto augRequestDto, @PathVariable Integer id) throws Exception {
		
		MasJoblevel masJoblevel = masJoblevelService.find(augRequestDto.getJoblevelId());
		MasTechnology masTechnology = masTechnologyService.find(augRequestDto.getTechnologyId());
		AugRequest augRequest = augRequestService.findById(augRequestDto.getId());
		
		augRequest.setId(augRequestDto.getId());
		augRequest.setRequestDate(augRequestDto.getRequestDate());
		augRequest.setStatus(augRequestDto.getStatus());
		augRequest.setApproveDate(augRequestDto.getApproveDate());
		augRequest.setJoblevel(masJoblevel);
		augRequest.setTechnology(masTechnology);
		augRequest.setNumberApplicant(augRequestDto.getNumberApplicant());
		augRequest.setSpecificSkill(augRequestDto.getSpecificSkill());
		augRequest.setYearExperience(augRequestDto.getYearExperience());

		augRequestService.update(augRequest);
		
		AugRequestDto requestDto = augRequestService.findAugRequestById(id);
		requestDto.setJobLevelStr(masJoblevel.getName());
		requestDto.setTechnologyStr(masTechnology.getName());
		
		return requestDto;

	}

	/*-------------------- Delete Request--------------------*/
	@RequestMapping(value = "/request/delete/{id}", method = RequestMethod.POST)
	public @ResponseBody AugRequest delesteUser(@ModelAttribute AugRequest augRequest,
			@PathVariable("id") Integer id) throws Exception {
		
		augRequestService.delete(augRequest);
		return augRequestService.findById(id);
	}
	
	/*-------------------- Test Exception Handle 'SQLGrammarException'--------------------*/ //NameNativeQuery is wrong
/*	@RequestMapping(value = "/request/search/testSQLGrammarException/{id}", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody AugRequestDTO testHandlerException(
			@PathVariable Integer id, Model model) throws Exception {
		AugRequestDTO augRequest = augRequestService.findAugRequestByIdTest(id);
		return augRequest;
	}*/
	
	@ModelAttribute("jobLevels")
	@Transactional
	public List<MasJoblevel> jobLevelList(){
		return masJoblevelService.findAll();
	}
	
	@ModelAttribute("technologies")
	@Transactional
	public List<MasTechnology> technologyList(){
		return masTechnologyService.findAll();
	}
	
	
}
