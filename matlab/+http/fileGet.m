%HTTP.FILEGET GET request, binary (file) response
%
% Description:
% Makes a GET request, asking for a binary response (`Accept: application/octet-stream`).
% Note that the file is only written to if `statusCode` is 200.
% 
% Syntax:
%   statusCode = http.fileGet(url, filePath)
%   statusCode = http.fileGet(url, filePath, headerName, headerValue)
%   statusCode = http.fileGet(url, filePath, header1Name, header1Value, header2Name, header2Value, ...)
%
% Inputs:
%   url      - Resource to make the request to
%   filePath - path to write the response body to
%
% Optional Inputs:
%   headerName  - Name for an extra header
%   headerValue - Value for an extra header
%
% Any number of additional header name/value pairs can be added.  
%
% Output:
%   statusCode - Integer response code

function statusCode = fileGet( url, filePath, varargin )
% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String. We convert this to a char array
response = char(net.psexton.missinghttp.MatlabShim.fileGet(url, filePath, varargin));
statusCode = str2double(response);

end
