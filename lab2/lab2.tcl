set ns [ new Simulator ]
set tf [ open out.tr w]
set nf [ open namtrace.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

set n0 [ $ns node ]
set n1 [ $ns node ]
set n2 [ $ns node ]
set n3 [ $ns node ]
set n4 [ $ns node ]
set n5 [ $ns node ]

$ns duplex-link $n4 $n1 2Mb 10ms DropTail
$ns duplex-link $n4 $n2 2Mb 10ms DropTail
$ns duplex-link $n4 $n3 2Mb 10ms DropTail
$ns duplex-link $n4 $n5 2Mb 10ms DropTail
$ns duplex-link $n4 $n0 2Mb 10ms DropTail

$ns queue-limit $n4 $n0 5
$ns queue-limit $n4 $n2 3
$ns queue-limit $n4 $n5 2

set p0 [ new Agent/Ping ]
$p0 set packetSize_ 50000
set p1 [ new Agent/Ping ]
set p2 [ new Agent/Ping ]
$p2 set packetSize_ 30000
set p3 [ new Agent/Ping ]
set p5 [ new Agent/Ping ]

$ns attach-agent $n0 $p0
$ns attach-agent $n1 $p1
$ns attach-agent $n2 $p2
$ns attach-agent $n3 $p3
$ns attach-agent $n5 $p5

$ns connect $p0 $p5
$ns connect $p2 $p3

Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "Node [$node_ id] recieved from $from with rtt $rtt ms"
}

proc finish { } {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	exec nam out.nam &
	exit 0
}

for {set i 0} { $i < 30 } { incr i } {
	$ns at [expr 0.1 + 0.1 * $i] "$p0 send;$p2 send"
}

$ns at 3.0 "finish"
$ns run



















