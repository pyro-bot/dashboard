from . import dash as app, db
from . import models
from dash.dependencies import Input, Output, State
import dash_core_components as dcc
import dash_html_components as html

import random

from . import page
from board.bootstrap_dash import *

rnd = random.Random()

# app.css.config.serve_locally = True
# app.scripts.config.serve_locally = True

# Append an externally hosted CSS stylesheet
app.css.append_css({
    "external_url": ['/static/css/bootstrap.css', '/static/css/bootstrap-theme.css']})



# Append an externally hosted JS bundle
# my_js_url = 'https://unkpg.com/some-npm-package.js'
# app.scripts.append_script({
#     "external_url": my_js_url
# })

# Метод нужен для первоначальной отрисовки страицы
def render():
    return page.get_layout(html.Div([
        dcc.Interval(
            id='main-tick',
            interval=2 * 1000,  # in milliseconds
            n_intervals=0
        ),
        html.H1('Просмотр показаний счетчиков'),
        html.Div(className='row', children=[
            html.Form(className='col-xs-12 form', children=[
                html.H3('Счетчик'),
                dcc.RadioItems(
                    options=[{'label': hard.name, 'value':hard.id} for hard in db.session.query(models.CountersParametr).all()],
                    value=1,
                    id='select-hardware',
                    className='radio',
                    # labelClassName='row',
                    # inputClassName='col-xs-6',
                    labelStyle={'margin':'5px'}
                )
            ]),
            html.Div([
                html.H3('Показания'),
                dcc.Graph(id='history-graph')
            ])
        ])
    ]))

# Это описание веб страницы
app.layout = render

callback_init()

# @app.callback(Output('simple-label', 'children'), [Input('main-nav', 'value')])
# def navbar(value):
#     return Label(value)


# Это пример коллбека, выполняется по таймеру и обновляет страницу без ее перезагрузки (декораток творит магию)
@app.callback(Output('history-graph', 'figure'),
              [Input('main-tick', 'n_intervals'), Input('select-hardware', 'value')])
def get_history(tick, param):
    # Создаем запимь в для базы данных
    new = models.History(value=rnd.random(), counters_parametr=rnd.choice(db.session.query(models.CountersParametr).all()))
    # Регистрируем запись в базе (это какбы insert, но без его выполнения)
    db.session.add(new)
    # Применяем все изменения в базе (инсерты и апдейты) и все это еще комитится
    # Если коммит не нужен, то нужно выполнить db.session.flush()
    # Внимание: читать из базы пока изменения не будут применены нельзя (либо commit либо flush0
    # открытую сессию к базе закрывать не надо, флас это делает сам (и открывает сам)
    # доступ к базе потоко безопасен
    db.session.commit()
    return {

        'data': [
            {
                'y': [record.value for record in db.session.query(models.History).filter_by(id_counters_parametrs=param).order_by(models.History.id_history.desc()).limit(20).all()],
                # 'marker': {
                #     'color': 'rgb(55, 83, 109)'
                # },
                'type': 'scatter',
            }
        ],

        'layout': {
            'margin': {
                'l': 30,
                'r': 0,
                'b': 30,
                't': 0
            },
            'legend': {'x': 0, 'y': 1}
        }
    }