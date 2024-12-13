from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

# API key (replace with your actual News API key)
NEWS_API_KEY = 'a613687bd7e14dbfa4263426f9b61010'  # Replace with your actual key

# Function to fetch recent disaster-related news using the News API
def get_recent_disaster_news(city):
    query = f'{city} flood OR {city} rain'
    url = f"https://newsapi.org/v2/everything?q={query}&apiKey={NEWS_API_KEY}"
    response = requests.get(url)

    if response.status_code == 200:
        news_data = response.json()
        affected_articles = []

        for article in news_data['articles']:
            title = article['title']
            description = article['description']
            url = article['url']
            published_at = article['publishedAt']

            if 'flood' in title.lower() or 'rain' in title.lower():
                affected_articles.append({
                    'title': title,
                    'description': description,
                    'url': url,
                    'published_at': published_at
                })

        return affected_articles
    else:
        return None

@app.route('/get_disaster_news', methods=['GET'])
def fetch_disaster_news():
    city = request.args.get('city')
    if not city:
        return jsonify({'error': 'City parameter is required'}), 400

    news = get_recent_disaster_news(city)
    if news:
        return jsonify(news)
    else:
        return jsonify({'error': 'No recent disaster news found'}), 404

if __name__ == "_main_":
    app.run(debug=True, host = '0.0.0.0')