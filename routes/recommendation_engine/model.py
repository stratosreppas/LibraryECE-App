import numpy as np
from sklearn.cluster import KMeans
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler, LabelEncoder
import pandas as pd
import numpy as np
import pickle


def fix_dataset(df):

    df['dewey'] = pd.to_numeric(df['dewey'], errors='coerce')
    df['year'] = pd.to_numeric(df['year'], errors='coerce', downcast='integer').fillna(0).astype(int)

    # criteria_columns = ['publisher', 'author', 'year', 'dewey', 'semester', 'interest']
    # recommendation_column = 'recommend'

    publisher_encoder = LabelEncoder()
    vec_publisher = publisher_encoder.fit_transform(df['publisher'].tolist())
    author_encoder = LabelEncoder()
    vec_author = author_encoder.fit_transform(df['author'].tolist())
    year_encoder = LabelEncoder()
    vec_year = year_encoder.fit_transform(df['year'].tolist())
    dewey_encoder = LabelEncoder()
    vec_dewey = dewey_encoder.fit_transform(df['language'].tolist())
    semester_encoder = LabelEncoder()
    vec_semester = semester_encoder.fit_transform(df['language'].tolist())
    interest_encoder = LabelEncoder()
    vec_interest = interest_encoder.fit_transform(df['language'].tolist())

    X = np.concatenate((vec_interest.reshape((-1, 1)),
                        vec_semester.reshape((-1, 1)),
                        vec_author.reshape((-1, 1)),
                        vec_publisher.reshape((-1, 1)),
                        vec_year.reshape((-1, 1)),
                        vec_dewey.reshape((-1, 1)),
                        ), axis=1)
    return X
def train_model(df):
    try:
        print("Training Model...")

        X = fix_dataset(df)
        y = df['recommend'].tolist()


        # Create a Random Forest classifier
        rf_classifier = RandomForestClassifier(n_estimators=10, random_state=42)

        # Fit the classifier on the training data
        rf_classifier.fit(X, y)
        print('Model Trained!')

        model_filename = 'routes/recommendation_engine/rf_model.pkl'
        with open(model_filename, 'wb') as model_file:
            pickle.dump(rf_classifier, model_file)

        # Print a message indicating that the model has been saved
        print(f"\nTrained Random Forrest model saved to {model_filename}")
        return

    except Exception as e:
        print('Error' + str(e))
        return