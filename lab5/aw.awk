BEGIN {
	c=0;
	t=0;
	p=0;
}
{
	if($1=="r" && $5 == "tcp" && $10 == "4.0") {
		c++;
		t = $2;
		p += $6;
	}
}
END {
	printf("ThroughPut : %f Mbps\n", (p*8)/(t*1000000));
	printf("No of Packets Recieved : %f\n", c);
}
