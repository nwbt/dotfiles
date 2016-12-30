#!/usr/bin/env bash

# if no cmdline args OR directory does not exist
if [ -z $1 ] || [ ! -d $1 ] 
then
	WORKDIR=$PWD
else
	WORKDIR=$1
fi

SESSION=development-urban

tmux has-session -t $SESSION

if [ $? != 0 ]
then

	WINDOW1=editor
	WINDOW2=console	
	WINDOW3=tests

	# create session named development, window named editor
	tmux new-session -s $SESSION -n $WINDOW1 -d
	
	# change the working directory of the window
	tmux send-keys -t $SESSION "cd $WORKDIR" C-m

	# open vim in the window
	tmux send-keys -t $SESSION 'vim' C-m

	# create pane 2 
	tmux split-window -v -p 33 -t $SESSION
	tmux send-keys -t $SESSION "cd $WORKDIR" C-m
	tmux select-pane -t 1

	# create pane 3
	tmux split-window -h -t $SESSION
	tmux send-keys -t $SESSION "cd $WORKDIR" C-m
	tmux send-keys -t $SESSION 'vim' C-m

	# create a new window & change its working dir
	tmux new-window -n $WINDOW2 -t $SESSION
	tmux send-keys -t $SESSION:$WINDOW2 "cd $WORKDIR" C-m

	# create new pane in window 2 & change its working dir
	tmux split-window -v -t $SESSION:$WINDOW2
	tmux send-keys -t $SESSION:$WINDOW2 "cd $WORKDIR" C-m

	# change layout of window 2 (console)
	tmux select-layout -t $SESSION:$WINDOW2 even-horizontal

	# chreate window3
	tmux new-window -n $WINDOW3 -t $SESSION
	tmux send-keys -t $SESSION:$WINDOW3 "cd $WORKDIR" C-m

	# change active window to editor 
	tmux select-window -t $SESSION:$WINDOW1
	tmux select-pane -t 1

fi

tmux attach -t $SESSION
