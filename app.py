from flask import Flask, jsonify, request
from db import get_db_connection

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

@app.route("/api/db_test",methods = ["GET"])
def db_test():
    connection = None

    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1 AS result")
            result = cursor.fetchone()

        return jsonify({
            "success": True,
            "message": "Flask connected to database",
            "database_test": result[0]
        })
    except Exception:
        app.logger.exception("Database connection test failed")

        return jsonify({
            "success": False,
            "message": "Database connection failed. Check the Flask terminal."
        }), 503

    finally:
        if connection is not None:
            connection.close()
            
@app.route("/api/send",methods = ["POST"])
def send_data():
    connection = None

    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("""
            INSERT INTO test (test_text,test_number)
            VALUES (%s,%s,%s)
            """,("hello",25)
            )
        connection.commit()
        return jsonify({"success": True}), 201
    except Exception:
        app.logger.exception("Insert into bins failed")
        if connection is not None:
            connection.rollback()
        return jsonify({
                "success": False,
                "message": "Database insert failed. Check the Flask terminal."
            }), 500
    finally:
        if connection is not None:
            connection.close()
    
"""   
    data = request.get_json()
    if not isinstance(data, dict):

        return jsonify({
            "succes": False,
            "message":"invalid request data"
            }),400
"""   
    

    
if __name__ == "__main__":
    app.run(host = "0.0.0.0",port = "5000", debug=False)

