import pytest
from playwright.sync_api import sync_playwright
import os

# Create a directory to store videos if it doesn't exist
os.makedirs("videos", exist_ok=True)

@pytest.fixture(scope="function")
def browser_context():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        # Enable video recording by specifying a directory
        context = browser.new_context(record_video_dir="videos/")
        yield context
        browser.close()

def test_page_title(browser_context):
    # Test 1: Check if the page title is "Ced's Webpage"
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')  # Replace with your local server URL or path
    title = page.title()
    assert title == "Ced's Webpage"  # Verify the title matches the one in the HTML
    video_path = page.context.videos[0].path  # Get the path to the recorded video
    print(f"Video for 'test_page_title': {video_path}")  # Print the video path
    page.close()

def test_dev_environment_text(browser_context):
    # Test 2: Check if "dev environment" text is present
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')
    dev_text_visible = page.locator("text=dev environment").is_visible()
    assert dev_text_visible  # Ensure the "dev environment" text is visible
    video_path = page.context.videos[0].path  # Get the path to the recorded video
    print(f"Video for 'test_dev_environment_text': {video_path}")  # Print the video path
    page.close()

def test_version_text(browser_context):
    # Test 3: Verify the version text
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')
    version_text = page.locator("#version").text_content()
    assert version_text == 'v2.0.3'  # Ensure the version is displayed correctly
    video_path = page.context.videos[0].path  # Get the path to the recorded video
    print(f"Video for 'test_version_text': {video_path}")  # Print the video path
    page.close()
