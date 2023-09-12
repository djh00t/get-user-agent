import json
import os
from user_agent_scraper import main as fetch_and_save_user_agents

# The API key should be pulled from the OS environment using "USER_AGENT_API_KEY" environment variable
API_KEY = os.environ.get("USER_AGENT_API_KEY")

# User agents file
USER_AGENTS_FILE = "user-agents.json"

def fetch_user_agent(browser="chrome", operating_system="windows"):
    """Fetch a user-agent string."""
    # If the API key is not set, use the locally saved user-agents.json file
    if not API_KEY:
        # Fetch and save the latest user agents if the file doesn't exist
        if not os.path.exists(USER_AGENTS_FILE):
            fetch_and_save_user_agents()

        # Load the user agents from the JSON file
        with open(USER_AGENTS_FILE, 'r') as f:
            user_agents = json.load(f)
        
        return user_agents.get(browser.capitalize(), "")
    
    # Otherwise, use the API to fetch the user-agent string (This part can be customized based on the actual API)
    # For demonstration, we'll just return a hardcoded user-agent string
    return "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.3"

if __name__ == "__main__":
    # Test fetching a user-agent string
    print(fetch_user_agent("chrome", "windows"))
