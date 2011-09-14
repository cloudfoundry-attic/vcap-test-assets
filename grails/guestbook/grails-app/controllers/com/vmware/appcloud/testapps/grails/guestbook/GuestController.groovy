package com.vmware.appcloud.testapps.grails.guestbook

class GuestController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [guestInstanceList: Guest.list(params), guestInstanceTotal: Guest.count()]
    }

    def create = {
        def guestInstance = new Guest()
        guestInstance.properties = params
        return [guestInstance: guestInstance]
    }

    def save = {
        def guestInstance = new Guest(params)
        if (guestInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'guest.label', default: 'Guest'), guestInstance.id])}"
            redirect(action: "show", id: guestInstance.id)
        }
        else {
            render(view: "create", model: [guestInstance: guestInstance])
        }
    }

    def show = {
        def guestInstance = Guest.get(params.id)
        if (!guestInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
            redirect(action: "list")
        }
        else {
            [guestInstance: guestInstance]
        }
    }

    def edit = {
        def guestInstance = Guest.get(params.id)
        if (!guestInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [guestInstance: guestInstance]
        }
    }

    def update = {
        def guestInstance = Guest.get(params.id)
        if (guestInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (guestInstance.version > version) {
                    
                    guestInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'guest.label', default: 'Guest')] as Object[], "Another user has updated this Guest while you were editing")
                    render(view: "edit", model: [guestInstance: guestInstance])
                    return
                }
            }
            guestInstance.properties = params
            if (!guestInstance.hasErrors() && guestInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'guest.label', default: 'Guest'), guestInstance.id])}"
                redirect(action: "show", id: guestInstance.id)
            }
            else {
                render(view: "edit", model: [guestInstance: guestInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def guestInstance = Guest.get(params.id)
        if (guestInstance) {
            try {
                guestInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'guest.label', default: 'Guest'), params.id])}"
            redirect(action: "list")
        }
    }
}
