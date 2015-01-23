/*
 * Main.java, part of the missing-http project
 * Created on Jan 21, 2015, 3:07:23 PM
 */

package net.psexton.missinghttp;

/**
 * Mainly here so that the jar has a Main Class.
 * Also prints out to stdout the version info of HttpComponents we built with.
 * @author PSexton
 */
class Main {
    public static void main(String[] args) {
        Main main = new Main();
    }
    
    public Main() {
        System.out.println("missing-http, build with HttpComponents Client 4.3.3 GA");
    }
}