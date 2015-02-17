%HTTP.MULTIPARTPOST POST request, multipart request body, JSON response
%
% Description:
% Makes a POST request, with a multi-part request body (`Content-Type: multipart/mixed`), 
% and asking for a JSON response (`Accept: application/json`). A single request
% can contain 1 or more independent parts. Each part has a name so that e.g. multiple 
% string parts can be properly unpacked by the server.
% 
% Three content types are supported for parts: files (`application/octet-stream`), 
% plain text (`text/plain`), and JSON text (`application/json`).
% 
% Syntax:
%   [statusCode, responseBody] = http.multipartPost(url, requestParts)
%   [statusCode, responseBody] = http.multipartPost(url, requestParts, headerName, headerValue)
%   [statusCode, responseBody] = http.multipartPost(url, requestParts, header1Name, header1Value, header2Name, header2Value, ...)
%
% Inputs:
%   url          - Resource to make the request to
%   requestParts - Array of structs containing info about the request parts. 
%                  Each struct must contain three fields: `Type`, `Name`, and
%                  `Body`. The `Type` field should have a value of either
%                  `file`, `json`, or `string`. The `Name` field should have
%                  a string value naming the part. The `Body` field has
%                  different content depending on the `Type`. For a `string`
%                  or `json` part, the value should be the contents of the 
%                  string or json object. For a `file` part, the value should
%                  be the path to the file to upload.
%
% Optional Inputs:
%   headerName  - Name for an extra header
%   headerValue - Value for an extra header
%
% Any number of additional header name/value pairs can be added.  
%
% Output:
%   statusCode - Integer response code
%   responseBody - String response body
%
% Examples:
%   % Multipart post with one string part and one file part
%   >> url = 'http://example.com/upload';
%   >> requestParts(1).Type = 'string';
%   >> requestParts(1).Name = 'comment';
%   >> requestParts(1).Body = 'http is not that complicated';
%   >> requestParts(2).Type = 'file';
%   >> requestParts(2).Name = 'upload';
%   >> requestParts(2).Body = '/home/jrandom/example.mp3';
%   [statusCode, responseBody] = http.multipartPost(url, requestParts);

function [ statusCode, responseBody ] = multipartPost( url, requestParts, varargin )

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
