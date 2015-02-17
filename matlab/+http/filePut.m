%HTTP.FILEPUT PUT request, binary (file) request body, JSON response
%
% Description:
% Makes a PUT request, with a binary request body (`Content-Type: application/octet-stream`), 
% and asking for a JSON response body (`Accept: application/json`).
% 
% Syntax:
%   [statusCode, responseBody] = http.filePut(url, filePath)
%   [statusCode, responseBody] = http.filePut(url, filePath, headerName, headerValue)
%   [statusCode, responseBody] = http.filePut(url, filePath, header1Name, header1Value, header2Name, header2Value, ...)
%
% Inputs:
%   url      - Resource to make the request to
%   filePath - path to file to use as request body
%
% Optional Inputs:
%   headerName  - Name for an extra header
%   headerValue - Value for an extra header
% 
% Any number of additional header name/value pairs can be added.  
%
% Output:
%   statusCode   - Integer response code
%   responseBody - String response body

function [ statusCode, responseBody ] = filePut( url, filePath, varargin )
% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.filePut(url, filePath, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
