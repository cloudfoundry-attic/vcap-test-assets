package com.vmware.appcloud.testapps.guestbook;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

public class GuestDao {

    private HibernateTemplate hibernateTemplate;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

    public void persist(Guest guest) {
        this.hibernateTemplate.saveOrUpdate(guest);
    }

    @SuppressWarnings("unchecked")
	public List<Guest> getAllGuests() {
        return hibernateTemplate.find("from Guest");
    }

}
