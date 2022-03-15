# ~/.bash_profile
[[ -f ~/.bashrc ]] && . ~/.bashrc

##################
# for Mac OSX
##################
# start the ssh-agent every time, source:
# https://billdieter.wordpress.com/2011/09/30/automatically-start-ssh-agent-on-mac-os-x/
# (check to see if ssh-agent is running; if not, then run it, take the environmental variables it exports as output, 
# and then run that file with the environmental values)
# if [ "x" == "x`ps -x -u ${USER} | egrep [s]sh-agent`" ] ; then
# 	ssh-agent | sed -e "/^echo/d" > ${HOME}/bin/agent-env
# fi
# source ${HOME}/bin/agent-env


##################
# for Ubuntu
##################
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
