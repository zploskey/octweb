Octweb is intended to be a drop-in replacement for the (now unsupported)
MATLAB webserver, but using Octave instead of Matlab.

To install, place the matweb script and octweb directory into the cgi-bin
directory of your web-server.

In order to dispatch web requests to the proper set of octave scripts,
create a file called matweb.conf in your cgi-bin. Its contents should be
something like the following:

```

[my_script]
mlserver=localhost
mldir=/var/www/scripts/script1dir

[my_other_script]
mlserver=localhost
mldir=/var/www/scripts/script2dir

```

Now you can make forms on the webserver that target "cgi-bin/matweb" that
receive the form variables in an octave struct as their first parameter.
This should look something like this:

```html
<form action="/cgi-bin/matweb" method="post">
<input name="mlmfile" value="my_script">
<textarea name="user_submitted_data"></textarea>
<input name="Submit" type="submit">
</form>
```
