from flask import Flask,request,jsonify
from flask_mysqldb import MySQL
from flask_apscheduler import APScheduler

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
        print(email)
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
        cursor.execute(f"select books.id,books.title, subtitle, isbn, image_url, author, category, edition, dewey, language, year, publisher, "
                       f"transaction.book_id, transaction.borrow_date,transaction.return_date,books.image_url from visitor join transaction on visitor.id = transaction.visitor_id join books on transaction.book_id=books.id where visitor.id='{id}' and transaction.return_date IS NOT NULL;")
        transaction_history = cursor.fetchall()

        if transaction_history:
            columns = [desc[0] for desc in cursor.description]
            results = [dict(zip(columns, row)) for row in transaction_history]

        cursor.close()

        if transaction_history:
            return jsonify(results)
        else: return jsonify({'status': 'failure', 'message': "Failed to find user's transaction history"}), 404

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': "Failed to find user's transaction history"}), 500

@app.route('/renew', methods=['POST','GET'])
def loan_renew():
    try:
        data = request.json
        transaction_id=data['transaction_id']
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT renew FROM transaction where transaction_id='{transaction_id}'")
        is_enabled=cursor.fetchone()
        if is_enabled[0]==0: 
            cursor.close()
            return jsonify({'status':'disabled'})
        cursor.execute(f"UPDATE transaction SET must_return_date=CURDATE() + INTERVAL 7 DAY, renew=false WHERE transaction_id='{transaction_id}';")
        db.connection.commit()
        cursor.close()

        return jsonify({'status': 'success', 'message': 'Loan successfully renewed'})
    
    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': 'Failed to renew transaction'}), 500
    

@app.route('/notification_check', methods=['POST','GET'])
def new_notification():
    try:
        data=request.json
        user_id=data["user_id"]
        print(user_id)
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT notification_id FROM notify_me WHERE user_id='{user_id}' ORDER BY created_at DESC LIMIT 1;")
        notification_id = cursor.fetchone()
        cursor.close()

        if(notification_id):
            print(notification_id[0])
            return jsonify({'status':'success','data':notification_id[0]})
        else: 
            return jsonify({'status':'failure','message':"No new notification found"})
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': 'Failed to check for new notification'}), 500


@app.route('/get_notification', methods=['POST','GET'])
def get_notification():
    try:
        data=request.json
        notification_id=data["notification_id"]
        user_id=data['user_id']
        print(notification_id)
        print(user_id)
        cursor = db.connection.cursor()
        cursor.execute(f"select title,notification_date,content from notifications where user_id='{user_id}' and id='{notification_id}';")
        notification = cursor.fetchone()
        cursor.close()

        if(notification):
            print(notification)
            return jsonify({'status':'success','data':notification})
        else: 
            return jsonify({'status':'failure','message':"The notification was not found"})
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': "Failed to fetch notification's data"}), 500


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
                "language, image_url, CAST(SUM(CASE WHEN category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies " \
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
                "LIMIT 40;"

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

        query = "SELECT books.isbn,books.title,books.subtitle,books.author,books.publisher,books.year,books.category,books.edition,books.dewey,books.language,books.image_url,CAST(SUM(CASE WHEN books.category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies,transaction.transaction_id,transaction.book_id,transaction.borrow_date,transaction.must_return_date,transaction.renew FROM books JOIN transaction ON books.id = transaction.book_id WHERE transaction.visitor_id = %s AND transaction.return_date IS NULL GROUP BY books.isbn,books.title,books.subtitle,books.author,books.publisher,books.year,books.category,books.edition,books.dewey,books.language,books.image_url,transaction.transaction_id,transaction.book_id,transaction.borrow_date,transaction.must_return_date,transaction.renew;"

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
                "WHERE favorites.id = %s GROUP BY books.isbn,title,subtitle,author,publisher,year,category,edition,dewey,language,image_url LIMIT 6;"

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

@app.route('/fav', methods=['POST'])
def fav():
    try:
        data = request.json
        isbn = data.get('isbn')
        email = data.get('email')
        cursor = db.connection.cursor()
        cursor.execute(f"INSERT INTO favorites (id, isbn) " \
                       f"SELECT id, '{isbn}' FROM visitor WHERE email = '{email}';")
        db.connection.commit()
        cursor.close()

        return jsonify({'status': 'success', 'message': 'Added to favorites successfully'})

    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': f'Database error: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
