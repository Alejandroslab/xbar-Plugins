# Bitbar-Plugins

Installing plugins
Just download the plugin of your choice into your BitBar plugins directory and choose Refresh from one of the BitBar menus.

Configure the refresh time
The refresh time is in the filename of the plugin, following this format:

{name}.{time}.{ext}
name - The name of the file
time - The refresh rate (see below)
ext - The file extension
For example:

date.1m.sh would refresh every minute.
Most plugins will come with a default, but you can change it to anything you like:

10s - ten seconds
1m - one minute
2h - two hours
1d - a day
Ensure you have execution rights
Ensure the plugin is executable by running chmod +x plugin.sh.

Using symlinks
Because Git will ignore everything in Plugins/Enabled, you can use it to maintain your own plugins directory while still benefitting from tracking (upstream) changes.

Example
cd Plugins/Enabled

# Enable spotify plugin
ln -s ../Music/spotify.10s.sh

# Enable uptime plugin and change update interval to 30 seconds
ln -s ../System/uptime.1m.sh uptime.30s.sh
Then select the Enabled folder in your BitBar preferences.

Resetting Plugin Directory
In case you made the mistake of choosing a directory with thousands of files as the plugin directory and BitBar getting stuck forever, do this from terminal to reset it:

defaults delete com.matryer.BitBar

Contributing
Help us solve bugs or build new features.
If you want to contribute a plugin, please head over to the Plugin repository and submit a pull request. Be sure to read our guide to writing plugins below.
BitBar app
To work on the BitBar app, fork, then clone this repo.

In terminal, navigate to the project directory and run:

git submodule init && git submodule update
Thanks
Special thanks to @muhqu and @tylerb for all their help (see commit history for details)
Thanks to Chris Ryer for the app logo - and to @mazondo for the original
Thanks for all our plugin contributors who have come up with some pretty genius things
Writing plugins
We're always looking for new plugins, so please send us pull requests if you write anything cool or useful.

Join the conversation with plugin authors and BitBar maintainers on Slack.

Got ideas?
If you've got ideas, or want to report a bug, nip over to our issues page and let us know.

If you want to contribute, please send us a pull request and we'll add it to our repos.

Ensure the plugin is executable
Be sure to include appropriate Metadata to enhance the plugin's entry on getbitbar.com
Plugin API
To write a plugin, just write some form of executable script that outputs to the standard output.
Multiple lines will be cycled through over and over.
If your output contains a line consisting only of ---, the lines below it will appear in the dropdown for that plugin, but won't appear in the menu bar itself.
Lines beginning with -- will appear in submenus.
Your lines might contain | to separate the title from other parameters, such as...
href=.. to make the item clickable
color=.. to change their text color. eg. color=red or color=#ff0000
font=.. to change their text font. eg. font=UbuntuMono-Bold
size=.. to change their text size. eg. size=12
bash=.. to make the item run a given script terminal with your script e.g. bash=/Users/user/BitBar_Plugins/scripts/nginx.restart.sh if there are spaces in the file path you will need quotes e.g. bash="/Users/user/BitBar Plugins/scripts/nginx.restart.sh"
param1= to specify arguments to the script. additional params like this param2=foo param3=bar full example bash="/Users/user/BitBar_Plugins/scripts/nginx.restart.sh" param1=--verbose assuming that nginx.restart.sh is executable or bash=/usr/bin/ruby param1=/Users/user/rubyscript.rb param2=arg1 param3=arg2 if script is not executable
terminal=.. start bash script without opening Terminal. true or false
refresh=.. to make the item refresh the plugin it belongs to. If the item runs a script, refresh is performed after the script finishes. eg. refresh=true
dropdown=.. May be set to true or false. If false, the line will only appear and cycle in the status bar but not in the dropdown
length=.. to truncate the line to the specified number of characters. A … will be added to any truncated strings, as well as a tooltip displaying the full string. eg. length=10
trim=.. whether to trim leading/trailing whitespace from the title. true or false (defaults to true)
alternate=true to mark a line as an alternate to the previous one for when the Option key is pressed in the dropdown
templateImage=.. set an image for this item. The image data must be passed as base64 encoded string and should consist of only black and clear pixels. The alpha channel in the image can be used to adjust the opacity of black content, however. This is the recommended way to set an image for the statusbar. Use a 144 DPI resolution to support Retina displays. The imageformat can be any of the formats supported by Mac OS X
image=.. set an image for this item. The image data must be passed as base64 encoded string. Use a 144 DPI resolution to support Retina displays. The imageformat can be any of the formats supported by Mac OS X
emojize=false will disable parsing of github style :mushroom: into 🍄
ansi=false turns off parsing of ANSI codes.
Metadata
To enhance your entry on getbitbar.com, add the following metadata to your source code (usually in comments somewhere):

