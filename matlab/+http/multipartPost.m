function [ statusCode, responseBody ] = multipartPost( url, requestParts, varargin )
%HTTP.MULTIPARTPOST Makes a POST request with a multipart/form-data request body, and asking for a JSON response 
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

% Flatten each struct entry into a string, newline separated
cellRequestParts = cell(1, numel(requestParts)); % preallocate for some reason
for k=1:numel(requestParts)
    str = sprintf('%s\n%s\n%s', requestParts(k).Type, requestParts(k).Name, requestParts(k).Body);
    cellRequestParts{k} = str;
end

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.multipartPost(url, cellRequestParts, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
