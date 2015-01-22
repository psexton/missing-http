function [ statusCode, responseBody ] = jsonPut( url, requestBody, varargin )
%JSONPUT Makes a PUT request, with a JSON request body, and asking for a JSON response
%   URL resource to make the request to
%   REQUESTBODY string to use as request body
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpPut(url);
request.setHeader('Content-Type', 'application/json');
request.setHeader('Accept', 'application/json');
if(nargin > 2)
    http.private.addExtraHeaders(request, varargin);
end
requestEntity = net.psexton.ext.org.apache.http.entity.StringEntity(requestBody);
request.setEntity(requestEntity);

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

