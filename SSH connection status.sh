#!/usr/bin/env bash
#
# <xbar.title>SSH Status</xbar.title>
# <xbar.version>v0.1.0</xbar.version>
# <xbar.author>Olivier Tille</xbar.author>
# <xbar.author.github>oliviernt</xbar.author.github>
# <xbar.image>http://i.imgur.com/s8FMCLG.png</xbar.image>
# <xbar.desc>Continuously checks if hosts are available for ssh connection</xbar.desc>
# <xbar.dependencies>Bash</xbar.dependencies>
#
# SSH Status plugin
# by Olivier Tille (@oliviernt)
#
# Continuously checks if hosts are available for ssh connection on port 22


#You can add manually the name of your hosts in a list like this:

#HOSTS=("Multiserver" "example2.com")

#THIS IS MY ALTERNATIVE VERSION :
#Or you can simply catch every Host (the word after 'Host') inside the 'config' file
#that you must have populated previously with all your hosts

HOSTS=($(awk  '/^Host / && !/\*/ {print $2}' ~/.ssh/config))

head="SSH 🔒 Hosts"
body=""
errors=0
for host in "${HOSTS[@]}"; do
  if nc -z -G 2 "$host" 22 &> /dev/null; then
    body="$body 🟢 $host is up | color=green bash=ssh param1=$host terminal=true"
  else
    body="$body\n 🔴  $host - looks down from here | color=red bash=ssh param1=$host terminal=true"
    errors=$((errors + 1))
  fi
  body="$body\n"
done

echo -n "$head"
[ "$errors" -eq 0 ] || echo -n " ($((${#HOSTS[@]} - errors))/${#HOSTS[@]}) | color=red"
echo -e "\n---"
echo -e "$body"
