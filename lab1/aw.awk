BEGIN {
c=0;
}
{
if($1=="d") c++;
}
END {
printf("Dropped %d\n", c);
}
