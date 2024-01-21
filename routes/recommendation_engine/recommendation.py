import pandas as pd
import numpy as np
import pickle
from sklearn.preprocessing import LabelEncoder

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

def return_recommendations(df):
    model_filename = 'routes/recommendation_engine/rf_model.pkl'
    model = load_kmeans_model(model_filename)
    X = fix_dataset(df)

    y_preds = model.predict(X)

    # Add a new column 'y_pred_column' with the values of y_pred
    df['y_pred_column'] = y_preds

    # Drop rows where 'y_pred_column' is 0
    df_filtered = df[df['y_pred_column'] != 0]

    # Drop the 'y_pred_column' from the DataFrame
    df_filtered.drop('y_pred_column', axis=1, inplace=True)

    return df_filtered

# Function to load the k-means model from the pickle file
def load_kmeans_model(model_filename):
    with open(model_filename, 'rb') as model_file:
        model = pickle.load(model_file)
    return model
