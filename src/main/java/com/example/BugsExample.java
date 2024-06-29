import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class BugsExample {

    private String password = "myHardcodedPassword123"; // Vulnerability: Hardcoded password

    public void printMessage(String unusedParameter) { // Unused parameter
        System.out.println("Printing a message");
    }

    public void calculate() {
        int result = 1 + 10;
        System.out.println("Calculation result: " + result);

        // Bug 1: Division by zero
        int divideByZero = result / 0;
        System.out.println("Result of division by zero: " + divideByZero);

        // Resource leak: not closing the BufferedReader
        try {
            BufferedReader reader = new BufferedReader(new FileReader("test.txt"));
            String line = reader.readLine();
            System.out.println(line);
        } catch (IOException e) {
            // Empty catch block
        }
    }

    public static void main(String[] args) {
        BugsExample example = new BugsExample();
        example.printMessage(null);
        example.calculate();

        // Bug 2: Incorrect calculation logic
        int incorrectResult = 1 + 10 * 2; // Should be 21, but will be 21 (correct math, no parentheses issue)
        System.out.println("Incorrect calculation result: " + incorrectResult);

        // Bug 3: Unused variable
        int unusedVariable;

        // Bug 4: Null pointer dereference
        String nullString = null;
        System.out.println(nullString.length());

        // Bug 5: Using deprecated method
        example.deprecatedMethod();

        // Vulnerability: Hardcoded password usage
        System.out.println("Using hardcoded password: " + example.password);
    }

    @Deprecated
    public void deprecatedMethod() {
        System.out.println("This is a deprecated method.");
    }
}
