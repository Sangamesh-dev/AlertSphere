import requests

class GeminiChatbot:
    def _init_(self, api_key):
        """
        Initialize the chatbot with the Gemini API key.
        """
        self.api_key = AIzaSyDLBvhbGsuAzHgjTJsq7KKoqDD8AfNSinw
        self.model_name = "gemini-1.5-flash"
        self.api_url = f"https://generativeai.googleapis.com/v1beta2/models/{self.model_name}:generateMessage"

    def send_message(self, prompt):
        """
        Send a prompt to the Gemini API and return the response.
        """
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json",
        }

        payload = {
            "prompt": {
                "messages": [{"content": prompt}],
            },
            "temperature": 0.7,
            "top_k": 40,
            "top_p": 0.9,
            "maxOutputTokens": 300,
        }

        try:
            response = requests.post(self.api_url, headers=headers, json=payload)
            response.raise_for_status()
            data = response.json()
            return data["candidates"][0]["content"]
        except requests.exceptions.RequestException as e:
            return f"Error: {e}"

if _name_ == "_main_":
    # Replace 'your_gemini_api_key' with your actual Gemini API key
    API_KEY = "your_gemini_api_key"

    # Initialize the chatbot
    chatbot = GeminiChatbot(API_KEY)

    # Chat with the user
    print("Welcome to Alena - Your Disaster Preparedness Assistant!")
    while True:
        user_input = input("\nAsk a question or type 'exit' to quit: ")
        if user_input.lower() == "exit":
            print("Goodbye!")
            break

        # Send user input to the chatbot and get a response
        response = chatbot.send_message(user_input)
        print(f"Alena: {response}")