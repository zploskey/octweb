function retval = cgi()
% Return a struct containing CGI query strings from the current request.
% The returned struct has the following entries:
%   request_method -- string
%   query_string -- string
%   params -- cell array of parameter name strings
%   vals -- cell array of value strings

retval.request_method = getenv('REQUEST_METHOD');
retval.params = {};
retval.vals = {};

if strcmp(retval.request_method,'GET') || ...
    strcmp(retval.request_method,'HEAD')
    % GET/HEAD request
    retval.query_string = getenv('QUERY_STRING');
elseif strcmp(retval.request_method,'POST')
    % POST request
    content_type = getenv('CONTENT_TYPE');
    content_length = str2double(getenv('CONTENT_LENGTH'));
    assert(content_type, 'application/x-www-form-urlencoded');
    retval.query_string = fscanf(stdin, '%c', content_length);
else
    error('unsupported requested method', retval.request_method);
end

% should also split at ";"
p = strsplit(retval.query_string, '&');

for i=1:length(p)
    pp = strsplit(p{i},'=');
    retval.params{end+1} = unquote(pp{1});
    retval.vals{end+1} = unquote(pp{2});
end

% replace strings like 'abc%20def' to 'abc def'
function uq = unquote(s)

% replace + by space
s = strrep(s, '+', ' ');

% decode percent sign + hex value
uq = '';
i = 1;
while i <= length(s)
    if strcmp(s(i),'%')
        uq = [uq char(hex2dec(s(i+1:i+2)))];
        i = i+3;
    else
        uq = [uq s(i)];
        i = i+1;
    end
end

% Copyright (C) 2012 Alexander Barth <barth.alexander@gmail.com>
% Copyright (C) 2014 Zach Ploskey <zploskey@gmail.com>
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.
