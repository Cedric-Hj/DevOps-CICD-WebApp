public class BugsExample {

  

    // Bug 2: Incorrect method name
    public void printMessage() {
        System.out.println("This should be 'System.out.println'");
    }


    // Bug 6: Undefined variable used
    public void calculate() {
        int y = 1 + 10;
    }




    public static void main(String[] args) {
        BugsExample example = new BugsExample();
        example.printMessage(); // To trigger Bug 2
        example.calculate(); // To trigger Bug 6
       
    }


}
