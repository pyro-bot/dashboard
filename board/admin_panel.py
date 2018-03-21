from . import app, db, admin
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView

from . import models

# Список вкладок для админки
admin.add_view(ModelView(models.Parametr, db.session))
admin.add_view(ModelView(models.CountersParametr, db.session))
admin.add_view(ModelView(models.Counter, db.session))
admin.add_view(ModelView(models.Val, db.session))
admin.add_view(ModelView(models.History, db.session))