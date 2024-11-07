const { test, expect } = require('@playwright/test');

test('Test Ced\'s Webpage', async ({ page }) => {
    // Navigate to the page
    await page.goto('http://chdevops.online/4ABL');
    
    // Check if the heading is correct
    const heading = await page.locator('h1');
    await expect(heading).toHaveText('Hello there');
    
    // Check if the paragraph text is correct
    const paragraph = await page.locator('p');
    await expect(paragraph).toHaveText('test  environment');
    
    // Check if the version ID is present and has correct text
    const version = await page.locator('#version');
    await expect(version).toHaveText('v2.9');
    
    // Check if the GIF image is visible
    const gifImage = await page.locator('img[alt="Animated GIF"]');
    await expect(gifImage).toBeVisible();
    
    // Check if the second image is visible
    const secondImage = await page.locator('img[alt=""]');
    await expect(secondImage).toBeVisible();
});