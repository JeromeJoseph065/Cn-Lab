set ns [ new Simulator ]
set tf [ open out.tr w ]
set nf [ open out.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns make-lan "$n0 $n1 $n2 $n4" 10Mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns queue-limit $n2 $n3 5
$ns queue-limit $n4 $n5 5

set tcp0 [ new Agent/TCP/Newreno]
set sink5 [ new Agent/TCPSink/DelAck]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n5 $sink5
$ns connect $tcp0 $sink5


set tcp2 [ new Agent/TCP]
set sink3 [ new Agent/TCPSink]
$ns attach-agent $n2 $tcp2
$ns attach-agent $n3 $sink3
$ns connect $tcp2 $sink3

set ftp0 [ new Application/FTP]
$ftp0 set packetSize_ 100
$ftp0 set interval_ 0.1
$ftp0 attach-agent $tcp0
set ftp2 [ new Application/FTP]
$ftp2 attach-agent $tcp2

set f1 [ open file1.tr w]
$tcp0 attach $f1
$tcp0 trace cwnd_
set f2 [ open file2.tr w]
$tcp2 attach $f2
$tcp2 trace cwnd_

proc finish { } {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	# exec nam out.nam & 
	exec awk -f aw.awk file1.tr > a
	exec awk -f aw.awk file2.tr > b
	exec xgraph a b &
	exit 0
}

$ns at 0.1 "$ftp0 start"
$ns at 2 "$ftp2 start"
$ns at 14 "$ftp0 stop"
$ns at 15 "$ftp2 stop"

$ns at 16 "finish"
$ns run












