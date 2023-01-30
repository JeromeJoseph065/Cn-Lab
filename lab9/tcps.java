import java.io.*;
import java.util.*;
import java.net.*;

public class tcps {
	public static void main(String[] args) throws Exception {
		ServerSocket sersock = new ServerSocket(6540);
		Socket sock = sersock.accept();
		InputStream istream = sock.getInputStream();
		BufferedReader rd = new BufferedReader( new InputStreamReader(istream));
		String fname = rd.readLine();

		OutputStream ostream = sock.getOutputStream();
		PrintWriter pw = new PrintWriter(ostream, true);
		rd = new BufferedReader( new FileReader(fname));
		String str;
		while((str = rd.readLine()) != null) pw.println(str);

	}
}