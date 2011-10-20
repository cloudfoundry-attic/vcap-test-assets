package com.cloudfoundry.model

import _root_.net.liftweb.common._
import _root_.net.liftweb.mapper._
import _root_.java.util.Date
import scala.xml.Node
import scala.xml.NodeSeq

class Guest extends LongKeyedMapper[Guest] with IdPK {
  def getSingleton = Guest

  object name extends MappedString(this, 100)
  object checkInTime extends MappedDateTime(this)
}

object Guest extends Guest with LongKeyedMetaMapper[Guest] {
  private implicit val formats =
    net.liftweb.json.DefaultFormats

  override def dbTableName = "guests"

  def serializeToXml(guests: Seq[Guest]): Node =
      <guests>{guests.map(serializeToXml)}<count></count>{guests.length}</guests>

  def serializeToXml(guest: Guest): Node =
      <guest><name>{guest.name}</name><checkin_time>{guest.checkInTime}</checkin_time><id>{guest.id}</id></guest>

  def add(newName: String): Node = {
    val myg = Guest.find(By(Guest.name, newName))
    myg match {
      case Full(g) => <Failure>Name {newName} already present</Failure>
      case _ =>
       serializeToXml(Guest.create.name(newName).checkInTime(new Date(System.currentTimeMillis())).saveMe)
    }
  }

  def getAll: Node = {
    serializeToXml(Guest.findAll)
  }

  def get(name: String): Node = {
    val myg = Guest.find(By(Guest.name, name))
    myg match {
      case Full(g) => serializeToXml(g)
      case _ => <Failure>{name} not found</Failure>
    }
  }

  def getCount: Node = {
    val length = Guest.findAll.length
    <count>{length}</count>
  }

  def createFromXml(rootNode: Node) : Node = {
    val nameNode: NodeSeq = rootNode \\ "guest" \ "name"
    if (nameNode.length == 1) {
      Guest.add(nameNode.text)
    } else {
      <Failure>Invalid input</Failure>
    }
  }
}
