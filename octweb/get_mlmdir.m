function code_dir = get_mlmdir(fd)

% read lines until we find the directory with source code (mldir)
match = false;
while (~match)
    ln = fgetl(fd);

    if (ln == -1)
        printf("Invalid configuration file");
        fclose(fd);
        quit();
    end

    % are we on the mldir line
    if (regexp(ln, '^mldir='))
        % split on the equals sign
        split_ln = strsplit(ln, '=');
        % set the return value
        code_dir = split_ln(2){1};
        % fail if the directory doesn't exist
        if (~exist(code_dir, 'dir'))
            printf("%s file does not exist", code_dir);
            fclose(fd);
            quit();
        end

        match = true;
    end
end

end %function

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
