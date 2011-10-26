package com.vmware.appcloud.testapps.guestbook;

import java.io.Serializable;
import java.sql.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Guest implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id @GeneratedValue
	Long id;
	private String name;
	private Date checkInTime;

	public Guest() {}

	public Guest(String name) {
		this.name = name;
		this.checkInTime = new Date(System.currentTimeMillis());
	}

	@Override
	public String toString() {
		return name + ", last checked in at " + checkInTime;
	}

}
