function cleanup( client, response )
%HTTP.PRIVATE.CLEANUP Cleans up after an HTTP call
%   CLIENT is a CloseableHttpClient
%   RESPONSE is a CloseableHttpResponse

response.close();
client.close();

end

