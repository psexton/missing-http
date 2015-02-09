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
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
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
    
    /**
     * GET request, with file response
     * @param url URL to make request to
     * @param filePath Path to create/overwrite with downloaded file
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return Response status code.
     * @throws IOException 
     * "application/octet-stream" is the expected Content-Type of the response.
     */
    public static String fileGet(String url, String filePath, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            // Set request headers
            request.addHeader("Accept", ContentType.APPLICATION_OCTET_STREAM.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
            }
            // Execute the request
            try (CloseableHttpResponse response = client.execute(request)) {
                // Parse the response.
                // Get the respone status code first. If it's not 200, don't bother
                // with the response body.
                int statusCode = response.getStatusLine().getStatusCode();
                if(statusCode == 200) {
                    HttpEntity responseEntity = response.getEntity();
                    try (FileOutputStream destStream = new FileOutputStream(new File(filePath))) {
                        responseEntity.writeTo(destStream);
                    }
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
    
    /**
     * PUT request, with file request and JSON response
     * @param url URL to make request to
     * @param source Path to read for uploaded file
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return String array of length 2. Element 0 is the response status code. Element 1 is the response body
     * @throws IOException 
     * "application/octet-stream" is the Content-Type of the request.
     */
    public static String[] filePut(String url, File source, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPut request = new HttpPut(url);
            // Set request body
            FileEntity requestEntity = new FileEntity(source, ContentType.APPLICATION_OCTET_STREAM);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
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
     * HEAD request
     * @param url URL to make request to
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return Response status code.
     * @throws IOException 
     */
    public static String head(String url, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpHead request = new HttpHead(url);
            // Set request headers
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
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
    
    /**
     * GET request, with JSON response
     * @param url URL to make request to
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return String array of length 2. Element 0 is the response status code. Element 1 is the response body
     * @throws IOException 
     */
    public static String[] jsonGet(String url, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
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
     * PUT request, with JSON request and response
     * @param url URL to make request to
     * @param requestBody JSON object, formatted as a string
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return String array of length 2. Element 0 is the response status code. Element 1 is the response body
     * @throws IOException 
     */
    public static String[] jsonPost(String url, String requestBody, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(url);
            // Set request body
            StringEntity requestEntity = new StringEntity(requestBody, ContentType.APPLICATION_JSON);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
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
     * PUT request, with JSON request and response
     * @param url URL to make request to
     * @param requestBody JSON object, formatted as a string
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return String array of length 2. Element 0 is the response status code. Element 1 is the response body
     * @throws IOException 
     */
    public static String[] jsonPut(String url, String requestBody, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPut request = new HttpPut(url);
            // Set request body
            StringEntity requestEntity = new StringEntity(requestBody, ContentType.APPLICATION_JSON);
            request.setEntity(requestEntity);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
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
     * POST request, with multipart request and JSON response
     * @param url URL to make request to
     * @param requestParts Each request part is a string, with newlines separating the type, name, and body
     * @param headers Extra headers to add. Even-numbered elements will be treated as header names, and odd-numbered elements will be treated as header values.
     * @return String array of length 2. Element 0 is the response status code. Element 1 is the response body
     * @throws java.io.IOException 
     * Each element in requestParts should contain three newline (\n) separated parts: 
     * A type ("file", "json", or "string"), a name, and a body.
     * The type specifies what Content-Type to use for that part. The name specifies what name to give to that part.
     * The body is the body of that part. (For a file, this should be the file's path.)
     */
    public static String[] multipartPost(String  url, String[] requestParts, String... headers) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(url);
            // Set request headers
            request.setHeader("Accept", ContentType.APPLICATION_JSON.toString());
            if(headers != null) {
                for(int i = 0; i < headers.length; i+=2) {
                    request.setHeader(headers[i], headers[i+1]);
                }
            }
            // Set request body
            // The most difficult part here is undoing the string mangling
            // that #twatlab forced us to do.
            // Actually doing a multi-part post isn't that much more difficult 
            // than a single-part request. HttpComponents is awesome.
            MultipartEntityBuilder builder = MultipartEntityBuilder.create();
            for(String part : requestParts) {
                String[] partParts = part.split("\n", 3); // If there are newlines in partBody, leave them alone
                if(partParts.length != 3) {
                    throw new IllegalArgumentException("RequestPart " + prettifyRequestPart(part) + " has " + partParts.length + " lines (expected 3).");
                }
                
                String partType = partParts[0];
                String partName = partParts[1];
                String partBody = partParts[2];
                
                switch(partType) {
                    case "file":
                        FileBody fileBody = new FileBody(new File(partBody));
                        builder.addPart(partName, fileBody);
                        break;
                    case "json":
                        StringBody jsonBody = new StringBody(partBody, ContentType.APPLICATION_JSON);
                        builder.addPart(partName, jsonBody);
                        break;
                    case "string":
                        StringBody stringBody = new StringBody(partBody, ContentType.DEFAULT_TEXT);
                        builder.addPart(partName, (ContentBody) stringBody);
                        break;
                    default:
                        throw new IllegalArgumentException("RequestPart " + prettifyRequestPart(part) + " has an unsupported type (expected \"file\", \"json\", or \"string\").");
                }
            }
            request.setEntity(builder.build());
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
     * Utility for printing error messages from multipartPost
     * @param part String with three \n separated parts
     * @return String with three parts in quotes, inside curly braces
     */
    private static String prettifyRequestPart(String part) {
        part = part.replace("\n", "\",\"");
        part = "{\"" + part + "\"}";
        return part;
    }
}
