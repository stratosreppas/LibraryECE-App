from flask import Flask, jsonify, g
import mysql.connector

app = Flask(__name__)

# MySQL Connection Configuration
DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'ecel'
}

def get_db():
    if 'db' not in g:
        try:
            g.db = mysql.connector.connect(**DATABASE_CONFIG)
        except mysql.connector.Error as err:
            print(f"Error: {err}")
            g.db = None  # Set to None to indicate a failed connection
    return g.db

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

@app.before_request
def before_request():
    g.db = get_db()

@app.teardown_request
def teardown_request(exception=None):
    close_db()

@app.route('/api/first_book_image')
def get_first_book_image():
    try:
        cursor = g.db.cursor()
        cursor.execute('SELECT image_url FROM books LIMIT 1')
        data = cursor.fetchone()
        cursor.close()

        if data:
            return jsonify({'image_url': data[0]})  # Assuming data is a tuple, get the first element
        else:
            return jsonify({'error': 'No data found'})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
