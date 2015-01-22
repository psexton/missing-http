function [ statusCode, responseBody ] = jsonGet( url )
%JSONGET Makes a GET request, asking for a JSON response
%   URL resource to make the request to
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpGet(url);
request.setHeader('Accept', 'application/json');

% Execute the request
httpClient = net.psexton.ext.org.apache.http.impl.client.HttpClientBuilder.create().build();
localContext = net.psexton.ext.org.apache.http.protocol.BasicHttpContext();
response = httpClient.execute(request, localContext);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;
responseBody = net.psexton.ext.org.apache.http.util.EntityUtils.toString(response.getEntity);
responseBody = char(responseBody); % convert from Java String to char array

% Clean up
httpClient.getConnectionManager().shutdown();

end
