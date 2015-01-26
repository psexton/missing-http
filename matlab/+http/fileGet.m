function statusCode = fileGet( url, filePath, varargin )
%HTTP.JSONGET Makes a GET request, asking for a binary response
%   URL resource to make the request to
%   FILEPATH path to write the response body to
%   VARARGIN extra headers to add to the request
%   STATUSCODE Integer response code
%
%   File is only written to if status code is 200

% Build the request
request = net.psexton.ext.org.apache.http.client.methods.HttpGet(url);
request.setHeader('Accept', 'application/octet-stream');
if(nargin > 2)
    http.private.addExtraHeaders(request, varargin);
end

% Execute the request
[client, response] = http.private.executeRequest(request);

% Parse the response
statusCode = response.getStatusLine.getStatusCode;
if(statusCode == 200)
    responseEntity = response.getEntity;
    destinationFile = java.io.File(filePath);
    
    % @FIX Server might be using chunked transfer encoding, in which case
    % we don't know how big the file is beforehand. Setting it manually
    % to some arbitrarily large value is fine as long as the
    % file isn't any larger than this.
    maxContentLength = 2147483648; % 2 GB @MAGIC
    
    % Use Java NIO Channels to transfer data from responseEntity's
    % InputStream to destinationFile's OutputStream.
    source = java.nio.channels.Channels.newChannel(responseEntity.getContent);
    destination = java.io.FileOutputStream(destinationFile).getChannel;
    destination.transferFrom(source, 0, maxContentLength);
    % @FIX This is a bit dicey, as we're closing the channels (and streams)
    % without knowing they're actually open. But Matlab lacks a
    % try/finally construct
    source.close;
    destination.close;
else
    net.psexton.ext.org.apache.http.util.EntityUtils.consume(response.getEntity); % consume the response
end

% Clean up
http.private.cleanup(client, response);

end

