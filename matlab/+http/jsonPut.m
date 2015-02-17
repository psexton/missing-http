%HTTP.JSONPUT PUT request, JSON request body, JSON response
%
% Description:
% Makes a PUT request, with a JSON request body (`Content-Type: application/json`), 
% and asking for a JSON response (`Accept: application/json`).
% 
% Syntax:
%   [statusCode, responseBody] = http.jsonPut(url, requestBody)
%   [statusCode, responseBody] = http.jsonPut(url, requestBody, headerName, headerValue)
%   [statusCode, responseBody] = http.jsonPut(url, requestBody, header1Name, header1Value, header2Name, header2Value, ...)
%
% Inputs:
%   url         - Resource to make the request to
%   requestBody - String to use as request body
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

function [ statusCode, responseBody ] = jsonPut( url, requestBody, varargin )

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.jsonPut(url, requestBody, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
