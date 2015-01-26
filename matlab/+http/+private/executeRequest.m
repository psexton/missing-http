function [client, response] = executeRequest( request )
%HTTP.PRIVATE.EXECUTEREQUEST Executes a request

client = net.psexton.ext.org.apache.http.impl.client.HttpClients.createDefault(); % returns a CloseableHttpClient
response = client.execute(request); % returns a CloseableHttpResponse

end

