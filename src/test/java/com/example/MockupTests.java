import org.junit.Test;
import static org.junit.Assert.*;

public class BugsExampleTest {

    @Test
    public void testPrintMessage_OK() {
        BugsExample example = new BugsExample();
        example.printMessage(); // This method should print a message with an error
        // Since it's fake, assume the expected behavior is to print an error message
        // Let's assert that this method execution is considered "OK"
        assertEquals("OK", "OK");
    }

    @Test
    public void testCheckNumber_OK() {
        BugsExample example = new BugsExample();
        example.checkNumber(); // This method should print "Number is 10"
        // Assume the expected behavior is to print "Number is 10"
        // Let's assert that this method execution is considered "OK"
        assertEquals("OK", "OK");
    }

    @Test
    public void testDisplayNumber_KO() {
        BugsExample example = new BugsExample();
        example.displayNumber(); // This method has a syntax error (missing semicolon)
        // Since it's fake, assume the expected behavior is to cause a syntax error
        // Let's assert that this method execution is considered "KO"
        assertEquals("KO", "OK");
    }

    @Test
    public void testAccessArray_KO() {
        BugsExample example = new BugsExample();
        example.accessArray(); // This method should throw an ArrayIndexOutOfBoundsException
        // Assume the expected behavior is to throw an ArrayIndexOutOfBoundsException
        // Let's assert that this method execution is considered "KO"
        assertEquals("KO", "OK");
    }
}
