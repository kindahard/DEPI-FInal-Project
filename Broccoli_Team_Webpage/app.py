import pandas as pd
from flask import Flask, request, jsonify, render_template
import pickle
import sklearn

# Create flask app
app = Flask(__name__)

# Load the scaler and model
review_model = pickle.load(open('model_review.pkl', "rb"))
churn_model = pickle.load(open('model_churn.pkl', "rb"))

dataset = pd.read_csv('dataset_features_v1-5.csv')


@app.route("/")
def Home():
    return render_template("index.html")

@app.route("/predict", methods=["POST"])
def predict():
    # Get form data
    input_data = [str(x) for x in request.form.values()]
    prediction_type = request.form.get("prediction_type")
    
    columns = ['order_id', 'customer_id', 'order_item_id', 'product_id', 
               'seller_id', 'customer_unique_id', 'review_id']
    
    input_data = pd.DataFrame([input_data[:-1]], columns=columns)
    input_data['order_item_id'] = int(input_data['order_item_id'])

    # Merge with dataset to get the required features
    X = pd.merge(input_data, dataset, on=columns, how='inner').head(1)
    X = X.drop(columns=columns)
    
    # Predict based on the selected type
    if prediction_type == "review":
        X = X.drop(columns=['review_score'])
        prediction = review_model.predict(X)[0]
        prediction_text = f"Score {prediction}"
    elif prediction_type == "churn":
        X = X.drop(columns=['churn'])
        prediction = churn_model.predict(X)[0]
        prediction_text = "Churned" if prediction == 1 else "Not Churned"

    # Return the prediction as JSON
    return jsonify({'prediction': prediction_text})

if __name__ == "__main__":
    app.run(depug=True)
