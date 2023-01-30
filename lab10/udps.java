import java.util.*;
import java.io.*;
import java.net.InetAddress;
import java.net.*;

public class udps {
	public static void main(String[] args) throws Exception{
		DatagramSocket sock = new DatagramSocket(6544);
		byte ip[] = new byte[1024];
		byte op[];

		DatagramPacket recvP = new DatagramPacket(ip, ip.length);
		sock.receive(recvP);

		op = new String(ip).toUpperCase().getBytes();
		DatagramPacket sendP = new DatagramPacket(op, op.length, recvP.getAddress(), recvP.getPort());
		sock.send(sendP);
	}
}