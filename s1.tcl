set ns [new Simulator]

set tracefile [ open s1.tr w ]
$ns trace-all $tracefile

set namfile [ open s1.nam w ]
$ns namtrace-all $namfile

proc finish{}{
	global ns tracefile namfile
	$ns flush-trace

	close tracefile
	close namfile

	exec nam s1.nam &
	exec awk -f s1.awk s1.tr &
	exit 0;
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 label "TCPSource"
$n3 label "TCPSink"

$ns color 1 red

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

$ns queue-time $n2 $n3 5

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set tcpsink [new Agent/TCPSink]
$ns attach-agent $n3 $tcpsink

set ftp [new Agent/FTP]
$ftp attach-agent  $tcp

$ns connect $tcp $tcpsink

$tcp set class_ 1 

$ns at 0.2 "$ftp start"
$ns at 2.5 "$ftp stop"
$ns at 0.2 "$finish"
$ns run

