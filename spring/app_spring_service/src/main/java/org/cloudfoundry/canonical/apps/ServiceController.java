package org.cloudfoundry.canonical.apps;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.cloudfoundry.runtime.env.CloudEnvironment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class ServiceController {

    private ReferenceDataRepository referenceRepository;

    @Autowired
    public void setReferenceRepository(
            ReferenceDataRepository referenceRepository) {
        this.referenceRepository = referenceRepository;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public void hello(HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        out.print("hello from spring");
    }

    @RequestMapping(value = "/crash", method = RequestMethod.GET)
    public void crash(HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        System.exit(0);
        out.println("it should not get here");
    }

    @RequestMapping(value = "/service/mongo/{key}", method = RequestMethod.POST)
    public void mongo_post(@RequestBody String body, @PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        this.referenceRepository.write_to_mongo(key, body);
        out.print(body);
    }

    @RequestMapping(value = "/service/mongo/{key}", method = RequestMethod.GET)
    public void mongo_get(@PathVariable String key, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        out.print(this.referenceRepository.read_from_mongo(key));
    }

    @RequestMapping(value = "/service/redis/{key}", method = RequestMethod.POST)
    public void redis_post(@RequestBody String body, @PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        this.referenceRepository.write_to_redis(key, body);
        out.print(body);
    }

    @RequestMapping(value = "/service/redis/{key}", method = RequestMethod.GET)
    public void redis_get(@PathVariable String key, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        out.print(this.referenceRepository.read_from_redis(key));
    }

    @RequestMapping(value = "/service/mysql/{key}", method = RequestMethod.POST)
    public void mysql_post(@RequestBody String body, @PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        DataValue d = new DataValue();
        d.setId(key);
        d.setDataValue(body);
        referenceRepository.save(d);
        out.print(body);
    }

    @RequestMapping(value = "/service/mysql/{key}", method = RequestMethod.GET)
    public void mysql_get(@PathVariable String key, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        DataValue d = referenceRepository.find(key);
        out.print(d.getDataValue());
    }

    @RequestMapping(value = "/service/postgresql/{key}", method = RequestMethod.POST)
    public void postgresql_post(@RequestBody String body, @PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        DataValue d = new DataValue();
        d.setId(key);
        d.setDataValue(body);
        referenceRepository.save(d);
        out.print(body);
    }

    @RequestMapping(value = "/service/postgresql/{key}", method = RequestMethod.GET)
    public void postgresql_get(@PathVariable String key, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        DataValue d = referenceRepository.find(key);
        out.print(d.getDataValue());
    }

    @RequestMapping(value = "/service/rabbit/{key}", method = RequestMethod.POST)
    public void rabbit_post(@RequestBody String body, @PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        this.referenceRepository.write_to_rabbitmq(key, body);
        out.print(body);
    }

    @RequestMapping(value = "/service/rabbit/{key}", method = RequestMethod.GET)
    public void rabbit_get(@PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        out.print(this.referenceRepository.read_from_rabbitmq(key));
    }

    @RequestMapping(value = "/service/rabbitmq/{key}", method = RequestMethod.POST)
    public void rabbitsrs_post(@RequestBody String body,
            @PathVariable String key, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        this.referenceRepository.write_to_rabbitmq(key, body);
        out.print(body);
    }

    @RequestMapping(value = "/service/rabbitmq/{key}", method = RequestMethod.GET)
    public void rabbitsrs_get(@PathVariable String key,
            HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        out.print(this.referenceRepository.read_from_rabbitmq(key));
    }

    @RequestMapping(value = "/env", method = RequestMethod.GET)
    public void env(HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        CloudEnvironment env = this.referenceRepository.environment();
        out.println(env.getValue("VCAP_SERVICES"));
    }
}