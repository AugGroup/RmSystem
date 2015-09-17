package com.aug.controllers;

import java.beans.PropertyEditorSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aug.db.entities.Position;
import com.aug.db.services.PositionService;

@Component
public class PositionEditor extends PropertyEditorSupport {

	@Autowired
	private PositionService positionService;
	 
	public void setAsText(String text) {
		this.setValue(null);
		if (!"".equals(text)) {
			Position position = positionService.findById(Integer.valueOf(text));
			this.setValue(position);
		}

	}

	public String getAsText() {
		String tx = "";
		Position position = (Position) this.getValue();
		if (position != null) {
			tx = Integer.toString(position.getId());
		}
		return tx;
	}


}
