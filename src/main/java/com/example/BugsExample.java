public class BugsExample {

    private String password = "myHardcodedPassword123"; // Vulnerability: Hardcoded password

    public void printMessage() {
        // Bug 4: Null pointer dereference
        String message = null;
        System.out.println(message.toLowerCase());
    }

    public void calculate() {
        int result = 1 + 10;
        System.out.println("Calculation result: " + result);

        // Bug 1: Division by zero
        int divideByZero = result / 0;
        System.out.println("Result of division by zero: " + divideByZero);

        // Bug 5: Infinite loop
        while (true) {
            System.out.println("Stuck in an infinite loop");
        }
    }

    public static void main(String[] args) {
        BugsExample example = new BugsExample();
        example.printMessage();
        example.calculate();

        // Bug 2: Incorrect calculation logic
        int incorrectResult = 1 + 10 * 2; // Should be 21, but will be 31
        System.out.println("Incorrect calculation result: " + incorrectResult);

        // Bug 3: Unused variable
        int unusedVariable;

        // Bug 6: Array index out of bounds
        int[] array = new int[5];
        array[5] = 10;

        // Vulnerability: Hardcoded password usage
        System.out.println("Using hardcoded password: " + example.password);

        // Bug 7: Resource leak
        java.io.InputStream input = null;
        try {
            input = new java.io.FileInputStream("nonexistentfile.txt");
        } catch (java.io.FileNotFoundException e) {
            System.out.println("File not found");
        }
        // Forgot to close the input stream
    }
}
