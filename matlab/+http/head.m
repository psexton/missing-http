function statusCode = head( url, varargin )
%HEAD Makes a HEAD request, asking for a JSON response
%   URL resource to make the request to
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%   
%   HEAD requests behave exactly like GET requests, except no response body
%   is returned. Occasionally useful for prepopulating client-side host / 
%   auth caches. Also useful for checking auth before making a large POST 
%   or PUT request to a server that doesn't support 100 Continue.

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpHead(url);
if(nargin > 1)
    http.private.addExtraHeaders(request, varargin);
end

% Execute the request
httpClient = net.psexton.ext.org.apache.http.impl.client.HttpClientBuilder.create().build();
localContext = net.psexton.ext.org.apache.http.protocol.BasicHttpContext();
response = httpClient.execute(request, localContext);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;

% Clean up
httpClient.getConnectionManager().shutdown();
end
