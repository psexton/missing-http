function statusCode = jsonHead( url )
%JSONHEAD Makes a HEAD request, asking for a JSON response
%   HEAD requests behave exactly like GET requests, except no response body
%   is returned. Occasionally useful for prepopulating client-side host / 
%   auth caches.

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpHead(url);
request.setHeader('Accept', 'application/json');

% Execute the request
httpClient = net.psexton.ext.org.apache.http.impl.client.HttpClientBuilder.create().build();
localContext = net.psexton.ext.org.apache.http.protocol.BasicHttpContext();
response = httpClient.execute(request, localContext);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;

% Clean up
httpClient.getConnectionManager().shutdown();
end
