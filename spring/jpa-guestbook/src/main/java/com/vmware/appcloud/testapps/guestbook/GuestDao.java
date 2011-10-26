package com.vmware.appcloud.testapps.guestbook;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class GuestDao {

	@PersistenceContext
    private EntityManager em;

    @Transactional
    public void persist(Guest guest) {
        em.persist(guest);
    }

    public List<Guest> getAllGuests() {
        TypedQuery<Guest> query = em.createQuery(
            "SELECT g FROM Guest g ORDER BY g.id", Guest.class);
        return query.getResultList();
    }

}
