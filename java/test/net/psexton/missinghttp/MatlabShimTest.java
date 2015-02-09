/*
 * MatlabShimTest.java, part of the missing-http project
 * Created on Feb 9, 2015, 12:54:43 PM
 */
package net.psexton.missinghttp;

import java.io.File;
import java.io.IOException;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

/**
 * Integration tests for MatlabShimTest class.
 * Don't check anything with the actual responses, just make sure nothing blows up.
 * @author PSexton
 */
public class MatlabShimTest {
    private static final String BASE_URL = "http://example.com";

    /**
     * Test of fileGet method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Ignore
    @Test
    public void fileGet() throws IOException {
        System.out.println("fileGet");
        String url = "";
        String filePath = "";
        String[] headers = null;
        String expResult = "";
        String result = MatlabShim.fileGet(url, filePath, headers);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of filePut method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Ignore
    @Test
    public void filePut() throws IOException {
        System.out.println("filePut");
        String url = "";
        File source = null;
        String[] headers = null;
        String[] expResult = null;
        String[] result = MatlabShim.filePut(url, source, headers);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of head method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Test
    public void head() throws IOException {
        String result = MatlabShim.head(BASE_URL);
    }
    @Test
    public void headWithNull() throws IOException {
        String[] headers = null;
        String result = MatlabShim.head(BASE_URL, headers);
    }
    @Test
    public void headWithHeaders() throws IOException {
        String[] headers = {"X-Foo", "Bar"};
        String result = MatlabShim.head(BASE_URL, headers);
    }

    /**
     * Test of jsonGet method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Test
    public void jsonGet() throws IOException {
        String[] result = MatlabShim.jsonGet(BASE_URL);
    }
    @Test
    public void jsonGetWithNull() throws IOException {
        String[] headers = null;
        String[] result = MatlabShim.jsonGet(BASE_URL, headers);
    }
    @Test
    public void jsonGetWithHeaders() throws IOException {
        String[] headers = {"X-Foo", "Bar"};
        String[] result = MatlabShim.jsonGet(BASE_URL, headers);
    }

    /**
     * Test of jsonPost method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Ignore
    @Test
    public void jsonPost() throws IOException {
        System.out.println("jsonPost");
        String url = "";
        String requestBody = "";
        String[] headers = null;
        String[] expResult = null;
        String[] result = MatlabShim.jsonPost(url, requestBody, headers);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of jsonPut method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Ignore
    @Test
    public void jsonPut() throws IOException {
        System.out.println("jsonPut");
        String url = "";
        String requestBody = "";
        String[] headers = null;
        String[] expResult = null;
        String[] result = MatlabShim.jsonPut(url, requestBody, headers);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of multipartPost method, of class MatlabShimTest.
     * @throws java.io.IOException
     */
    @Ignore
    @Test
    public void multipartPost() throws IOException {
        System.out.println("multipartPost");
        String url = "";
        String[] requestParts = null;
        String[] headers = null;
        String[] expResult = null;
        String[] result = MatlabShim.multipartPost(url, requestParts, headers);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
