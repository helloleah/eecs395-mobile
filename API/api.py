from flask import Flask
from flask_restful import Resource, Api, reqparse
from flaskext.mysql import MySQL
import db_info

app = Flask(__name__)
api = Api(app)

mysql = MySQL()
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = db_info.user
app.config['MYSQL_DATABASE_PASSWORD'] = db_info.password
app.config['MYSQL_DATABASE_DB'] = 'sensors'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_PORT'] = 8889
mysql.init_app(app)


class GetNumRecords(Resource):
    def get(self):
        cursor = conn.cursor()
        command = 'SELECT COUNT(*) FROM sensordata'
        cursor.execute(command)
        data = cursor.fetchone()
        # Strip out all those parentheses and commas
        dataStr = str(data).replace("(", "")
        dataStr = dataStr.replace(")", "")
        dataStr = dataStr.replace(",", "")
        return {'num_records': '{}'.format(dataStr)}


class GetBuildingData(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('building', type=str)
        args = parser.parse_args()
        building = args['building']

        cursor = conn.cursor()
        command = 'SELECT {} FROM sensordata'.format(building)
        cursor.execute(command)
        data = cursor.fetchall()
        # Strip out all those parentheses and commas
        dataStr = str(data).replace("(", "")
        dataStr = dataStr.replace(")", "")
        dataStr = dataStr.replace(",", "")
        return {'result': '{}'.format(dataStr)}


class GetDateTimes(Resource):
    def get(self):
        cursor = conn.cursor()
        command = 'SELECT DATE_TIME FROM sensordata'
        cursor.execute(command)
        data = cursor.fetchall()
        # Strip out all those parentheses and commas
        dataStr = str(data).replace("(", "")
        dataStr = dataStr.replace(")", "")
        dataStr = dataStr.replace(",", "")
        return {'result': '{}'.format(dataStr)}

api.add_resource(GetNumRecords, '/GetNumRecords')
api.add_resource(GetBuildingData, '/GetBuildingData')
api.add_resource(GetDateTimes, '/GetDateTimes')

if __name__ == '__main__':
    conn = mysql.connect()
    app.run(debug=True)
