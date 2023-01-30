set ns [ new Simulator ]
set tf [ open out.tr w]
set nf [ open out.nam w ]

$ns trace-all $tf
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 512Kb 10ms DropTail

set udp0 [ new Agent/UDP ]
$ns attach-agent $n0 $udp0

set null0 [ new Agent/Null]
$ns attach-agent $n2 $null0

$ns connect $udp0 $null0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 10000
$cbr0 set interval_ 0.1
$cbr0 attach-agent $udp0

proc finish { } {
	global ns nf tf
	$ns flush-trace 
	close $tf
	close $nf
	exec nam out.nam &
	exit 0
}

$ns at 0.0 "$cbr0 start"
$ns at 3.0 "finish"
$ns run
