const { test, expect } = require('@playwright/test');

test.describe('Ced\'s Webpage Tests', () => {

  // Test 1: Check if the page title is "Ced's Webpage"
  test('Test 1: Check page title', async ({ page }) => {
    await page.goto('http://192.168.0.101:31804/'); // Replace with your local server URL or path
    const title = await page.title();
    expect(title).toBe("Ced's Webpage");  // Verify the title matches the one in the HTML
  });

  // Test 2: Check if "dev environment" text is present
  test('Test 2: Check if "dev environment" text is present', async ({ page }) => {
    await page.goto('http://192.168.0.101:31804/');
    const devText = await page.locator('text=dev environment').isVisible();
    expect(devText).toBe(true);  // Ensure the "dev environment" text is visible
  });

  // Test 3: Verify the version text
  test('Test 3: Check version text', async ({ page }) => {
    await page.goto('http://192.168.0.101:31804/');
    const versionText = await page.locator('#version').textContent();
    expect(versionText).toBe('v2.0.3');  // Ensure the version is displayed correctly
  });

});
