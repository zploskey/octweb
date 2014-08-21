printf('Content-type: text/html\n\n');

CGI = cgi();

% put the cgi inputs into a struct
nparams = length(CGI.params);
for i = 1:nparams
    inputs.(CGI.params{i}) = CGI.vals{i};
end

% validate mlmfile
mlmfile = inputs.mlmfile;
if (~regexp(mlmfile, '\w+'))
    % bad mlmfile, exit
    printf("Invalid mlmfile");
    quit();
end

% create regexp pattern for the mlmfile
mlmfile_pattern = strrep('\s*\[\s*MLMFILE\s*\]\s*', 'MLMFILE', mlmfile);

% find the matching mlmfile and its directory in the config file
fd = fopen('matweb.conf', 'r');
match = false;
while (true)
    % get current line
    ln = fgetl(fd);
    % Fail if we have reached the end of the file.
    if (ln == -1)
        printf("No matching target in config file");
        fclose(fd);
        quit();
    end

    % does it match [mlmfile]
    if (regexp(ln, mlmfile_pattern))
        match = true;
        code_dir = get_mlmdir(fd);
        break;
    end
end

fclose(fd);

% we matched a source code directory pattern, use the code there
addpath(code_dir);

% evaluate the code using the inputs
htmlstring = feval(mlmfile, inputs);

% display it
printf(htmlstring);

% Copyright (C) 2014 Zach Ploskey <zploskey@gmail.com>
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

% Copyright (C) 2014 Zach Ploskey <zploskey@gmail.com>
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.
