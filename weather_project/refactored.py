import openmeteo_requests
import requests_cache
import pandas as pd
from retry_requests import retry
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from datetime import datetime

def setup_openmeteo_api_client():
    """
    Sets up the Open-Meteo API client with caching and retry mechanisms.
    Returns an Open-Meteo client object.
    """
    cache_session = requests_cache.CachedSession('.cache', expire_after=3600)
    retry_session = retry(cache_session, retries=5, backoff_factor=0.2)
    openmeteo_client = openmeteo_requests.Client(session=retry_session)
    return openmeteo_client

def fetch_and_process_weather_data(client, latitude, longitude, variables, past_days, forecast_days):
    """
    Fetches and processes weather data for a given location.
    
    Parameters:
    - client: Open-Meteo client object.
    - latitude: Latitude of the location.
    - longitude: Longitude of the location.
    - variables: List of weather variables to fetch.
    - past_days: Number of past days to fetch data for.
    - forecast_days: Number of forecast days to fetch data for.

    Returns a DataFrame containing the weather data.
    """
    url = "https://api.open-meteo.com/v1/forecast"
    params = {
        "latitude": latitude,
        "longitude": longitude,
        "hourly": variables,
        "past_days": past_days,
        "forecast_days": forecast_days
    }
    response = client.weather_api(url, params=params)[0]  # Assuming single location for simplicity
    hourly = response.Hourly()

    hourly_data = {
        "date": pd.date_range(
            start=pd.to_datetime(hourly.Time(), unit="s", utc=True),
            end=pd.to_datetime(hourly.TimeEnd(), unit="s", utc=True),
            freq=pd.Timedelta(seconds=hourly.Interval()),
            inclusive="left"
        )
    }
    for i, variable in enumerate(variables):
        hourly_data[variable] = hourly.Variables(i).ValuesAsNumpy()

    return pd.DataFrame(data=hourly_data)

def plot_weather_data(df):
    """
    Plots the weather data from the DataFrame using a dark theme, adds a grid to the plots,
    marks the current time with a vertical line, assigns a different color to each plot,
    and shows the current time as the label of the marker.
    
    Parameters:
    - df: DataFrame containing weather data.
    """
    plt.style.use('dark_background')  # Use dark theme for the plots
    fig, axs = plt.subplots(nrows=len(df.columns) - 1, ncols=1, figsize=(10, 8))
    
    # Define a list of colors to cycle through
    colors = ['cyan', 'magenta', 'yellow', 'white', 'red', 'green', 'blue']
    
    # Get the current time and format it for the label
    current_time = pd.to_datetime(datetime.now(), utc=True)
    current_time_str = current_time.strftime('%H:%M UTC')
    closest_date = df.iloc[(df['date'] - current_time).abs().argsort()[0]]['date']
    
    for i, var in enumerate(df.columns[1:]):  # Skip date column for plotting
        color = colors[i % len(colors)]  # Cycle through the list of colors
        axs[i].plot(df['date'], df[var], label=var, color=color, marker='o', markersize=3, linestyle='-')
        axs[i].set_title(var)
        axs[i].legend()
        axs[i].grid(True)  # Add grid to the plot
        
        # Mark the current time with a vertical line and label it with the formatted current time string
        axs[i].axvline(x=closest_date, color='r', linestyle='--', label=f'Current Time: {current_time_str}')
        axs[i].legend()
    
    plt.tight_layout()
    plt.show()




# Usage Example
openmeteo_client = setup_openmeteo_api_client()
weather_df = fetch_and_process_weather_data(
    openmeteo_client,
    latitude=48.8844,
    longitude=8.6989,
    variables=["temperature_2m", "rain", "surface_pressure"],
    past_days=3,
    forecast_days=3
)
print(weather_df.head())  # Displaying a part of the DataFrame for verification
plot_weather_data(weather_df)
