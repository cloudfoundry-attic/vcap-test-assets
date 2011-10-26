package com.vmware.appcloud.testapps.guestbook;

import java.io.Serializable;
import java.sql.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Table;

@Entity
@Table(name="GUEST")
public class Guest implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id @GeneratedValue
    @Column(name="GUEST_ID")
    private Long id;

    @Column(name="GUEST_NAME")
    private String name;

    @Column(name="CHECKIN_TIME")
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
