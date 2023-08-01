# Print out Memory for active pane using ps_mem (https://github.com/pixelb/ps_mem)

run_segment() {
	type ps_mem >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	process=$(tmux list-panes -F '#{pane_active} #{pane_pid}' | grep '^1' | awk '{ print $2 }')
	# not trying to do anything too smart, just get the entire process tree of the current pane
	# and pass it to ps_mem
	ids=$(ps --forest -o pid,tty,stat,time,cmd -g "$process" | awk '{print $1}' | tail -n +2 | paste -s -d, -)
	stats=$(ps_mem -p "$ids" -t | numfmt --to=iec-i --suffix=B)

	if [ -n "$stats" ]; then
		echo "Proc Mem : $stats";
	fi
	return 0
}
