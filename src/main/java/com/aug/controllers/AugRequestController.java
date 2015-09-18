package com.aug.controllers;

import java.io.Serializable;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.bouncycastle.mail.smime.handlers.pkcs7_mime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.aug.hrdb.entities.MasJoblevel;
import com.aug.hrdb.services.AugRequestService;
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
//	@Autowired private PositionService positionService;
	@Autowired
	private MasTechnologyService masTechnologyService;
	@Autowired
	private MasJoblevelService masJoblevelService;
	
	@RequestMapping(value = "/request", method = { RequestMethod.GET })
	public String listRequest(){ 
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
	@RequestMapping(value = "/request/save", method = RequestMethod.POST)
	public @ResponseBody AugRequestDto saveRequest(
			@RequestBody AugRequestDto augRequestDto,HttpSession session){
		
		AugRequest augRequest = new AugRequest();
		augRequest.setId(augRequestDto.getId());
		augRequest.setRequestDate(augRequestDto.getRequestDate());
		augRequest.setRequesterName(augRequestDto.getRequesterName());
		augRequest.setStatus(augRequestDto.getStatus());
		augRequest.setApprovalName(augRequestDto.getApprovalName());
		augRequest.setApproveDate(augRequestDto.getApproveDate());
//		Position position = positionService.findById(augRequestDTO.getPositionRequest());
//		augRequest.setPositionRequest(position);
//		MasJoblevel masJoblevel = masJoblevelService.find(augRequestDto.get);
		augRequest.setNumberApplicant(augRequestDto.getNumberApplicant());
		augRequest.setSpecificSkill(augRequestDto.getSpecificSkill());
		augRequest.setYearExperience(augRequestDto.getYearExperience());
		augRequestService.create(augRequest);

		
		return augRequestDto;
	}

	/*-------------------- Update Request--------------------*/
	@RequestMapping(value = "/request/edit/{id}", method = { RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody AugRequestDto editAugRequest(
			@RequestBody AugRequestDto augRequestDto, @PathVariable Integer id) throws Exception {
		
		AugRequest augRequest = augRequestService.findById(augRequestDto.getId());
		augRequest.setId(augRequestDto.getId());
		augRequest.setRequestDate(augRequestDto.getRequestDate());
		augRequest.setRequesterName(augRequestDto.getRequesterName());
		augRequest.setStatus(augRequestDto.getStatus());
		augRequest.setApprovalName(augRequestDto.getApprovalName());
		augRequest.setApproveDate(augRequestDto.getApproveDate());
//		Position position = positionService.findById(augRequestDTO.getPositionRequest());
//		augRequest.setPositionStr(position.getPositionName());
//		augRequest.setPositionRequest(position);
		augRequest.setNumberApplicant(augRequestDto.getNumberApplicant());
		augRequest.setSpecificSkill(augRequestDto.getSpecificSkill());
		augRequest.setYearExperience(augRequestDto.getYearExperience());

		augRequestService.update(augRequest);
		
		AugRequestDto requestDto = augRequestService.findAugRequestById(id);
//		requestDto.setPositionStr(position.getPositionName());
		return requestDto;

	}

	/*-------------------- Delete Request--------------------*/
	@RequestMapping(value = "/request/delete/{id}", method = RequestMethod.POST)
	public @ResponseBody AugRequest delesteUser(@ModelAttribute AugRequest augRequest,
			@PathVariable("id") Integer id) throws Exception {
		
		augRequestService.delete(augRequest);
		return augRequestService.findById(id);
	}

	/*-------------------- Position List--------------------*/
//	@ModelAttribute("positionRequest")
//	public List<Position> getPosition() {
//		return positionService.findAll();
//
//	}
	
	/*-------------------- Test Exception Handle 'SQLGrammarException'--------------------*/ //NameNativeQuery is wrong
/*	@RequestMapping(value = "/request/search/testSQLGrammarException/{id}", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody AugRequestDTO testHandlerException(
			@PathVariable Integer id, Model model) throws Exception {
		AugRequestDTO augRequest = augRequestService.findAugRequestByIdTest(id);
		return augRequest;
	}*/
	
	
	/*if(date!=null){
		split + call search
	}else
		find all
		
*/
	
	
}
