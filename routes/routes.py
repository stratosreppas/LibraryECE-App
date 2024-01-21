from flask import Flask,request,jsonify
from flask_mysqldb import MySQL
from flask_apscheduler import APScheduler
import pandas as pd
import numpy as np
import pickle
from recommendation_engine.model import train_model
from recommendation_engine.recommendation import return_recommendations


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
        email = data.get('email')
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
        cursor.execute(f"INSERT INTO visitor (name, surname, am, property, phone, email,password) VALUES ('{first_name}','{last_name}','{registration_id}','{role}','{phone}','{email}','{password}')")
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
                       f"transaction.book_id, transaction.borrow_date,transaction.return_date,books.image_url, "
                       f"CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = {id}) THEN TRUE ELSE FALSE END as isFav, " \
                       f"CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = {id}) THEN TRUE ELSE FALSE END as isNotified " \
                       f"from visitor join transaction on visitor.id = transaction.visitor_id join books on transaction.book_id=books.id where visitor.id='{id}' and transaction.return_date IS NOT NULL;")
        transaction_history = cursor.fetchall()

        if transaction_history:
            columns = [desc[0] for desc in cursor.description]
            results = [dict(zip(columns, row)) for row in transaction_history]

        cursor.close()

        if transaction_history:
            return jsonify({'status':"success",'data':results})
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
        user_id=int(data["user_id"])
        print(user_id)
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT notification_id FROM notify_me WHERE user_id={user_id} ORDER BY created_at ASC LIMIT 1;")
        notification_id = cursor.fetchone()
        print(notification_id)

        if(notification_id):
            print(notification_id[0])
            cursor.execute(f"DELETE FROM notify_me WHERE notification_id='{notification_id[0]}';")
            db.connection.commit()
            cursor.close()
            return jsonify({'status':'success','data':notification_id[0]})
        else:
            cursor.close() 
            return jsonify({'status':'failure','message':"No new notification found"})
    except Exception as e:
        cursor.close()
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
    
@app.route('/update_notification', methods=['POST','GET'])
def update_notification():
    try:
        data=request.json
        notification_id=data["notification_id"]
        print(notification_id)
        cursor = db.connection.cursor()
        cursor.execute(f"UPDATE notifications SET opened=1 where id='{notification_id}';")
        db.connection.commit()
        cursor.close()

        return jsonify({'status':'success','message':"Successfully updated notification's read state."})
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': 'Failed to update notification'}), 500

