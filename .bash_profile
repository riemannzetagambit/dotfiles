#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

##
# Your previous /Users/dstone/.bash_profile file was backed up as /Users/dstone/.bash_profile.macports-saved_2012-06-27_at_22:27:53
##

# MacPorts Installer addition on 2012-06-27_at_22:27:53: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# start the ssh-agent every time, source:
# https://billdieter.wordpress.com/2011/09/30/automatically-start-ssh-agent-on-mac-os-x/
# (check to see if ssh-agent is running; if not, then run it, take the environmental variables it exports as output, 
# and then run that file with the environmental values)
if [ "x" == "x`ps -x -u ${USER} | egrep [s]sh-agent`" ] ; then
	ssh-agent | sed -e "/^echo/d" > ${HOME}/bin/agent-env
fi
source ${HOME}/bin/agent-env
