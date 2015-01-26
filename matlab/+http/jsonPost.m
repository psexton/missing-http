function [ statusCode, responseBody ] = jsonPost( url, requestBody, varargin )
%JSONPOST Makes a POST request, with a JSON request body, and asking for a JSON response
%   URL resource to make the request to
%   REQUESTBODY string to use as request body
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpPost(url);
request.setHeader('Content-Type', 'application/json');
request.setHeader('Accept', 'application/json');
if(nargin > 2)
    http.private.addExtraHeaders(request, varargin);
end
requestEntity = net.psexton.ext.org.apache.http.entity.StringEntity(requestBody);
request.setEntity(requestEntity);

% Execute the request
[client, response] = http.private.executeRequest(request);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;
if(statusCode == 204)
    responseBody = ''; % No response entity on a 204 status code
else
    responseBody = net.psexton.ext.org.apache.http.util.EntityUtils.toString(response.getEntity);
    responseBody = char(responseBody); % convert from Java String to char array
end

% Clean up
http.private.cleanup(client, response);

end