@app.route('/notifications_history', methods=['POST','GET'])
def user_notifications_history():
    try:
        data=request.json
        email=data['email']
        print(email)
        cursor = db.connection.cursor()
        cursor.execute(f"SELECT notifications.id,title,notification_date,content,opened FROM notifications join visitor on visitor.id= notifications.user_id where email='{email}' ORDER BY notification_date DESC;")
        notifications= cursor.fetchall()

        if(notifications):
            print(notifications)
            columns = [desc[0] for desc in cursor.description]
            notifications = [dict(zip(columns, row)) for row in notifications]
            cursor.close()
            return jsonify({'status':'success','data':notifications})
        else:
            cursor.close() 
            return jsonify({'status':'failure','message':"There is not any notification history"})
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': "Failed to fetch notifications history"}), 500


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
        email = request.args.get('email', 'NaN')
        languages = request.args.get('languages', 'NaN')
        searchText = request.args.get('searchText', 'NaN')
        authors = request.args.get('authors', 'NaN')
        publishers = request.args.get('publishers', 'NaN')
        categories = request.args.get('categories', 'NaN')
        years = request.args.get('years', 'NaN')
        semesters = request.args.get('semesters', 'NaN')
        interests = request.args.get('interests', 'NaN')

        languages_list = languages.split('-')
        authors_list = authors.split('-')
        publishers_list = publishers.split('-')
        categories_list = categories.split('-')
        years_list = years.split('-')
        semesters_list = semesters.split('-')
        interests_list = interests.split('-')


        languages_sql = ', '.join(['%s' for _ in languages.split('-')])
        authors_sql = ', '.join(['%s' for _ in authors.split('-')])
        publishers_sql = ', '.join(['%s' for _ in publishers.split('-')])
        categories_sql = ', '.join(['%s' for _ in categories.split('-')])
        years_sql = ', '.join(['%s' for _ in years.split('-')])
        semesters_sql = ', '.join(['%s' for _ in semesters.split('-')])
        interests_sql = ', '.join(['%s' for _ in interests.split('-')])

        print(languages_list)
        print(authors_list)
        print(publishers_list)
        print(categories_list)
        print(years_list)
        print(semesters_list)
        print(interests_list)

        cursor = db.connection.cursor()

        query = "SELECT isbn, title, subtitle, author, publisher, year, category, edition, dewey, " \
                "language, image_url, CAST(SUM(CASE WHEN category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = (SELECT id FROM visitor WHERE email = %s)) THEN TRUE ELSE FALSE END as isFav, " \
                "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = (SELECT id FROM visitor WHERE email = %s)) THEN TRUE ELSE FALSE END as isNotified " \
                "FROM books WHERE (language IN ({}) OR %s = 'NaN') " \
                "AND (author IN ({}) OR %s = 'NaN') " \
                "AND (publisher IN ({}) OR %s = 'NaN') " \
                "AND (category IN ({}) OR %s = 'NaN') " \
                "AND (year IN ({}) OR %s = 'NaN') " \
                "AND (semester IN ({}) OR %s = 'NaN') " \
                "AND (interest IN ({}) OR %s = 'NaN') " \
                "AND (title LIKE %s " \
                "OR subtitle LIKE %s " \
                "OR author LIKE %s " \
                "OR publisher LIKE %s " \
                "OR category LIKE %s " \
                "OR year LIKE %s " \
                "OR semester LIKE %s " \
                "OR interest LIKE %s " \
                "OR %s = 'NaN') " \
                "GROUP BY isbn, title, subtitle, author, publisher, year, edition, " \
                "dewey, language, image_url, semester, interest " \
                "LIMIT 40;"

        # Use placeholders for the IN clauses
        query = query.format(languages_sql, authors_sql, publishers_sql, categories_sql, years_sql, semesters_sql, interests_sql)
        print(query)
        params = (email, email, *languages_list, languages_list[0], *authors_list, authors_list[0], *publishers_list, publishers_list[0],
                  *categories_list, categories_list[0], *years_list, years_list[0], *semesters_list, semesters_list[0],
                  *interests_list, interests_list[0], f"%{searchText}%", f"%{searchText}%",
                  f"%{searchText}%", f"%{searchText}%", f"%{searchText}%", f"%{searchText}%", f"%{searchText}%", f"%{searchText}%", searchText)
        print(params)
        cursor.execute(query, params)
        print(query)

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
                "CAST(SUM(CASE WHEN books.category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified, " \
                "transaction.transaction_id,transaction.book_id, transaction.borrow_date, transaction.must_return_date, transaction.renew " \
                "FROM books " \
                "JOIN transaction ON books.id = transaction.book_id " \
                "WHERE transaction.visitor_id = %s AND transaction.return_date IS NULL " \
                "GROUP BY books.isbn, books.title, books.subtitle, books.author, books.publisher, " \
                "books.year, books.edition, books.dewey, books.language, books.image_url, " \
                "transaction.book_id, transaction.borrow_date, transaction.must_return_date,transaction.renew,transaction.transaction_id;"


        params = (visitor_id,visitor_id,visitor_id,)

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
           methods=['POST'])
def get_all_selected_books():
    try:
        data=request.json
        visitor_id = data['user_id']
        home_page_value=data['value']

        cursor = db.connection.cursor()
