from flask import Flask, jsonify
from flask_mysqldb import MySQL
import mysql.connector

app = Flask(__name__)

# MySQL Connection Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = ''
app.config["MYSQL_DB"] = 'ecel'

db = MySQL(app)

@app.route('/api/first_book_image', methods = ['GET'])
def get_first_book_image():
    try:
        cursor = db.connection.cursor()
        cursor.execute('SELECT image_url FROM books LIMIT 1')
        data = cursor.fetchone()
        cursor.close()

        if data:
            return jsonify({'image_url': data[0]})  # Assuming data is a tuple, get the first element
        else:
            return jsonify({'error': 'No data found'})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})

@app.route('/api/all_books/<string:languages>', methods=['GET'])
def get_all_books(languages):
    try:
        print(languages)
        languages_list = languages.split('-')  # Assuming categories are separated by commas
        placeholders = ', '.join(['%s' for _ in languages_list])

        cursor = db.connection.cursor()

        query = f"SELECT isbn, title, subtitle, author, publisher, year, category, edition, dewey, language, image_url, COUNT(*) as copies " \
        f"FROM books WHERE language IN ({placeholders}) AND category != 'Υπόγειο' " \
        f"GROUP BY isbn, title, subtitle, author, publisher, year, category, edition, dewey, language, image_url " \
        f"LIMIT 10;"

        cursor.execute(query, languages_list)
        data = cursor.fetchall()

        if data:

            columns = [desc[0] for desc in cursor.description]
            results = [dict(zip(columns, row)) for row in data]

            cursor.close()

            return jsonify(results)
        else:
            return jsonify({'error': 'No data found'})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
