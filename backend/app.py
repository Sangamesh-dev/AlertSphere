import requests
import os
from flask import Flask, request, jsonify
from dotenv import load_dotenv
from flask_cors import CORS

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Get the API key from the environment variable or set it directly
WEATHERBIT_API_KEY = os.getenv('WEATHERBIT_API_KEY', '038bba3b63ca4ea29e0a886419119be4')

# Function to fetch weather forecast data for 4-5 days using Weatherbit.io
def get_weather_forecast(city):
    url = f"https://api.weatherbit.io/v2.0/forecast/daily?city={city}&key={WEATHERBIT_API_KEY}&days=5"
    response = requests.get(url)

    if response.status_code == 200:
        forecast_data = response.json()
        forecasts = []

        for day in forecast_data['data']:
            forecasts.append({
                'date': day['datetime'],
                'temperature': day['temp'],
                'weather_description': day['weather']['description']
            })

        return forecasts
    else:
        print(f"Error fetching weather forecast data: {response.status_code}")
        return None

# Flask route to get weather forecast data
@app.route('/weather-forecast', methods=['GET'])
def get_forecast():
    city = request.args.get('city')  # Get the city from request parameters

    if not city:
        return jsonify({"error": "City parameter is required"}), 400

    forecast = get_weather_forecast(city)

    if forecast:
        return jsonify(forecast), 200
    else:
        return jsonify({"error": "Weather forecast data could not be retrieved"}), 500

# Run the Flask app
if __name__ == "_main_":
    app.run(debug=True)