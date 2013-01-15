# -*- coding: utf-8 -*-

##
# A simple middleware component that lets you use a single Django
# instance to serve multiple versions of your app, chosen by the client
# using the HTTP Accept header.
# In your settings.py, map a value you're looking for in the Accept header
# to a urls.py file.
# HTTP_HEADER_ROUTING_MIDDLEWARE_URLCONF_MAP = {
#     u'application/vnd.api-name.v1': 'app.urls_v1'
# }
##

from django.conf import settings

class HTTPHeaderRoutingMiddleware:

    def process_request(self, request):
        try:
            for content_type in settings.HTTP_HEADER_ROUTING_MIDDLEWARE_URLCONF_MAP:
                if (request.META['HTTP_ACCEPT'].find(content_type) != -1):
                    request.urlconf = settings.HTTP_HEADER_ROUTING_MIDDLEWARE_URLCONF_MAP[content_type]
        except KeyError:
            pass # use default urlconf (settings.ROOT_URLCONF)

    def process_response(self, request, response):
        return response
