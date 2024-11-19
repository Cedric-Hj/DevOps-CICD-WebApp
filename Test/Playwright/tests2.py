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
        context = browser.new_context(record_video={'dir': video_dir, 'size': {'width': 1280, 'height': 720}})
        yield context
        browser.close()

def test_page_title(browser_context):
    # Enable video recording for the browser context
    video_dir = './videos'  # Directory to store the videos
    context = browser_context.new_context(
        record_video={'dir': video_dir, 'size': {'width': 1280, 'height': 720}}
    )
    
    # Now create a page and run the test as usual
    page = context.new_page()
    page.goto('http://192.168.0.101:31804/')
    
    title = page.title()
    assert title == "Ced's Webpage"

    # Retrieve the video path
    video_path = context.videos[0].path if context.videos else None

    print(f"Video saved to: {video_path}")
    
    # Clean up
    page.close()
    context.close()

def test_dev_environment_text(browser_context):
    # Test 2: Check if "dev environment" text is present
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')
    dev_text_visible = page.locator("text=dev environment").is_visible()
    assert dev_text_visible  # Ensure the "dev environment" text is visible

    # Retrieve the path to the recorded video
    video_path = page.context.videos[0].path if page.context.videos else None
    if video_path:
        print(f"Video for 'test_dev_environment_text': {video_path}")  # Print the video path
    else:
        print("No video was recorded for 'test_dev_environment_text'.")
    
    page.close()

def test_version_text(browser_context):
    # Test 3: Verify the version text
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')
    version_text = page.locator("#version").text_content()
    assert version_text == 'v2.0.3'  # Ensure the version is displayed correctly

    # Retrieve the path to the recorded video
    video_path = page.context.videos[0].path if page.context.videos else None
    if video_path:
        print(f"Video for 'test_version_text': {video_path}")  # Print the video path
    else:
        print("No video was recorded for 'test_version_text'.")
    
    page.close()
