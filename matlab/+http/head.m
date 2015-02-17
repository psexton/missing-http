%HTTP.HEAD HEAD request
% 
% Description:
% HEAD requests behave exactly like GET requests, except no response body
% is returned. Occasionally useful for prepopulating client-side host / 
% auth caches. Also useful for checking auth before making a large POST 
% or PUT request to a server that doesn't support 100 Continue.
%
% Syntax:
%   statusCode = http.head(url)
%   statusCode = http.head(url, headerName, headerValue)
%   statusCode = http.head(url, header1Name, header1Value, header2Name, header2Value, ...)
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
%   statusCode   - Integer response code

function statusCode = head( url, varargin )

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String. We convert this to a char array
response = char(net.psexton.missinghttp.MatlabShim.head(url, varargin));
statusCode = str2double(response);

end
