# missing-http
Proper HTTP APIs for MATLAB.

# The Problem

MATLAB's support for HTTP calls leaves a lot to be desired. `urlread` and `urlwrite` had numerous shortcomings. You couldn't set arbitrary headers. You couldn't see response headers. _You couldn't even see the response code._

More recent versions of MATLAB have addressed some of the issues. You can now specify a timeout, for instance. And 2014b's `webread` and `webwrite` are big improvements. But in typical Mathworks style, they managed to still F it up.

For instance, `weboptions` allows you to set headers. (Finally!) But while setting a Content Type is easy, if you want to set a header that's less common, you have to use a more cumbersome form, because Mathworks is concerned you might hurt youself with this scary internet business. Observe:
```
data = webread(SOME_URL, weboptions('UserAgent', 'twatlab 2014b')); % works fine
data = webread(SOME_URL, weboptions('Authentication', 'SECRETS'); % does not work
data = webread(SOME_URL, weboptions('KeyName', 'Authentication', 'KeyValue', 'SECRETS')); % works
```

And that's just scratching the surface. (Still can't see the status codes! Those are useful!) As with most tasks that don't resemble linear algebra, MATLAB does a fairly piss poor job.

# An Obvious Solution

MATLAB supports Java, and Java has the *fantastic* [Apache HttpComponents](https://hc.apache.org/), so why not just add those jars to the dynamic classpath, grumble a bit, and continue on?

Except MATLAB uses HttpComponents internally, so it's already on the classpath. But they use an old version (4.1, I believe), and their Java classpath trumps yours. So your code will fail with strange errors about classes and methods not found.

# A Working Solution

Thankfully, the Java world also produced a tool called [Jar Jar Links](https://code.google.com/p/jarjar/) that lets you mess with jar files. One thing you can do is rename things. So if we move all of the HttpComponents classes to a new package, there's no longer any overlap, and we can use our newer versions with no worry of accidentally getting an older version packaged with MATLAB.

That's exactly what missing-http-0.1.0 did. All occurances of `org.apache.*` were altered to `net.psexton.ext.org.apache.*` in the HttpComponents jar file bytecode. Additionally, I combined the half a dozen jars from Apache into a single `missing-http.jar` file, and added MATLAB functions that called into HttpComponents.

## But wait, there's more!

Unfortunately, this creates problems if you're planning on putting both missing-http and something else on the dynamic java classpath. (See [#1](https://github.com/psexton/missing-http/issues/1).) So missing-http-0.2.0 shoves everything behind static Java methods. All Java objects still get cleared when you run `javaaddpath`, but at least MATLAB doesn't err out. #twatlab

# Installation

Run the `onLoad` function when MATLAB starts. e.g. `run('path/to/missing-http/onLoad.m');`

# Usage

missing-http has the opinion that most of the time, you probably want to either deal with JSON or a file. It provides wrapper functions for these common tasks. For less common tasks, you can roll your own wrapper.

Provided wrappers:
 * GET request, JSON response
 * GET request, binary (file) response
 * PUT request, JSON request body, JSON response
 * PUT request, binary (file) request body, JSON response
 * POST request, JSON request body, JSON response
 * POST request, multipart request body, JSON response
 * HEAD request
 
## Two examples to show how easy it is:

A normal get request, but with an OAuth 2 Bearer Token for authorization:
```
myToken = 'XXXXXXXX-XXXXXXXX-XXXXXXXX-XXXXXXXX';
[statusCode, responseBody] = http.get('https://example.com', 'Authorization', ['Bearer ' myToken]);
```

A multipart POST request with a string part and a file part:
```
requestParts(1).Type = 'string';
requestParts(1).Name = 'comment';
requestParts(1).Body = 'http is not that complicated';
requestParts(2).Type = 'file';
requestParts(2).Name = 'upload';
requestParts(2).Body = '/home/jrandom/example.mp3';
[statusCode, responseBody] = http.multipartPost('https://example.com', requestParts);
```

# License

HttpComponents is licensed under the [Apache 2 license](http://opensource.org/licenses/Apache-2.0). missing-http is a derivative work and is licensed under the same terms. Copyright for all code inside the `missing-http.jar` with a classpath of `net.psexton.ext.*` remains with its original owners (e.g. The Apache Foundation).

# Contributing

1. Fork it ( https://github.com/psexton/missing-http/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request 
