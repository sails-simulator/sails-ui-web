sails-ui-web
============

A web interface for sailsd.

The python server requires python 3.5, aiohttp and python-sailsd.

### Run inside a virtualenv:

    $ virtualenv -p python3.5 env
    $ source env/bin/activate
    $ pip install -r requirements.txt

    $ ./sails-ui-web

### Run with Docker

Build:

    $ docker build -t sails-simulator/ui-web .

Run:

As this requires `sailsd` to be accessible, you will need to have it running and available. 

Configure via:

    $ docker run -e SAILSD_HOST=my-sailsd-host -e SAILSD_PORT=3333 -p 8080 sails-simulator/ui-web

