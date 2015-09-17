/*
 */
package com.aug.controllers;

import java.io.Serializable;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aug.db.dto.AugRequestDTO;
import com.aug.db.entities.AugRequest;
import com.aug.db.services.AugRequestService;

@Controller
public class RequestApproveController implements Serializable {

	private static final long serialVersionUID = 1L;
	@Autowired private AugRequestService augRequestService;

	
	/*--------------------Approve ------------------*/
	@RequestMapping(value = "/approve", method = { RequestMethod.GET })
	public String listApprove() {
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
	@RequestMapping(value = "/approve/update/{id}", method = { RequestMethod.POST })
	public @ResponseBody AugRequestDTO editApprove(@RequestBody AugRequestDTO augRequestDTO,
			@PathVariable Integer id) throws Exception{
		AugRequest augRequest = augRequestService.findById(augRequestDTO.getId());
		augRequest.setStatus(augRequestDTO.getStatus());
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
