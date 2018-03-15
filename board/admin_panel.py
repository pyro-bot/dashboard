from . import app, db, admin
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView

from . import models

# Список вкладок для админки
admin.add_view(ModelView(models.Hardware, db.session))
admin.add_view(ModelView(models.History, db.session))