#!/usr/bin/env python3

import asyncio
import json
import logging

from aiohttp import web
import sailsd

logging.basicConfig(level=logging.DEBUG)


async def get_handler(request):
    name = request.match_info.get('file', None)
    if name is None:
        name = 'index.html'
    if name in {'index.html'}:
        with open(name) as f:
            body = f.read()
        return web.Response(body=body.encode('utf-8'),
                            content_type='text/html')
    else:
        return web.Response(status=404)


async def wshandler(request):
    app = request.app
    ws = web.WebSocketResponse()
    await ws.prepare(request)
    app['sockets'].append(ws)

    async for msg in ws:
        if msg.tp == aiohttp.MsgType.text:
            print('text')
            if msg.data == 'something':
                print('something')
                ws.send_str(json.dumps({'some_data': 'something'}))
        if msg.tp == web.MsgType.close:
            break

    app['sockets'].remove(ws)
    return ws


async def listen_to_sailsd(app):
    try:
        sails = sailsd.Sailsd()
        while True:
            print('listen_to_sailsd')
            for ws in app["sockets"]:
                ws.send_str(json.dumps(
                    sails.request('latitude',
                                  'longitude',
                                  'heading',
                                  'sail-angle',
                                  'rudder-angle',
                                  'wind-speed',
                                  'wind-angle')
                ))
            await asyncio.sleep(0.05)  # TODO: decrease this length of time
    except asyncio.CancelledError:
        print('Cancel sailsd listener: close connections...')


async def start_background_tasks(app):
    print('starting sailsd_listener')
    app['sailsd_listener'] = app.loop.create_task(listen_to_sailsd(app))


app = web.Application()
app.on_startup.append(start_background_tasks)
app.router.add_route('GET', '/ws', wshandler)
app.router.add_route('GET', '/{file}', get_handler)
app.router.add_route('GET', '/', get_handler)
app['sockets'] = []

web.run_app(app)
