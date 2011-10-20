package com.cloudfoundry.lib

import _root_.com.cloudfoundry.model.Guest
import _root_.net.liftweb.http._
import _root_.net.liftweb.http.rest.RestHelper

object GuestService extends RestHelper {

  serve ( "api" / "guests" prefix {

    case Nil XmlGet _ => Guest.getAll

    case "count" :: Nil XmlGet _ => Guest.getCount

    case Nil XmlPost xml -> _ => {
      println(xml)
      Guest.createFromXml(xml)
    }

  })
}
