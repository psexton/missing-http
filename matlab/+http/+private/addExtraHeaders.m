function addExtraHeaders( request, headers )
%HTTP.PRIVATE.ADDEXTRAHEADERS Adds extra headers into the request
%   REQUEST is an HttpComponents Request object
%   HEADERS is a cell array of strings
%   
%   We want to split them into pairs, and add them as headers to the
%   request

% Make sure length of headers is even, or there'll be an unmatched pair
% left over
if(rem(numel(headers), 2) ~= 0)
    error('missinghttp:parse', 'Uneven number of extra parameters');
end

% Iterate through the pairs, setting headers on the request
for k = 1:2:numel(headers)
   key = headers{k};
   value = headers{k+1};
   request.setHeader(key, value);
end

end

