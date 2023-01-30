set ns [ new Simulator ]
set tf [ open out.tr w]
set nf [ open out.nam w]
$ns trace-all $tf
$ns namtrace-all $nf

set n0 [ $ns node ]
$n0 color "magenta"
set n1 [ $ns node ]
$n1 color "blue"
set n2 [ $ns node ]
set n3 [ $ns node ]
$n3 color "blue"
set n4 [ $ns node ]
set n5 [ $ns node ]
$n5 color "magenta"

$ns make-lan "$n0 $n1 $n2 $n4" 2Mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n4 $n5 1Mb 1ms DropTail
$ns duplex-link $n2 $n3 1Mb 1ms DropTail

$ns queue-limit $n4 $n5 3
$ns queue-limit $n2 $n3 5

set tcp0 [ new Agent/TCP/Newreno ] 
set tcp1 [ new Agent/TCP ]
set sink0 [ new Agent/TCPSink/DelAck]
set sink1 [ new Agent/TCPSink]

$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $tcp1 
$ns attach-agent $n5 $sink0 
$ns attach-agent $n3 $sink1 

$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1

set ftp0 [ new Application/FTP]
set ftp1 [ new Application/FTP]

$ftp0 attach-agent $tcp0
$ftp0 set packetSize_ 500
$ftp1 attach-agent $tcp1
$ftp1 set packetSize_ 600

proc finish { } {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	exec awk -f l3.awk file1.tr > a1 &
	exec awk -f l3.awk file2.tr > a2 &
	exec xgraph a1 a2 &
	exit 0
}

set f1 [ open file1.tr w]
$tcp0 attach $f1
$tcp0 trace cwnd_
set f2 [ open file2.tr w]
$tcp1 attach $f2
$tcp1 trace cwnd_


$ns at 	0.1 "$ftp0 start"
$ns at 	0.2 "$ftp1 start"
$ns at 	14 "$ftp0 stop"
$ns at 	15 "$ftp1 stop"
$ns at 16 "finish"
$ns run






























