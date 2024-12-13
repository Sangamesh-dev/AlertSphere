import requests
from flask import Flask, request, jsonify

# Initialize Flask App
app = Flask(__name__)

# Gemini API Key and Base URL
GEMINI_API_KEY = "AIzaSyDLBvhbGsuAzHgjTJsq7KKoqDD8AfNSinw"
GEMINI_BASE_URL = "https://api.gemini/disasters"

# Function to fetch disaster data
def get_disaster_data(location):
    params = {"location": location, "apiKey": GEMINI_API_KEY}
    try:
        response = requests.get(GEMINI_BASE_URL, params=params)
        if response.status_code == 200:
            data = response.json()
            return data  # Return disaster-related information
        else:
            return {"error": f"Error fetching data: {response.status_code}"}
    except Exception as e:
        return {"error": f"Exception occurred: {str(e)}"}

# Function to generate a chatbot response
def alena_response(user_query, location):
    # Fetch disaster data from Gemini API
    disaster_data = get_disaster_data(location)
    
    if "error" in disaster_data:
        # Handle error case
        return f"Sorry, I couldn't retrieve disaster information for {location}. Please try again later."
    
    # Build response based on disaster data
    if disaster_data.get("disasters"):
        response = f"Here's the latest information about disasters in {location}:\n"
        for disaster in disaster_data["disasters"]:
            response += f"- {disaster['type']} reported on {disaster['date']}: {disaster['description']}\n"
            response += f"  Safety Tip: {disaster.get('safety_tip', 'No specific tips available.')}\n"
        return response
    else:
        return f"No active disasters reported in {location}. Stay prepared and stay safe!"

# Flask route to handle chatbot requests
@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_query = data.get("message", "")
    location = data.get("location", "global")
    response = alena_response(user_query, location)
    return jsonify({"response": response})

# Run Flask app
if __name__ == "_main_":
    app.run(debug=True)