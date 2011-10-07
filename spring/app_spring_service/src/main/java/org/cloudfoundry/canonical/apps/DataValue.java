package org.cloudfoundry.canonical.apps;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="DATA_VALUES")
public class DataValue implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="ID")
    private String id;

    @Column(name="DATA_VALUE")
    private String data_value;

    public DataValue() {}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDataValue() {
        return data_value;
    }

    public void setDataValue(String data_value) {
        this.data_value = data_value;
    }

    @Override
    public String toString() {
        return "DataValue [id=" + id + ", data_value=" + data_value + "]";
    }

}