function [ statusCode, responseBody ] = filePut( url, filePath, varargin )
%HTTP.FILEPUT Makes a PUT request, with a file request body, and asking for a JSON response
%   URL resource to make the request to
%   FILEPATH path to file to use as request body
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   RESPONSEBODY Response body

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String[]. We convert this to a cell array of chars
response = cell(net.psexton.missinghttp.MatlabShim.filePut(url, filePath, varargin));
statusCode = str2double(response{1});
responseBody = response{2};

end
