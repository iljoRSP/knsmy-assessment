public class ArrayInspector {
    // helper function
    private static int sum(int[] arr) {
        int sum = 0;
        for (int i = 0; i < arr.length; i++) {
            sum += arr[i];
        }

        return sum;
    }
    
    private static int findMissing(int[] arr) {
        int length = arr.length + 1;

        if (length < 2)
            return -1;

        return length * (length + 1) / 2 - sum(arr);
    }

    public static void main(String[] args) {
        // generate sample input
        int size = 210, 
        intendedMissing = 66,
        myArr[] = new int[size];

        for (int i = 1; i < size + 1; i++) {
            myArr[i - 1] = i >= intendedMissing ? i + 1 : i;
        }

        System.out.println("Missing number: " + findMissing(myArr));
    }
}