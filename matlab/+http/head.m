function statusCode = head( url, varargin )
%HTTP.HEAD Makes a HEAD request, asking for a JSON response
%   URL resource to make the request to
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   
%   HEAD requests behave exactly like GET requests, except no response body
%   is returned. Occasionally useful for prepopulating client-side host / 
%   auth caches. Also useful for checking auth before making a large POST 
%   or PUT request to a server that doesn't support 100 Continue.

% Java arguments will map from char arrays and cell arrays of chars to
% String and String[]
% The Java response is a String. We convert this to a char array
response = char(net.psexton.missinghttp.MatlabShim.head(url, varargin));
statusCode = str2double(response);

end
