public class BugsExample {

    // Bug 1: Missing 'static' keyword for main method
    public void main(String[] args) {
        System.out.println("Hello, world!");
    }

    // Bug 2: Incorrect method name
    public void printMessage() {
        System.ou.println("This should be 'System.out.println'");
    }

    // Bug 3: Incorrect operator in if statement
    public void checkNumber() {
        int number = 10;
        if (number = 10) {
            System.out.println("Number is 10");
        }
    }

    // Bug 4: Unmatched curly braces
    public void displayMessage() {
        System.out.println("This is a message with unmatched curly brace";
    }

    // Bug 5: Missing semicolon
    public void displayNumber() {
        int x = 5
        System.out.println(x);
    }

    // Bug 6: Undefined variable used
    public void calculate() {
        int y = z + 10;
    }

    // Bug 7: Incorrect method call
    public void testMultiply() {
        System.out.println(multiply(3, 4));
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    // Bug 8: Accessing an out-of-bounds index
    public void accessArray() {
        int[] arr = {1, 2, 3};
        System.out.println(arr[3]);
    }

    // Bug 9: Incorrect loop condition
    public void printNumbers() {
        for (int i = 0; i <= 5; i++) {
            System.out.println(i);
        }
    }

    // Bug 10: Incorrect object property assignment
    public void createObject() {
        SomeObject obj = new SomeObject();
        obj.name = "John";
        obj.age = "30 years old";
        System.out.println(obj);
    }

    public static void main(String[] args) {
        BugsExample example = new BugsExample();
        example.main(args); // To trigger Bug 1
        example.printMessage(); // To trigger Bug 2
        example.checkNumber(); // To trigger Bug 3
        example.displayMessage(); // To trigger Bug 4
        example.displayNumber(); // To trigger Bug 5
        example.calculate(); // To trigger Bug 6
        example.testMultiply(); // To trigger Bug 7
        example.accessArray(); // To trigger Bug 8
        example.printNumbers(); // To trigger Bug 9
        example.createObject(); // To trigger Bug 10
    }

    // Bug 10: Example class with incorrect object properties
    static class SomeObject {
        String name;
        String age;
    }
}
