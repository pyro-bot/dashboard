from flask import Flask
from flask_admin import  Admin
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import dash

app = Flask(__name__)
admin = Admin(app)
dash = dash.Dash(__name__, server=app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///C:/Users/Kross/PycharmProjects/dashboard/test.db'
app.secret_key = 'asdasdadadadadadasdads'
db = SQLAlchemy(app)
migrate = Migrate(app, db)



from . import models, admin_panel, dashboard
