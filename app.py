from flask import Flask, request, jsonify
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import classification_report
import os

app = Flask(__name__)

# Fungsi untuk melatih model dan menyimpannya
def train_model():
    # Membaca dataset lokal
    data = pd.read_csv('penguins_size.csv')  # Pastikan path sesuai dengan lokasi dataset Anda

    # Memeriksa beberapa baris pertama dataset untuk memastikan dataset terbaca
    print(data.head())

    # Menghapus baris yang memiliki nilai null
    data = data.dropna()

    # Encode kolom 'sex' (karena merupakan kategori)
    label_encoder = LabelEncoder()
    data['sex'] = label_encoder.fit_transform(data['sex'])

    # Memilih fitur dan target
    X = data[['culmen_length_mm', 'culmen_depth_mm', 'flipper_length_mm', 'body_mass_g', 'sex']]
    y = data['species']

    # Membagi data menjadi train dan test
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Melatih model Random Forest dengan class_weight untuk mengatasi ketidakseimbangan kelas
    model = RandomForestClassifier(n_estimators=100, random_state=42, class_weight='balanced')
    model.fit(X_train, y_train)

    # Menyimpan model dan label encoder ke file
    joblib.dump(model, 'penguin_species_model.pkl')
    joblib.dump(label_encoder, 'label_encoder.pkl')

    # Menggunakan cross-validation untuk evaluasi lebih lanjut
    scores = cross_val_score(model, X, y, cv=5)
    print(f"Cross-validation scores: {scores}")
    print(f"Mean score: {scores.mean()}")

    # Evaluasi model pada data uji
    y_pred = model.predict(X_test)
    print("Classification Report:")
    print(classification_report(y_test, y_pred))

    return model, label_encoder

# Memeriksa apakah model sudah ada, jika tidak, melatih model
def load_or_train_model():
    if os.path.exists('penguin_species_model.pkl') and os.path.exists('label_encoder.pkl'):
        # Memuat model dan label encoder dari file
        model = joblib.load('penguin_species_model.pkl')
        label_encoder = joblib.load('label_encoder.pkl')
        print("Model and label encoder loaded from files.")
    else:
        print("Model and label encoder not found, training a new model...")
        model, label_encoder = train_model()
    
    return model, label_encoder

# Memuat model dan label encoder
model, label_encoder = load_or_train_model()

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Mendapatkan data JSON dari request
        data = request.get_json()
        print("Data received:", data)

        # Ekstrak fitur dari data input
        features = data['features']

        # Membuat DataFrame untuk fitur
        input_data = pd.DataFrame([features], columns=['culmen_length_mm', 'culmen_depth_mm', 'flipper_length_mm', 'body_mass_g', 'sex'])

        # Melakukan prediksi
        prediction = model.predict(input_data)

        # Mengembalikan hasil prediksi
        return jsonify({'prediction': prediction[0]})

    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)
