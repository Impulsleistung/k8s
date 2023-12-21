import requests
import os

def list_linode_resources():
    """
    Fetches a list of resources from the Linode API.

    This function retrieves resources using the Linode API and returns the result.
    It expects a Linode API token to be available as an environment variable named 'LINODE_API_TOKEN'.
    The token is used for the authentication in the API request.

    Raises:
        Exception: If the API request fails or returns a non-200 status code.

    Returns:
        dict: A dictionary containing the JSON response from the Linode API.
    """
    token = os.getenv('LINODE_API_TOKEN')
    headers = {'Authorization': 'Bearer ' + token}
    response = requests.get('https://api.linode.com/v4/resources', headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception('API Request Failed')

def main():
    """
    Main function to execute the script.

    This function calls list_linode_resources to get the Linode resources and then writes
    the result to a file named 'resources.txt'.
    """
    resources = list_linode_resources()
    with open('resources.txt', 'w') as file:
        file.write(str(resources))

if __name__ == "__main__":
    main()
