import os
import google.generativeai as genai

def initialize_chatbot():
    """
    Initialize the Gemini API chatbot for disaster preparedness assistance.
    """
    # Configure API key
    genai.configure(api_key=os.environ["AIzaSyD3QBMsRdOf48XxARh2W4zOuHla-hcx7Go"])

    # Define generation configuration for the model
    generation_config = {
        "temperature": 0.7,  # Balances creativity and accuracy
        "top_p": 0.9,       # Ensures diverse outputs
        "top_k": 40,        # Considers the top 40 options for each word
        "max_output_tokens": 1000,  # Limits response length
        "response_mime_type": "text/plain",
    }

    # Initialize the generative model with the desired configuration
    model = genai.GenerativeModel(
        model_name="gemini-2.0-flash-exp",
        generation_config=generation_config,
    )

    # Start a chat session
    chat_session = model.start_chat(history=[])

    return chat_session

def disaster_preparedness_assistant():
    """
    Main function to run the chatbot and assist users with disaster preparedness.
    """
    print("Welcome to Alena - Your Disaster Preparedness Assistant!")

    # Initialize the chatbot
    try:
        chat_session = initialize_chatbot()
    except Exception as e:
        print(f"Error initializing the chatbot: {e}")
        return

    while True:
        # Get user input
        user_input = input("\nAsk a question about disaster preparedness or type 'exit' to quit: ")

        if user_input.lower() == "exit":
            print("Goodbye! Stay safe and prepared.")
            break

        try:
            # Send the user's input to the chatbot
            response = chat_session.send_message(user_input)
            print(f"\nAlena: {response.text}")
        except Exception as e:
            print(f"Error during chatbot interaction: {e}")

if _name_ == "_main_":
    # Ensure the API key is set
    if "GEMINI_API_KEY" not in os.environ:
        print("Error: GEMINI_API_KEY environment variable is not set.")
    else:
        disaster_preparedness_assistant()