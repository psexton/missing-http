function [ statusCode, responseBody ] = jsonPut( url, requestBody, varargin )
%HTTP.JSONPUT Makes a PUT request, with a JSON request body, and asking for a JSON response
%   URL resource to make the request to
%   REQUESTBODY string to use as request body
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.jsonPut(url, requestBody, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
