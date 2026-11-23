from flask import Flask, jsonify, request

app = Flask(__name__)
@app.route("/")
def test():
    return jsonify({
        "succes":True
    }),200

@app.route("/api/bin_data/",methods = ["POST"])
def upload_sim_data():

    data = request.get_json()

    for bin_id,bin_items in data.items():

        print("Bin ID:", bin_id)
        print("Bin data:",bin_items)

    return jsonify({
        "succes":True
        }), 200

if __name__ == "__main__":
    app.run(host = "0.0.0.0",port = "5000", debug=False)
