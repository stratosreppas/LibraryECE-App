from flask import Flask, jsonify, request, session
from flask_mysqldb import MySQL
import mysql.connector

app = Flask(__name__)

# MySQL Connection Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = 'password'
app.config["MYSQL_DB"] = 'ecel'

db = MySQL(app)

@app.route('/login', methods=['POST'])
def user_login():
    try:
        data = request.json
        email = data.get('email')
        password = data.get('password')
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT COUNT(*) FROM visitor WHERE email='{email}' and password='{password}'")
        user_data = cursor.fetchone()
        cursor.close()

        if user_data[0]==1:
            return jsonify({"status": "success", "message": "Successful Login"})
        else:
            return jsonify({"status": "failure", "message": "Incorrect credentials. \nPlease ensure your username and password are correct."})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})
    
@app.route('/signup', methods=['POST'])
def user_signup():
    try:
        data = request.json
        mail = data.get('mail')
        password = data.get('password')
        first_name=data.get('first_name')
        last_name=data.get('last_name')
        phone=data.get('phone')
        registration_id=data.get('registration_id')
        role=data.get('role')
        if role=="Προπτυχιακός/ή": 
            role=1
        elif role=="Μεταπτυχιακός/ή":
            role=2
        elif role=="Υποψήφιος/α Διδάκτωρ":
            role=3
        elif role=="Καθηγητής/τρια":
            role=4
        elif role=="Κατατακτήριος/α":
            role=5
        else: role=6
        cursor = db.connection.cursor()
        cursor.execute(f"INSERT INTO visitor (name, surname, am, property, phone, mail,password) VALUES ('{first_name}','{last_name}','{registration_id}','{role}','{phone}','{mail}','{password}')")
        db.connection.commit()
        cursor.close()

        return jsonify({'status': 'success', 'message': 'Signed up successfully'})
    
    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': 'Failed to sign up user'}), 500


@app.route('/profile', methods=['POST'])
def user_data():
    try:
        data = request.json
        email = data.get('email')
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT name,surname,am,property,phone,id from visitor where email='{email}'")
        user_data = cursor.fetchone()
        cursor.close()

        if user_data:
            return jsonify({
                'status': 'success',
                'user_data': user_data
            })
        else:
            return jsonify({'status': 'error', 'message': 'Failed to find user data'}), 404
    
    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': 'Failed to find user data'}), 500


@app.route('/transactions_history',methods=['POST'])
def user_transaction_history():
    try:
        data=request.json
        id=data.get('id')
        print(id)
        cursor = db.connection.cursor()
        cursor.execute(f"select books.id,books.title,transaction.borrow_date,transaction.return_date,books.image_url from visitor join transaction on visitor.id = transaction.visitor_id join books on transaction.book_id=books.id where visitor.id='{id}' and transaction.return_date IS NOT NULL;")
        transaction_history = cursor.fetchall()
        cursor.close()

        if transaction_history:
            return jsonify({'status':'success','transaction_history':transaction_history})
        else: return jsonify({'status': 'failure', 'message': "Failed to find user's transaction history"}), 404

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': "Failed to find user's transaction history"}), 500


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


@app.route('/api/home/transactions',
           methods=['GET'])
def get_all_transactions():
    try:

        visitor_id = int(request.args.get('id', ''))
        print(visitor_id)

        print('hi')

        cursor = db.connection.cursor()

        query = "SELECT books.isbn, books.title, books.subtitle, books.author, books.publisher, books.year, " \
                "books.category, books.edition, books.dewey, books.language, books.image_url, " \
                "transaction.book_id, transaction.borrow_date, transaction.must_return_date " \
                "FROM books " \
                "JOIN transaction ON books.id = transaction.book_id " \
                "WHERE transaction.visitor_id = %s AND transaction.return_date IS NULL;"

        params = (visitor_id,)

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

@app.route('/api/home/books',
           methods=['GET'])
def get_all_selected_books():
    try:

        visitor_id = request.args.get('id', '')

        cursor = db.connection.cursor()

        query = "SELECT books.isbn, title, subtitle, author, publisher, year, category, " \
                "edition, dewey, language, image_url, count(*) as copies " \
                "FROM books JOIN favorites ON books.isbn = favorites.isbn " \
                "WHERE favorites.id = %s GROUP BY books.isbn,title,subtitle,author,publisher,year,category,edition,dewey,language,image_url;"

        params = (visitor_id,)

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

@app.route('/api/home/user',
           methods=['GET'])
def get_user():
    try:

        email = request.args.get('email', '')
        print(email)

        # ...

        cursor = db.connection.cursor()

        query = "SELECT id, name, surname, am, property, phone, email, penalty FROM visitor WHERE email = %s;"
        params = (email,)

        cursor.execute(query, params)

        data = cursor.fetchone()

        if data:
            columns = [desc[0] for desc in cursor.description]
            results = dict(zip(columns, data))

            cursor.close()

            return jsonify(results)
        else:
            cursor.close()
            return jsonify({'error': 'No data found'})
    except Exception as e:
        return jsonify({'error': f'Database error: {str(e)}'})



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
