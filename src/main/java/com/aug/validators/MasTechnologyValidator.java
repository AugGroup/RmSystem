package com.aug.validators;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.aug.hrdb.entities.MasTechnology;

@Component
public class MasTechnologyValidator implements Validator {

	@Override
	public boolean supports(Class clazz) {
		// TODO Auto-generated method stub
		return MasTechnology.class.equals(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		// TODO Auto-generated method stub
		ValidationUtils.rejectIfEmpty(errors, "empty", null, "emty");
		MasTechnology masTechnology = (MasTechnology) obj;
			if(null == masTechnology.getId()){
				errors.rejectValue("id", null, "valid.info.status");
			}
			if(-1 == masTechnology.getId()){
				errors.rejectValue("id",null , "valid.info.status"); 
			}
	}

}
