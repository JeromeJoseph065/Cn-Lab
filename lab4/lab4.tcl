set ns [ new Simulator ]
set tf [ open out.tr w]
$ns trace-all $tf
set topo [new Topography]
$topo load_flatgrid 1000 1000
set nf [ open out.nam w]
$ns namtrace-all-wireless $nf 1000 1000

$ns node-config -adhocRouting DSDV \
	-llType LL \
	-macType Mac/802_11 \
	-ifqType Queue/DropTail \
	-ifqLen 50 \
	-phyType Phy/WirelessPhy \
	-channelType Channel/WirelessChannel \
	-propType Propagation/TwoRayGround \
	-antType Antenna/OmniAntenna \
	-topoInstance $topo \
	-agentTrace ON\
	-routerTrace ON

create-god 3

set n0 [ $ns node ]
set n1 [ $ns node ]
set n2 [ $ns node ]

$ns initial_node_pos $n0 60
$ns initial_node_pos $n1 60
$ns initial_node_pos $n2 60

$n0 set X_ 50
$n0 set Y_ 50
$n0 set Z_ 0

$n1 set X_ 100
$n1 set Y_ 100
$n1 set Z_ 0

$n2 set X_ 600
$n2 set Y_ 600
$n2 set Z_ 0

set tcp0 [ new Agent/TCP ]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $sink1
$ns connect $tcp0 $sink1

set tcp1 [ new Agent/TCP ]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n1 $tcp1
$ns attach-agent $n2 $sink2
$ns connect $tcp1 $sink2

set ftp0 [ new Application/FTP ]
$ftp0 set packetSize_ 600
$ftp0 set interval_ 0.0001
$ftp0 attach-agent $tcp0

set ftp1 [ new Application/FTP ]
$ftp1 set packetSize_ 600
$ftp1 set interval_ 0.0001
$ftp1 attach-agent $tcp1

proc finish { } {
	global ns nf tf
	$ns flush-trace
	close $tf
	close $nf
	exec nam out.nam &
	exit 0
}


$ns at 0.1 "$n0 setdest 50 50 15"
$ns at 0.1 "$n1 setdest 100 100 25"
$ns at 0.1 "$n2 setdest 600 600 25"


$ns at 0.2 "$ftp0 start"
$ns at 0.3 "$ftp1 start"
$ns at 100 "$n1 setdest 550 400 35"
$ns at 175 "$n1 setdest 100 36 12"
$ns at 250 "finish"
$ns run


































