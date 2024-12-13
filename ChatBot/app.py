import google.generativeai as genai

# API Key Configuration
api_key = "AIzaSyD3QBMsRdOf48XxARh2W4zOuHla-hcx7Go"  # Replace with your API key
if not api_key:
    raise ValueError("API key not provided. Please ensure the key is set.")

# Configure the Generative AI API
genai.configure(api_key=api_key)

# Initialize the generative model
model = genai.GenerativeModel(
    model_name="gemini-2.0-flash-exp",
    generation_config={
        "temperature": 0.7,
        "top_p": 0.9,
        "top_k": 40,
        "max_output_tokens": 1000,
        "response_mime_type": "text/plain",
    },
)

# Start a chat session
chat_session = model.start_chat(history=[])

def chatbot_response(user_input):
    """
    Generate a response from the chatbot for the given input.
    """
    try:
        response = chat_session.send_message(user_input)
        return response.text
    except Exception as e:
        return f"Error: {str(e)}"

# Example usage
if __name__ == "__main__":
    while True:
        user_input = input("You: ")
        if user_input.lower() in {"exit", "quit"}:
            break
        response = chatbot_response(user_input)
        print(f"Chatbot: {response}")