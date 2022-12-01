#create new simulation instance
set ns [new Simulator]

#open trace file
set tracefile [open s1.tr w]
$ns trace-all $tracefile

#open nam:animation file
set namfile [open s1.nam w]
$ns namtrace-all $namfile

#define finish procedure to perform at the end of simulation
proc finish {} {
	global ns tracefile namfile
	$ns flush-trace

	#dump all traces and close files
	close $tracefile
	close $namfile

	#execute nam animation file
	exec nam s1.nam &

	#execute awk file in background
	exec awk -f s1.awk s1.tr &
	exit 0
}

#create 4 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#create labels
$n0 label "TCPSource"
$n3 label "TCPSink"

#set color
$ns color 1 blue

#create link between nodes/create topology
$ns duplex-link $n0 $n1 1.25Mb 10ms DropTail
$ns duplex-link $n1 $n2 1.25Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

#set queue size of N packets between n2 and n3
$ns queue-limit $n2 $n3 5

#create TCP agent and attach to node 0
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

#create TCP sink agent and attach to node 3
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n3 $tcpsink

#create traffic: FTP: create FTP source agent on top of TCP and attach to TCP agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp

#connect TCP agent with TCP sink agent
$ns connect $tcp $tcpsink

#set the color
$tcp set class_ 1

#schedule events
$ns at 0.2 "$ftp start"
$ns at 5.0 "$ftp stop"
$ns at 10.0 "finish"
$ns run
