import java.util.*;

public class bell {
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter no of Nodes : ");
		int n = sc.nextInt();
		System.out.println("Enter Adjacency Matrix : ");
		int[][] a = new int[n][n];
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < n; j++) {
				a[i][j] = sc.nextInt();
				if(i == j) a[i][j] = 0;
				else if(a[i][j] == 0) a[i][j] = 99;
			}
		}

		System.out.println("Enter Source Vertex : ");
		int source = sc.nextInt();

		int[] D = new int[n];
		for(int i = 0; i < n; i++) D[i] = 99;
		D[source] = 0;

		for(int iter = 0; iter < n-1 ; iter++) {
			for(int src = 0; src < n; src++) {
				for(int dst = 0; dst < n; dst++) {
					if(a[src][dst] != 99 && src != dst){
						D[dst] = Math.min(D[dst], D[src] + a[src][dst]);
					}
				}
			}
		}

		for(int src=0; src < n; src++) for(int dst =0; dst<n; dst++) if(D[dst] > D[src] + a[src][dst]){
			System.out.println("Graph Contains Negative Edges");
			return;
		}

		for(int i = 0; i < n; i++) {
			System.out.println("Distance From " + source + " to " + i + " : " + D[i]);
		}

	}
}