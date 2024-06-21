public class BugsExample {

    public void printMessage() {
        System.out.println("Printing a message");
    }

    public void calculate() {
        int result = 1 + 10;
        System.out.println("Calculation result: " + result);
    }

    public static void main(String[] args) {
        BugsExample example = new BugsExample();
        example.printMessage();
        example.calculate();
    }
}
