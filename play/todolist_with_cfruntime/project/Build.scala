import sbt._
import Keys._
import PlayProject._

object ApplicationBuild extends Build {

    val appName         = "todolist"
    val appVersion      = "1.0-SNAPSHOT"

     val appDependencies = Seq(
      "org.cloudfoundry" % "cloudfoundry-runtime" % "0.8.1"
    )

    val main = PlayProject(appName, appVersion, appDependencies, mainLang = JAVA).settings(
      resolvers += "Spring milestone repository" at "http://maven.springframework.org/milestone"
    )

}
