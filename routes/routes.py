from flask import Flask, jsonify, request, session
from flask_mysqldb import MySQL
import mysql.connector

app = Flask(__name__)

# MySQL Connection Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = ''
app.config["MYSQL_DB"] = 'ecel'

db = MySQL(app)

@app.route('/login', methods=['POST'])
def user_login():
    try:
        data = request.json
        mail = data.get('mail')
        password = data.get('password')
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT COUNT(*) FROM visitor WHERE mail='{mail}' and password='{password}'")
        user_data = cursor.fetchone()
        cursor.close()

        if user_data[0]==1:
            return jsonify({"status": "success", "message": "Successful Login"})
        else:
            return jsonify({"status": "failure", "message": "Incorrect credentials. \nPlease ensure your username and password are correct."})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})

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


@app.route('/api/all_books',
           methods=['GET'])
def get_all_books():
    try:

        languages = request.args.get('languages', '')
        searchText = request.args.get('searchText', '')
        authors = request.args.get('authors', '')
        publishers = request.args.get('publishers', '')
        categories = request.args.get('categories', '')
        years = request.args.get('years', '')

        languages_list = languages.split('-')
        authors_list = authors.split('-')
        publishers_list = publishers.split('-')
        categories_list = categories.split('-')
        years_list = years.split('-')

        languages_sql = ', '.join(['%s' for _ in languages.split('-')])
        authors_sql = ', '.join(['%s' for _ in authors.split('-')])
        publishers_sql = ', '.join(['%s' for _ in publishers.split('-')])
        categories_sql = ', '.join(['%s' for _ in categories.split('-')])
        years_sql = ', '.join(['%s' for _ in years.split('-')])

        print(languages_list)
        print(authors_list)
        print(publishers_list)
        print(categories_list)
        print(years_list)

        # ...

        cursor = db.connection.cursor()

        query = "SELECT isbn, title, subtitle, author, publisher, year, category, edition, dewey, " \
                "language, image_url, COUNT(*) as copies " \
                "FROM books WHERE (language IN ({}) OR %s = 'NaN') " \
                "AND (author IN ({}) OR %s = 'NaN') " \
                "AND (publisher IN ({}) OR %s = 'NaN') " \
                "AND (category IN ({}) OR %s = 'NaN') " \
                "AND (year IN ({}) OR %s = 'NaN') " \
                "AND (title LIKE %s " \
                "OR subtitle LIKE %s " \
                "OR author LIKE %s " \
                "OR publisher LIKE %s " \
                "OR category LIKE %s " \
                "OR year LIKE %s) " \
                "GROUP BY isbn, title, subtitle, author, publisher, year, category, edition, " \
                "dewey, language, image_url " \
                "LIMIT 10;"

        # Use placeholders for the IN clauses
        query = query.format(languages_sql, authors_sql, publishers_sql, categories_sql, years_sql)

        # Ensure the number of placeholders in the query matches the number of parameters
        params = (*languages_list, *languages_list, *authors_list, *authors_list, *publishers_list, *publishers_list,
                  *categories_list, *categories_list, *years_list, *years_list, f"%{searchText}%", f"%{searchText}%",
                  f"%{searchText}%", f"%{searchText}%", f"%{searchText}%", f"%{searchText}%")

        cursor.execute(query, params)

        data = cursor.fetchall()
        print(data)
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
