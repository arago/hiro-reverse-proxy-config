# HIRO Reverse Proxy Configuration

This project contains the reverse proxy configuration for HIRO based on http://nginx.org/.

We really do value contribution and feedback.

https://hiro.arago.co/

# Contributing

We value contribution, if you have any changes or suggestions, or if you have
changes, please feel free to open a pull request add it here.

If you submit content to this repository, you agree that your contribution will be licensed under the MIT license (see below).

# Installation & Configuration

* Make sure `nginx` is installed
* Install hiro-reverse-proxy-config.rpm or grab the configuration from this repository
* Edit `/etc/nginx/conf.d/hiro.conf` and enable/disabled needed services
* Edit `/etc/nginx/conf.d/servers/*.conf` and configure the servername and the ssl certificates
* Edit `/etc/nginx/conf.d/upstream/*.conf` and fill in your backend servers
* Restart nginx

# Questions and Support

This configuration is community supported.
For questions and support, please refer to our documentation https://docs.hiro.arago.co/ and visit our community http://tabtab.co/ for asking detailed questions.

# Legal

NGINX is a trademark of Nginx Software Inc.

# License  (MIT)
 
Copyright (c) 2016 arago GmbH
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
