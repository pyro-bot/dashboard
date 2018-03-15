import dash_html_components as html

def get_layout(body=None):
    return html.Div(className='container', children=[
        get_header('Показания счетчиков'),
        get_content(body or [])
    ])


def get_header(title):
    return html.Div(className='row', children=[
        html.Div(className='col-xs-12', children=[html.H1(title, className='align-center')]),
    ])

def get_content(body):
    return html.Div(className='row', children=[
        html.Div(className='col-xs-12', children=body() if callable(body) else body)
    ])