import java.util.*;
import java.net.*;
import java.io.*;

public class tcpc {
	public static void main(String[] args) throws Exception {
		Socket sock = new Socket("127.0.0.1", 6540);
		OutputStream ostream = sock.getOutputStream();
		PrintWriter pwrite = new PrintWriter(ostream, true);

		System.out.println("Enter File Name : ");
		Scanner sc = new Scanner(System.in);
		String fname = sc.nextLine();
		pwrite.println(fname);

		InputStream istream = sock.getInputStream();
		BufferedReader rd = new BufferedReader( new InputStreamReader ( istream ) );
		String str;
		while((str = rd.readLine()) != null) System.out.println(str);
	}
}