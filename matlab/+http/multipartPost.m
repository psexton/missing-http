function [ statusCode, responseBody ] = multipartPost( url, requestParts, varargin )
%MULTIPARTPOST Makes a POST request with a multipart/form-data request body, and asking for a JSON response 
%   The request body has two parts: a JSON part 
%   (Content-Type: application/json) and a file part (Content-Type:
%   application/octet-stream).
%   URL resource to make the request to
%   REQUESTPARTS array of requestpart structs
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body
%
%   Each RequestPart struct should match one of these examples:
%   For a String part:
%       stringPart.Type = 'string';
%       stringPart.Name = 'someName';
%       stringPart.Body = 'contents of the string'
%   For a File part:
%       filePart.Type = 'file';
%       filePart.Name = 'someName';
%       filePart.Body = 'path/to/the/file'
%
%   Full example for one of each:
%   requestParts(1).Type = 'string';
%   requestParts(1).Name = 'comment';
%   requestParts(1).Body = 'http is not that complicated';
%   requestParts(2).Type = 'file';
%   requestParts(2).Name = 'upload';
%   requestParts(2).Body = '/home/jrandom/example.mp3';
%   [statusCode, responseBody = http.multipartPost(SOME_URL, requestParts);

if(isempty(requestParts))
    error('missinghttp:parse', 'requestParts cannot be empty');
end

% Build the request.
% Thanks to the awesomeness of HttpComponents, this is not that much more
% difficult than a single-part request
request = net.psexton.ext.org.apache.http.client.methods.HttpPost(url);
request.setHeader('Accept', 'application/json');
if(nargin > 2)
    http.private.addExtraHeaders(request, varargin);
end
entityBuilder = net.psexton.ext.org.apache.http.entity.mime.MultipartEntityBuilder.create();
for k=1:numel(requestParts)
    part = requestParts(k);
    if(strcmp(part.Type, 'string'))
        stringPart = net.psexton.ext.org.apache.http.entity.mime.content.StringBody(part.Body, net.psexton.ext.org.apache.http.entity.ContentType.TEXT_PLAIN);
        entityBuilder = entityBuilder.addPart(part.Name, stringPart);
    elseif(strcmp(part.Type, 'file'))
        filePart = net.psexton.ext.org.apache.http.entity.mime.content.FileBody(java.io.File(part.Body));
        entityBuilder = entityBuilder.addPart(part.Name, filePart);
    else
       % @TODO ERROR 
    end
end
requestEntity = entityBuilder.build();
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