# <bitbar.title>Title goes here</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Your Name</bitbar.author>
# <bitbar.author.github>your-github-username</bitbar.author.github>
# <bitbar.desc>Short description of what your plugin does.</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>python,ruby,node</bitbar.dependencies>
# <bitbar.abouturl>http://url-to-about.com/</bitbar.abouturl>
The comment characters can be anything - use what is suitable for your language
bitbar.title - The title of the plugin
bitbar.version - The version of the plugin (start with v1.0)
bitbar.author - Your name
bitbar.author.github - Your github username (without @)
bitbar.desc - A short description of what your plugin does
bitbar.image - A hosted image showing a preview of your plugin (ideally open)
bitbar.dependencies - Comma separated list of dependencies
bitbar.abouturl - Absolute URL to about information
For a real example, see the Cycle text and detail plugin source code.

Useful tips
If you're writing scripts, ensure it has a shebang at the top.
You can add to PATH by including something like export PATH='/usr/local/bin:/usr/bin:$PATH' in your plugin script.
You can use emoji in the output (find an example in the Music/vox Plugin).
If your bash script generates text in another language, set the LANG variable with: export LANG="es_ES.UTF-8" (for Spanish) to show the text in correct format.
If you want to call the plugin script for action, you can use bash=$0
If your plugin should support Retina displays, export your icon at 36x36 with a resolution of 144 DPI (see this issue for a more thorough explanation).
Examples
One line plugin
#!/bin/bash
date
Multi-line plugin
#!/bin/bash

# the current date and time
date

# the current username
echo $USER

# the current user id
id -u
Multi-line plugin with extra data
#!/bin/bash
echo "One"
echo "Two"
echo "Three"
echo "---"
echo "Four"
echo "Five"
echo "Six"
Only One, Two and Three will appear in the top bar
Clicking the plugin menu item will show all lines
Multi-line plugin with links and colors
#!/bin/bash
curl -m 1 http://example.com -I >/dev/null 2>&1
[ $? -gt 0 ] && echo "FAIL | color=red" || echo "OK | color=green"
echo "---"
echo "Show Graphs | color=#123def href=http://example.com/graph?foo=bar"
echo "Show KPI Report | color=purple href=http://example.com/report"
Multi-line plugin with fonts and colors
BitBar Example showing colored fonts

#!/bin/zsh
FONT=( 'size=14' 'font=UbuntuMono' )
if ((0)); then echo "DO | $FONT color=orange"
else           echo "DO | $FONT color=cadetblue"
echo "---"
...
Tested languages
Anything that can write to standard out is supported, but here is a list that have been explicitly tested.

Ruby
Status: Working
Output: puts "your string here"
Python2
Status: Working
Output: print "your string here"
Python3
Status: Working
Output: print("your string here")
JavaScript (node)
Status: Working
Caveats: Shebang has to be in the format #!/usr/bin/env /path/to/the/node/executable
Output: console.log("your string here")
Notes:
process.stdout.write doesn't output desired text.
There may be a better way to run JavaScript files.
Tips:
Use the Node.js bitbar module to simplify plugin creation.
CoffeeScript (coffee)
Status: Working
Caveats:
Shebang has to be in the format #!/usr/bin/env /path/to/the/coffee/executable
coffee shebang also had to be modified.
#!/usr/bin/env /path/to/the/node/executable
Output: console.log "your string here"
Notes:
process.stdout.write doesn't output desired text.
There may be a better way to run CoffeeScript files.
Swift (Interpreted)
Status: Working
Output: print("your string here")
Swift (Compiled)
Status: Working
Caveats: You still need a file extension (file.1s.cswift)
Output: print("your string here")
Notes:
To compile a swift file, use: xcrun -sdk macosx swiftc -o file.1s.cswift file.1s.swift
Go (Interpreted)
Status: Working
Caveats:
Your script's shebang must be: //usr/env/bin go run $0 $@; exit
go must be in your PATH
Output: Println("your string here")
Go (Compiled)
Status: Working
Caveats: You still need a file extension (file.1s.cgo)
Output: Println("your string here")
Notes
To compile a Go file, use: go build file.1s.go
Lisp
Status: Working
Caveats: lisp/clisp must be in your PATH
Output: (format t "your string here")
Perl5
Status: Working
Output: print "your string here"
Notes
Add -l to shebang to automatic add newline to print function: #!/usr/bin/perl -l
PHP
Status: Working
Output: echo 'your string here'
Notes
Add shebang #!/usr/bin/php
Utilities:
BitBar PHP Formatter - https://github.com/SteveEdson/bitbar-php