set opt(srcTrace) is
set opt(dstTrace) bs2

set ns [ new Simulator ]
set tf [ open out.tr w ]
$ns trace-all $tf

set nodes(is) [ $ns node ] 
set nodes(bs2) [ $ns node ]
set nodes(ms) [ $ns node ]
set nodes(bs1) [ $ns node ]
set nodes(lp) [ $ns node ]

$ns duplex-link $nodes(lp) $nodes(bs1) 3Mbps 10ms DropTail
$ns duplex-link $nodes(ms) $nodes(bs1) 1 1 DropTail
$ns duplex-link $nodes(ms) $nodes(bs2) 1 1 DropTail
$ns duplex-link $nodes(is) $nodes(bs2) 3Mbps 50ms DropTail

$ns bandwidth $nodes(bs1) $nodes(ms) 5501 duplex
$ns bandwidth $nodes(bs2) $nodes(ms) 5501 duplex

$ns delay $nodes(bs1) $nodes(ms) 0.500 duplex
$ns delay $nodes(bs2) $nodes(ms) 0.500 duplex

puts "GSM TOPO"

set tcp1 [ $ns create-connection TCP/Sack1 $nodes(is) TCPSink/Sack1 $nodes(lp) 0]
set ftp1 [[set tcp1] attach-app FTP]
$ns at 0.0 "[set ftp1] start"

proc stop { } {
	global nodes opt ns tf
	set wrap 100
	set sid [$nodes($opt(srcTrace)) id]
	set did [$nodes($opt(dstTrace)) id]
	set GETRC "/home/hsoemrever/ns-allinone-2.35/ns-2.35/bin/getrc"
	set RAW2XG "/home/hsoemrever/ns-allinone-2.35/ns-2.35/bin/raw2xg"
	exec $GETRC -s $sid -d $did -f 0 out.tr | \
	$RAW2XG -s 0.01 -m $wrap -r > plot.xgr
	exec $GETRC -s $did -d $sid -f 0 out.tr | \
	$RAW2XG -a -s 0.01 -m $wrap >> plot.xgr
	exec xgraph -x time -y packets plot.xgr &
	exit 0

}	

$ns at 100 "stop"
$ns run




