#                 "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = (SELECT id FROM visitor WHERE email = %s)) THEN TRUE ELSE FALSE END as isFav, " \
        # Favorite books
        if home_page_value==0:
            query = "SELECT books.isbn, title, subtitle, author, publisher, year, category, " \
                "edition, dewey, language, image_url, semester, interest," \
                "CAST(SUM(CASE WHEN books.category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified " \
                "FROM books JOIN favorites ON books.isbn = favorites.isbn " \
                "WHERE favorites.id = %s GROUP BY books.isbn,title,subtitle,author,publisher,year,edition,dewey,language,image_url LIMIT 10;"
            params = (visitor_id, visitor_id, visitor_id,)
            cursor.execute(query, params)

        if home_page_value==1:
            query = "SELECT books.isbn, title, subtitle, author, publisher, year, category, " \
                            "edition, dewey, language, image_url, semester, interest," \
                            "CAST(SUM(CASE WHEN books.category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                            "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                            "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified " \
                            "FROM books " \
                            "WHERE NOT (CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END) " \
                            "GROUP BY books.isbn,title,subtitle,author,publisher,year,edition,dewey,language,image_url ORDER BY RAND() LIMIT 40;"
            params = (visitor_id, visitor_id, visitor_id,)
            cursor.execute(query, params)

            rows= cursor.fetchall()

            # Get column names for favorite books
            columns = [desc[0] for desc in cursor.description]

            # Convert the list of tuples to a Pandas DataFrame for favorite books
            df = pd.DataFrame(rows, columns=columns)
            recs = return_recommendations(df)
            print(recs)
            cursor.close()
            if not recs.empty:
                # Convert DataFrame to a list of dictionaries
                results = recs.to_dict(orient='records')
                return jsonify({'data': results})
            else:
                # Handle the case when recs is empty
                return jsonify({'data': []})

    # New books
        elif home_page_value==2:
            query="SELECT isbn, title, subtitle, author, publisher, year, category, edition, dewey, " \
                  "CAST(SUM(CASE WHEN category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                  "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                  "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified, " \
                  "language, image_url FROM books GROUP BY isbn,title,subtitle, author, publisher, year, " \
                  "edition, dewey, language, image_url ORDER BY id DESC LIMIT 10;"
            params = (visitor_id, visitor_id,)
            cursor.execute(query, params)

        # Most popular books
        elif home_page_value==3:

            query="SELECT isbn, title, subtitle, author, publisher, year, category, edition, dewey, " \
                  "CAST(SUM(CASE WHEN category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                  "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                  "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified, " \
                  "language, image_url, COUNT(*) AS transaction_count FROM transaction JOIN books " \
                  "ON transaction.book_id = books.id WHERE transaction.borrow_date >= CURDATE() " \
                  "- INTERVAL 2 WEEK GROUP BY isbn,title,subtitle, author, publisher, year, " \
                  "edition, dewey, language, image_url ORDER BY transaction_count DESC LIMIT 10;"

            params=(visitor_id, visitor_id,)
            cursor.execute(query, params)

        # Notified books
        elif home_page_value==4:
            query = "SELECT books.isbn, title, subtitle, author, publisher, year, category, " \
                    "edition, dewey, language, image_url, semester, interest," \
                    "CAST(SUM(CASE WHEN books.category = 'Διαθέσιμο' THEN 1 ELSE 0 END) AS SIGNED) as copies, " \
                    "CASE WHEN EXISTS (SELECT 1 FROM favorites WHERE books.isbn = favorites.isbn AND favorites.id = %s) THEN TRUE ELSE FALSE END as isFav, " \
                    "CASE WHEN EXISTS (SELECT 1 FROM set_notification WHERE books.isbn = set_notification.isbn and set_notification.id = %s) THEN TRUE ELSE FALSE END as isNotified " \
                    "FROM books JOIN set_notification ON books.isbn = set_notification.isbn " \
                    "WHERE set_notification.id = %s GROUP BY books.isbn,title,subtitle,author,publisher,year,edition,dewey,language,image_url,semester,interest LIMIT 10;"
            params = (visitor_id, visitor_id, visitor_id,)
            cursor.execute(query, params)

        data = cursor.fetchall()
        print(data)
        if data:

            columns = [desc[0] for desc in cursor.description]
            results = [dict(zip(columns, row)) for row in data]

            cursor.close()

            return jsonify({'data':results})
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

