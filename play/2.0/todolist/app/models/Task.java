package models;

import java.util.*;
import javax.persistence.*;

import play.db.ebean.*;
import play.data.format.*;
import play.data.validation.*;

import com.avaje.ebean.*;


@Entity
public class Task extends Model{

  @Id
  public Long id;

  public String label;

public static Model.Finder<Long,Task> find = new Model.Finder(
   Long.class, Task.class
 );

 public static List<Task> all() {
  return find.all();
}

public static void create(Task task) {
  task.save();
}

public static void delete(Long id) {
  find.ref(id).delete();
}

}
