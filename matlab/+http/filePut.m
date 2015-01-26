function [ statusCode, responseBody ] = filePut( url, filePath, varargin )
%HTTP.FILEPUT Makes a PUT request, with a file request body, and asking for a JSON response
%   URL resource to make the request to
%   FILEPATH path to file to use as request body
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpPut(url);
request.setHeader('Content-Type', 'application/octet-stream');
request.setHeader('Accept', 'application/json');
if(nargin > 2)
    http.private.addExtraHeaders(request, varargin);
end
javaFile = java.io.File(filePath);
requestEntity = com.gnlabs.ext.org.apache.http.entity.FileEntity(javaFile, 'application/octet-stream');
httpput.setEntity(requestEntity);

% Execute the request
[client, response] = http.private.executeRequest(request);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;
responseBody = net.psexton.ext.org.apache.http.util.EntityUtils.toString(response.getEntity);
responseBody = char(responseBody); % convert from Java String to char array

% Clean up
http.private.cleanup(client, response);

end

