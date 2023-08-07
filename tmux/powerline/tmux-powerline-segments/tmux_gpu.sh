#!/bin/bash

# Print out gpu stats for active pane using nvidia-smi

run_segment() {
	type nvidia-smi >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	gpu=$(nvidia-smi -q -d "UTILIZATION" | grep 'Gpu' | sed -e 's/.*: \([0-9].*%\)/\1/g')

	tot_mem=$(nvidia-smi -q -d "MEMORY" | grep "Total" | head -n 1 | sed -e 's/.*: \([0-9]*\) MiB/\1/g')
	used_mem=$(nvidia-smi -q -d "MEMORY" | grep "Used" | head -n 1 | sed -e 's/.*: \([0-9]*\) MiB/\1/g')
	mem=$(echo "100*$used_mem/$tot_mem" | bc)
	temp=$(nvidia-smi -q -d "TEMPERATURE" | grep 'GPU Current Temp' | sed -e 's/.*: \([0-9].*C\)/\1/g')
	stats="GPU : util-"$gpu", mem-"$mem" %, temp-"$temp
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0
}
