import sbt._
import Keys._
import play.Project._

object ApplicationBuild extends Build {

  val appName         = "todolist"
  val appVersion      = "1.0-SNAPSHOT"

  val appDependencies = Seq(
    // Add your project dependencies here,
    javaCore,
    javaJdbc,
    javaEbean,
    "org.cloudfoundry" % "cloudfoundry-runtime" % "0.8.1"
  )

  val main = play.Project(appName, appVersion, appDependencies).settings(
    resolvers += "Spring milestone repository" at "http://maven.springframework.org/milestone"
  )

}
