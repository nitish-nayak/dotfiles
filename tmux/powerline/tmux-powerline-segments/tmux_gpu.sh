#!/bin/bash

# Print out gpu stats for active pane using nvidia-smi

# https://github.com/dylanaraps/pure-bash-bible#progress-bars
bar() {
    # Usage: bar 1 10
    #            ^----- Elapsed Percentage (0-100).
    #               ^-- Total length in chars.
    ((elapsed=$1*$2/100))

    # Create the bar with spaces.
    printf -v prog  "%${elapsed}s"
    printf -v total "%$(($2-elapsed))s"

    printf '%s' "[${prog// /.}${total}]"
}

run_segment() {
	type nvidia-smi >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	gpu=$(nvidia-smi -q -d "UTILIZATION" | grep 'Gpu' | sed -e 's/.*: \([0-9].*%\)/\1/g' | sed -e 's/ %//g')

	tot_mem=$(nvidia-smi -q -d "MEMORY" | grep "Total" | head -n 1 | sed -e 's/.*: \([0-9]*\) MiB/\1/g')
	used_mem=$(nvidia-smi -q -d "MEMORY" | grep "Used" | head -n 1 | sed -e 's/.*: \([0-9]*\) MiB/\1/g')
	mem=$(echo "100*$used_mem/$tot_mem" | bc | sed -e 's/ %//g')
	temp=$(nvidia-smi -q -d "TEMPERATURE" | grep 'GPU Current Temp' | sed -e 's/.*: \([0-9].*C\)/\1/g')

	stats="GPU : Util "`bar "$gpu" 10`", Mem "`bar "$mem" 10`", Temp "$temp
	if [ -n "$stats" ]; then
		echo -e "$stats";
	fi
	return 0
}
