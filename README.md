# User Agent

This Python package allows you to fetch the current user-agent strings for popular browsers. It uses web scraping to fetch the user-agent strings from the website useragentstring.com.

## How it works

The package contains two main scripts:

1. `user_agent_scraper.py`: This script scrapes the user-agent strings for various browsers from useragentstring.com and saves them in a JSON file (`user-agents.json`). The browsers it fetches the user-agent strings for are Edge, Chrome, Firefox, Safari, and GoogleBot.

2. `user_agent.py`: This script fetches a user-agent string. If the `USER_AGENT_API_KEY` environment variable is not set, it uses the locally saved `user-agents.json` file. If the file doesn't exist, it calls `user_agent_scraper.py` to fetch and save the latest user agents. If the `USER_AGENT_API_KEY` environment variable is set, it uses the API to fetch the user-agent string.

## How to use

1. Install the package using `pip install user_agent`.
2. Import the `fetch_user_agent` function from the `user_agent` module.
3. Call the function with the browser and operating system as arguments. The available options for the browser are "Edge", "Chrome", "Firefox", "Safari", and "GoogleBot". The operating system argument is currently not used. For example, `fetch_user_agent("chrome", "windows")`.

Example returned values:

- For Chrome: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.3"
- For Firefox: "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101 Firefox/86.0"
- For Safari: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15"
- For Edge: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.3 Edg/89.0.774.50"
- For GoogleBot: "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

## Dependencies

The package requires the following Python libraries:

- requests
- beautifulsoup4

These can be installed using `pip install -r requirements.txt`.

## License

This package is licensed under the MIT License. See the `LICENSE` file for more details.
