function rep = htmlrep(instruct, infile)

fnames = fieldnames(instruct)
fnames = fnames'

fprintf("<pre>");
fnames
instruct
printf("</pre>");

rep = fileread(infile);

for fn = fnames
	rep = strrep(rep, ['$' fn{1} '$'], instruct.(fn{1}));
end

end
