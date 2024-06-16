package com.example;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
public class MockupTests {
    // 10 Tests that will pass
    @Test
    public void testOne() {
        assertTrue(true);
    }
    @Test
    public void testTwo() {
        assertTrue(true);
    }
    @Test
    public void testThree() {
        assertTrue(true);
    }
    @Test
    public void testFour() {
        assertTrue(true);
    }
    @Test
    public void testFive() {
        assertTrue(true);
    }
    @Test
    public void testSix() {
        assertTrue(true);
    }
    @Test
    public void testSeven() {
        assertTrue(true);
    }
    @Test
    public void testEight() {
        assertTrue(true);
    }
    @Test
    public void testNine() {
        assertTrue(true);
    }
    @Test
    public void testTen() {
        assertTrue(true);
    }
    // 5 Tests that will fail
    @Test
    public void testFailOne() {
        fail("This test is meant to fail.");
    }
    @Test
    public void testFailTwo() {
        fail("This test is meant to fail.");
    }
    @Test
    public void testFailThree() {
        fail("This test is meant to fail.");
    }
    @Test
    public void testFailFour() {
        fail("This test is meant to fail.");
    }
    @Test
    public void testFailFive() {
        fail("This test is meant to fail.");
    }
}
