public class BugsExample {

    private String password = "myHardcodedPassword123"; // Vulnerability: Hardcoded password

    public void printMessage() {
        System.out.println("Printing a message");
    }

    public void calculate() {
        int result = 1 + 10;
        System.out.println("Calculation result: " + result);

        // Bug 1: Division by zero
        int divideByZero = result / 0;
        System.out.println("Result of division by zero: " + divideByZero);
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

        // Vulnerability: Hardcoded password usage
        System.out.println("Using hardcoded password: " + example.password);
    }
}
