from flask import Flask, jsonify
import os
import datetime

app = Flask(__name__)

VERSION = os.getenv('APP_VERSION', 'v1.0.0')

@app.route('/')
def hello():
    return jsonify({
        'message': f'Hello from Blue Deployment!',
        'version': VERSION,
        'timestamp': datetime.datetime.now().isoformat()
    })

@app.route('/health')
def health():
    return jsonify({
        'status': 'healthy',
        'version': VERSION,
        'timestamp': datetime.datetime.now().isoformat()
    }), 200


if __name__ == '__main__':
    port = int(os.getenv('PORT', 8000))
    app.run(host='0.0.0.0', port=port, debug=False)