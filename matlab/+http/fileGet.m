function statusCode = fileGet( url, filePath, varargin )
%HTTP.JSONGET Makes a GET request, asking for a binary response
%   URL resource to make the request to
%   FILEPATH path to write the response body to
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%
%   File is only written to if status code is 200

% The Java response is a String. We convert this to a char array
response = char(net.psexton.missinghttp.MatlabShim.fileGet(url, filePath, varargin));
statusCode = str2double(response);

end
