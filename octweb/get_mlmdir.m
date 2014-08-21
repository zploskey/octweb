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
