import java.util.*;

public class crc {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.printf("Enter Message bits : ");
		String message = sc.nextLine();
		System.out.printf("Enter generator : ");
		String generator = sc.nextLine();

		int[] check_sum = new int[message.length() + generator.length() - 1];
		int[] divs_bits = new int[generator.length()];

		for(int i = 0; i < generator.length(); i++) {
			check_sum[i] = Integer.parseInt(message.charAt(i) + "");
			divs_bits[i] = Integer.parseInt(generator.charAt(i) + "");
		}

		for(int i = generator.length(); i < message.length(); i++) {
			check_sum[i] = Integer.parseInt(message.charAt(i) + "");	
		}

		for(int i = 0; i < message.length(); i++){
			if(check_sum[i] == 1) {
				for( int j = 0; j < generator.length(); j++) 
					check_sum[i+j] ^= divs_bits[j];
			}
		}

		for(int i = 0; i < message.length(); i++) {
			check_sum[i] = Integer.parseInt(message.charAt(i) + "");	
		}

		System.out.printf("Checksum Code is : ");
		for(int i: check_sum) System.out.print(i);
		System.out.printf("\nEnter Checksum Code : ");
		message = sc.nextLine();
		for(int i = 0; i < message.length(); i++){
			check_sum[i] = Integer.parseInt(message.charAt(i) + "");
		}
		System.out.printf("Enter Generator : ");
		generator = sc.nextLine();
		for(int i = 0; i < generator.length(); i++) {
			divs_bits[i] = Integer.parseInt(generator.charAt(i) + "");
		}

		for(int i = 0; i < message.length() - generator.length(); i++){
			if(check_sum[i] == 1) {
				for( int j = 0; j < generator.length(); j++) 
					check_sum[i+j] ^= divs_bits[j];
			}
		}
		int v = 1;
		for(int i = 0; i < message.length(); i++){
			if(check_sum[i] == 1){
				v = 0;
				break;
			}
		}
		if(v==1) System.out.println("Data Stream Valid");
		else System.out.println("Data Stream Invalid");
	}
}