@app.route('/recommender/load', methods=['GET'])
def train_recommender():
    try:
        email = request.args.get('email', 'NaN')
        cursor = db.connection.cursor()

        # Query for favorite books
        query_favorites = "SELECT books.isbn, title, subtitle, author, publisher, year, category, " \
                          "edition, dewey, language, image_url, semester, interest " \
                          "FROM books JOIN favorites ON books.isbn = favorites.isbn " \
                          "WHERE favorites.id = (select id from visitor where email = %s) GROUP BY books.isbn,title,subtitle,author,publisher,year,edition,dewey,language,image_url LIMIT 10;"
        params_favorites = (email,)
        cursor.execute(query_favorites, params_favorites)
        # Fetch all the rows for favorite books
        rows_favorites = cursor.fetchall()

        # Get column names for favorite books
        columns_favorites = [desc[0] for desc in cursor.description]

        # Convert the list of tuples to a Pandas DataFrame for favorite books
        df_favorites = pd.DataFrame(rows_favorites, columns=columns_favorites)

        # Query for 20 random books
        query_random = "SELECT isbn, title, subtitle, author, publisher, year, category, " \
                       "edition, dewey, language, image_url, semester, interest " \
                       "FROM books ORDER BY RAND() LIMIT 20;"
        cursor.execute(query_random)

        # Fetch all the rows for random books
        rows_random = cursor.fetchall()

        # Get column names for random books
        columns_random = [desc[0] for desc in cursor.description]

        # Convert the list of tuples to a Pandas DataFrame for random books
        df_random = pd.DataFrame(rows_random, columns=columns_random)

        # Add a new column 'constant_column' with values of 1 to both DataFrames
        df_favorites = df_favorites.assign(recommend=1)
        df_random = df_random.assign(recommend=np.random.choice([0, 1], size=len(df_random), p=[0.6, 0.4]))

        # Concatenate the two DataFrames
        df = pd.concat([df_favorites, df_random], ignore_index=True)
        print(df)

        cursor.close()

        train_model(df)

        return

    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'})


@app.route('/fav', methods=['POST'])
def fav():
    try:
        data = request.json
        isbn = data.get('isbn')
        print('isbn:', isbn)
        email = data.get('email')
        isFav = data.get('isFav')
        print('isFav:', isFav)
        cursor = db.connection.cursor()
        if(isFav == 'true'):
            cursor.execute(f"DELETE FROM favorites WHERE isbn = '{isbn}' AND id = (SELECT id FROM visitor WHERE email = '{email}');")
        else:
            query = f"INSERT INTO favorites (id, isbn) " \
                       f"SELECT id, '{isbn}' FROM visitor WHERE email = '{email}';"
            cursor.execute(query)
        db.connection.commit()
        cursor.close()
        if(isFav == 'true'):
            return jsonify({'status': 'success', 'message': 'Removed from favorites successfully'})
        return jsonify({'status': 'success', 'message': 'Added to favorites successfully'})

    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': f'Database error: {str(e)}'}), 500


@app.route('/notify_book', methods=['POST'])
def notify_book():
    try:
        data = request.json
        isbn = data.get('isbn')
        print('isbn:', isbn)
        email = data.get('email')
        isNotified = data.get('isNotified')
        print('isNotified: ', isNotified)
        cursor = db.connection.cursor()
        if(isNotified == 'true'):
            cursor.execute(f"DELETE FROM set_notification WHERE isbn = '{isbn}' AND id = (SELECT id FROM visitor WHERE email = '{email}');")
        else:
            query = f"INSERT INTO set_notification (id, isbn) " \
                    f"SELECT id, '{isbn}' FROM visitor WHERE email = '{email}';"
            cursor.execute(query)
        db.connection.commit()
        cursor.close()
        if(isNotified == 'true'):
            return jsonify({'status': 'success', 'message': 'Removed from notifications successfully'})
        return jsonify({'status': 'success', 'message': 'Added to notifications successfully'})

    except Exception as e:
        # Handle exceptions (e.g., print the error, log it, etc.)
        print(f"Error: {e}")
        return jsonify({'status': 'error', 'message': f'Database error: {str(e)}'}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)