import sys
import requests

FolderName = sys.argv[1]
ViewName = sys.argv[2]

# Use an f-string to include the FolderName variable
jenkins_url = f'http://192.168.0.100:8081/job/{FolderName}'
username = 'ced'  # Add your Jenkins username
password = 'rootroot'  # Add your Jenkins password or API token

def get_job_names():
    view_url = f'{jenkins_url}/view/{ViewName}/api/json?tree=jobs[name,buildable]'
    response = requests.get(view_url, auth=(username, password))

    try:
        response.raise_for_status()
        view_data = response.json()
        if 'jobs' in view_data:
            job_names = [job['name'] for job in view_data['jobs'] if job['buildable']]
            return job_names
        else:
            print("No jobs found in the specified view.")
            return []
    except requests.exceptions.HTTPError as errh:
        print("HTTP Error:", errh)
        return []
    except requests.exceptions.ConnectionError as errc:
        print("Error Connecting:", errc)
        return []
    except requests.exceptions.Timeout as errt:
        print("Timeout Error:", errt)
        return []
    except requests.exceptions.RequestException as err:
        print("Oops: Something went wrong", err)
        return []

if __name__ == '__main__':
    jobs = get_job_names()
    if jobs:
        for job in jobs:
            print(job)  # Outputs job names, which Jenkins will capture as a list
    else:
        print("No jobs found or error occurred.")
