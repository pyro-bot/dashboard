from sqlalchemy import Column, String, Integer, DECIMAL, ForeignKey, Table
from . import db

Model = db.Model

# Это таблицы для базы данных
# Миграция (в консоль с включенным окружением0
# flask db migrate
# flask db upgrade

class Hardware(Model):
    __tablename__ = 'hardware'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))

    def __str__(self):
        return self.name


class History(Model):
    __tablename__ = 'histore'

    id = db.Column(db.Integer, primary_key=True)

    hardware_id = db.Column(db.ForeignKey('hardware.id'))

    value = db.Column(db.DECIMAL)

    hardware = db.relationship(Hardware, backref='history')

    def __str__(self):
        return str(self.value)