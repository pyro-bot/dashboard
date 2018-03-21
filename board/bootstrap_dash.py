from functools import singledispatch

import dash_html_components as html
import dash_core_components as dcc
from dash.dependencies import Input, Output, State

from . import dash as app


callbacks_list = []

def callback(output, input, state=None):
    def main_wrapper(f):
        global callbacks_list
        callbacks_list.append({'f':f, 'input':input, 'output':output, 'state':state or []})
        return f
    return main_wrapper

def callback_init():
    global callbacks_list
    for item in  callbacks_list[:]:
        app.callback(
            output=item['output'],
            inputs=item['input'],
            state=item['state']
        )(item['f'])
        callbacks_list.remove(item)



def Row(children):
    if not isinstance(children, list):
        children = [children]
    return html.Div(className='row', children=children)


@singledispatch
def Col(arg):
    if not isinstance(arg, list):
        arg = [arg]
    return html.Div(className='col-xs-12', children=arg)


@Col.register(str)
def Col_ext(cls, children):
    if not isinstance(children, list):
        children = [children]
    return html.Div(className=cls, children=children)


def Container(children, fluid=False):
    if not isinstance(children, list):
        children = [children]
    return html.Div(className='container' if not fluid else 'container', children=children)




def Label(children=None, id=None, style=None, className=None):
    if children is not None and not isinstance(children, list):
        children = [children]

    param = dict()
    if style is not None:
        param['style'] = style
    if className is not None:
        param['className'] = className
    if  id is not None:
        param['id'] = id
    if children is not None:
        param['children'] = children

    return html.Span(**param)
