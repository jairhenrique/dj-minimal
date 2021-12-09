import os
import sys
from distutils.util import strtobool

from django.conf import settings
from django.core.asgi import get_asgi_application
from django.core.management import execute_from_command_line
from django.core.wsgi import get_wsgi_application
from django.http import HttpRequest, HttpResponse
from django.urls import path

if not settings.configured:
    settings.configure(
        DEBUG=strtobool(os.getenv("DEBUG", "true")),
        ROOT_URLCONF=sys.modules[__name__],
        SECRET_KEY=os.getenv("SECRET_KEY", "fake"),
        ALLOWED_HOSTS=["*"],
    )


async def index(request: HttpRequest) -> HttpResponse:
    return HttpResponse("<h1>A minimal Django async response!</h1>")


urlpatterns = [
    path(r"", index),
]

asgi_application = get_asgi_application()
wsgi_application = get_wsgi_application()

if __name__ == "__main__":
    execute_from_command_line(sys.argv)
