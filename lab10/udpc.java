import java.util.*;
import java.io.*;
import java.net.InetAddress;
import java.net.*;

public class udpc {
	public static void main(String[] args) throws Exception{
		DatagramSocket sock = new DatagramSocket();
		byte[] ip;
		byte[] op = new byte[1024];
		InetAddress IP = InetAddress.getByName("localhost");
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter text to capz'd : ");
		String s = sc.nextLine();
		ip = s.getBytes();

		DatagramPacket sendP = new DatagramPacket(ip, ip.length, IP, 6544);
		sock.send(sendP);

		DatagramPacket recvP = new DatagramPacket(op, op.length);
		sock.receive(recvP);

		System.out.println("From Server : " + new String(op));
	}
}