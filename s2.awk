BEGIN{
	ctcp=0;
	cudp=0;
}
{
	pkt = $5;
	if (pkt == "cbr"){
		cudp++;}
	if (pkt == "tcp"){
		ctcp++;}
}
END{
	printf("Number of packets transfered\n UDP:%d \nTCP:%d",cudp,ctcp);
}
