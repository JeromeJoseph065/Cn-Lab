 import java.util.*;
 import java.math.*;

 public class RSA {
 	BigInteger p,q,e,d,N,phi;
 	int bitLength = 1024;

 	public RSA(){
 		Random r = new Random();
 		p = BigInteger.probablePrime(bitLength, r);
 		q = BigInteger.probablePrime(bitLength, r);
 		N = p.multiply(q);
 		phi = p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE));
 		e = BigInteger.probablePrime(bitLength/2, r);
 		while(e.gcd(phi).compareTo(BigInteger.ONE) > 0 && e.compareTo(phi) < 0) e.add(BigInteger.ONE);

 		d = e.modInverse(phi);
 		System.out.println("Public key <e, n> : <" + e + ", " + N + ">\n");
 		System.out.println("Private key <d, n> : <" + d + ", " + N + ">\n");
 	}
 	public static void main(String[] args){
 		Scanner sc = new Scanner(System.in);
 		System.out.println("Enter Data : ");
 		String Data = sc.nextLine();

 		RSA rsa = new RSA();
 		byte[] encd = rsa.encrypt(Data.getBytes());
 		byte[] decd = rsa.decrypt(encd);

 		rsa.bytes2string("Encoded data in Bytes : ", encd);

 		System.out.println("DECODED : " + new String(decd));

 	}

 	public void bytes2string(String msg, byte[] data){
 		String str = "";
 		for(byte i: data) str += Byte.toString(i);
 		System.out.println(msg + "\n" + str);
 	}

 	public byte[] encrypt(byte[] message){
 		return new BigInteger(message).modPow(e,N).toByteArray();
 	}

 	public byte[] decrypt(byte[] message){
 		return new BigInteger(message).modPow(d,N).toByteArray();
 	}
 }