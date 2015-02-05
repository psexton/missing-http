/*
 * MatlabShim.java, part of the missing-http project
 * Created on Feb 4, 2015, 11:50:51 AM
 */

package net.psexton.missinghttp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpHead;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/**
 * MatlabShim - MATLAB shim for missing-http.
 * Because #twatlab, it is problematic for long-lived java objects to 
 * stick around that MATLAB allocated. So instead we provide object-free static
 * functionality.
 * 
 * Each MATLAB function has a corresponding static method in this class.
 * All arguments are passed in as Strings. varargs is used for additional headers.
 * Because we really don't want to return "custom" objects (see previous paragraph)
 * all return values are strings. Integer response codes are returned as Strings.
 * Response code / response body pairs are returned as a String[].
 * 
 * @author PSexton
 */
public class MatlabShim {
    // Private constructor to prevent instantiation
    private MatlabShim() {};
    
    public static String fileGet(String url, String filePath, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            // Set request headers
            request.addHeader("Accept", ContentType.APPLICATION_OCTET_STREAM.toString());
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response.
                // Get the respone status code first. If it's not 200, don't bother
                // with the response body.
                int statusCode = response.getStatusLine().getStatusCode();
                if(statusCode == 200) {
                    HttpEntity responseEntity = response.getEntity();
                    FileOutputStream destStream = new FileOutputStream(new File(filePath));
                    responseEntity.writeTo(destStream);
                }
                else {
                    EntityUtils.consume(response.getEntity()); // Consume the response so we can reuse the connection
                }
                
                // Package it up for MATLAB.
                String returnVal = Integer.toString(statusCode);
                return returnVal;
            }
        }
    }
    
    public static String[] filePut(String url, File source, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPut request = new HttpPut(url);
            // Set request body
            FileEntity requestEntity = new FileEntity(source, ContentType.APPLICATION_OCTET_STREAM);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity());
                
                // Package it up for MATLAB.
                String[] returnVal = {Integer.toString(statusCode), responseBody};
                return returnVal;
            }
        }
    }
    
    public static String head(String url, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpHead request = new HttpHead(url);
            // Set request headers
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response
                int statusCode = response.getStatusLine().getStatusCode();
                
                // Package it up for MATLAB.
                String returnVal = Integer.toString(statusCode);
                return returnVal;
            }
        }
    }
    
    public static String[] jsonGet(String url, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity());
                
                // Package it up for MATLAB.
                String[] returnVal = {Integer.toString(statusCode), responseBody};
                return returnVal;
            }
        }
    }
    
    public static String[] jsonPost(String url, String requestBody, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(url);
            // Set request body
            StringEntity requestEntity = new StringEntity(requestBody, ContentType.APPLICATION_JSON);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity());
                
                // Package it up for MATLAB.
                String[] returnVal = {Integer.toString(statusCode), responseBody};
                return returnVal;
            }
        }
    }
    
    public static String[] jsonPut(String url, String requestBody, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPut request = new HttpPut(url);
            // Set request body
            StringEntity requestEntity = new StringEntity(requestBody, ContentType.APPLICATION_JSON);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            for(int i = 0; i < headers.length; i+=2) {
                request.setHeader(headers[i], headers[i+1]);
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity());
                
                // Package it up for MATLAB.
                String[] returnVal = {Integer.toString(statusCode), responseBody};
                return returnVal;
            }
        }
    }
    
    /**
     * 
     * @param url
     * @param requestParts Each request part is a string, with newlines separating the type, name, and body
     * @param headers
     * @return 
     */
    public static String[] multipartPost(String  url, String[] requestParts, String... headers) {
        throw new UnsupportedOperationException("Not implemented yet");
    }
}
