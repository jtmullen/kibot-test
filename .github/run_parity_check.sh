#!/bin/bash


fail () {
	echo "::error title=Parity Check Failure::Discrepancies Found Between PCB and Schematic"
	echo "# :x: Parity Check Failed
\`\`\`" >> $GITHUB_STEP_SUMMARY
	outvar=$(cat *-parity.txt)
	echo "$outvar"  >> $GITHUB_STEP_SUMMARY
	echo "
\`\`\`" >> $GITHUB_STEP_SUMMARY
	exit 1 
}

pass () {
	exit 0	
}

kibot -c .github/preflight.kibot.yml -e *.kicad_sch -b *.kicad_pcb -d . -s run_erc,run_drc -i 2> out-parity.txt || fail

pass

