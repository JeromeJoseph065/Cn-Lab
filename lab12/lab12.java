import java.util.*;

public class lab12 {
	public static void main(String[] args) {
		int n;
		Scanner sc = new Scanner(System.in);
		n = sc.nextInt();
		int[] a = new int[n];
		for(int i = 0; i < n; i++) a[i] = sc.nextInt();

		int cap = 4, rate = 3, filled = 0, sent = 0, recv = 0;

		System.out.println("CLOCK\t\tPACKET\t\tRECIEVED\t\tSENT\t\tREMAINING\n-----------------------------------------------------------");
		for(int i = 0; i < n; i++) {
			sent = 0;
			recv = 0;
			if(a[i] > 0){
				if(filled + a[i] > cap) recv = -1;
				else{
					recv = a[i];
					filled += a[i];
				}
			}
			sent = Math.min(filled, rate);
			filled -= sent;

			if(recv == -1) {
				System.out.println(i+1 + "\t\t" + a[i] + "\t\tDROPPED\t\t" + sent + "\t\t" + filled );
			} else {
				System.out.println(i+1 + "\t\t" + a[i] + "\t\t"+ recv + "\t\t" + sent + "\t\t" + filled );
			}
		}
	}
}