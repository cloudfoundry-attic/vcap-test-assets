package org.cloudfoundry.imagemagick;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;

import org.springframework.stereotype.Component;

@Component
    public class MagickProcesser {

    public boolean identify() {
	return runCmd("identify");
    }

    // Returns true if command execution was successful
    public boolean resize(String path, String newSize) {
	// This method overwrites existing image with the resized one
	return runCmd("convert -resize " + newSize + "! " + path + " " + path);
    }

    public String getSize(String path) {
	// This method overwrites existing image with the resized one
	return getCmdOutput("identify -format %wx%h " + path);
    }

    private boolean runCmd(String cmd) {
	Process process;
	try {
	    process = Runtime.getRuntime().exec(cmd);
	    try {
		process.waitFor();
	    } catch (InterruptedException e) {
		e.printStackTrace();
	    }
	    return (process.exitValue() == 0);
	} catch (IOException e) {
	    e.printStackTrace();
	}
	return false;
    }

    private String getCmdOutput(String cmd) {
	Process process;
	try {
	    process = Runtime.getRuntime().exec(cmd);
	    InputStream cmdOut = process.getInputStream();
	    InputStreamReader reader = new InputStreamReader(cmdOut);
	    BufferedReader in = new BufferedReader(reader);
	    String output = "";
	    String line;
	    while ((line = in.readLine()) != null) {
		output += line;
	    }
	    return output;
	} catch (IOException e) {
	    e.printStackTrace();
	}
	return "";
    }
}
