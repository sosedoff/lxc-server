# LXC Web API

lxc-server is a sinatra-based web API to manage LXC containers. 

It uses [lxc-ruby](https://github.com/sosedoff/lxc-ruby) library to access containers.

## Installation

Install via rubygems:

```
gem install lxc-server
```

## Usage

Start server with:

```
lxc-server
```

It will be available at `http://hostname.com:5050/`

More configuration options:

```
Usage: lxc-server [options]
    -v, --version                    Show version
    -b, --bind INTERFACE             Bind server to interface (default: 0.0.0.0)
    -p, --port PORT                  Start server on port (default: 5050)
```

### API Endpoints

General:

    GET /                  # Get current time
    GET /version           # Current gem version
    GET /lxc_version       # Installed LXC version
    GET /containers        # Get container list 
    GET /containers/:name  # Get a single container information

Processes:

    GET /containers/:name/memory    # Get current memory usage
    GET /containers/:name/processes # Get a list of all running processes

Management:

    POST /container/:name/create
    POST /container/:name/destroy

Status change operations:

    POST /container/:name/start 
    POST /container/:name/stop
    POST /container/:name/freeze
    POST /container/:name/unfreeze

## Using with Rails

LXC server could be easily mounted onto existing rails 3 application. 

First, include gem into your `Gemfile`:

```
gem 'lxc-server'
```

Add routes `config/routes.rb`:

```ruby
YourApp::Application.routes.draw do
  mount LXC::Server.new, :at => "/api/lxc"
end
```

## Testing

To run the test suite execute:

```
rake test
```

## License

Copyright (c) 2012 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.