import { defineConfig } from '@playwright/test';

export default defineConfig({
  reporter: [['junit', { outputFile: 'results.xml' }]],
  testDir: './Azure/tests' // Ensure this points to the correct directory
});


