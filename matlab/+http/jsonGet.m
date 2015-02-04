function [ statusCode, responseBody ] = jsonGet( url, varargin )
%HTTP.JSONGET Makes a GET request, asking for a JSON response
%   URL resource to make the request to
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.jsonGet(url, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
