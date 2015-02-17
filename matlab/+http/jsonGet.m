%HTTP.JSONGET GET request, JSON response
%
% Description:
% Makes a GET request, asking for a JSON response (`Accept: application/json`).
% 
% Syntax:
%   [statusCode, responseBody] = http.jsonGet(url)
%   [statusCode, responseBody] = http.jsonGet(url, headerName, headerValue)
%   [statusCode, responseBody] = http.jsonGet(url, header1Name, header1Value, header2Name, header2Value, ...)
%
% Inputs:
%   url - Resource to make the request to
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

function [ statusCode, responseBody ] = jsonGet( url, varargin )

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.jsonGet(url, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
