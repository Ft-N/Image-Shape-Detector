from flask import Flask,request,jsonify,Response
from flask import render_template
from flask_cors import CORS
from clips import Environment
from backend import shape
from backend import detection
from werkzeug.utils import secure_filename
import time
import os



app = Flask(__name__)
CORS(app)
app.config['UPLOAD_FOLDER'] = 'uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def allowed_file(filename):
	return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def cors(resp):
	resp.headers['Access-Control-Allow-Origin'] = '*'
	resp.headers['Access-Control-Allow-Methods'] = 'POST'
	resp.headers['Access-Control-Max-Age'] = 1000
	resp.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization, X-Requested-With'

	return resp

@app.route('/',methods=['POST'])
def home():
	res = {}
	if 'file' not in request.files:
		res['status'] = 'ERROR'
		res['msg'] = 'No file submitted'
		return cors((jsonify(res)))
	file = request.files['file']
	# if user does not select file, browser also
	# submit an empty part without filename
	if not allowed_file(file.filename):
		res['status'] = 'ERROR'
		res['msg'] = 'Only png, jpg, and jpeg format allowed'
		return cors(jsonify(res))
	else :
		filename = secure_filename(file.filename)
		file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
		results = detection.detectImage('uploads/'+filename)
		env = Environment()
		env.load('backend/shape.clp')
		shape.insert_angle(env,results)
		res['activations'] = shape.get_activations(env)
		env.run()
		res['rules'] = shape.get_rules(env)
		res['facts'] = shape.get_facts(env)
		
		return cors(jsonify(res))

if __name__ == "__main__":
	app.run(debug=True)