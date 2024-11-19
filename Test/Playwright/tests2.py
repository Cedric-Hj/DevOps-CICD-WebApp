import pytest
from playwright.sync_api import sync_playwright
import os
from pathlib import Path


video_dir = '/var/lib/jenkins/myagent/_work/2/s/'


from playwright.sync_api import sync_playwright

def browser_context():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        
        # Correct way to enable video recording
        context = browser.new_context(
            video={'dir': video_dir, 'size': {'width': 1280, 'height': 720}}
        )
        page = context.new_page()
        
        # Your test code here
        
        page.close()
        context.close()
        browser.close()


def test_page_title(browser_context):
    # Now create a page and run the test as usual
    page = browser_context.new_page()
    page.goto('http://192.168.0.101:31804/')
    
    title = page.title()
    assert title == "Ced's Webpage"

    # Retrieve the video path
    video_path = page.context.videos[0].path if page.context.videos else None

    print(f"Video saved to: {video_path}")
    
    # Clean up
    page.close()


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

    
