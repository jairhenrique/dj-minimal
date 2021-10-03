from django.conf import settings


def pytest_configure():
    settings.configure(
        DEBUG=True,
        ROOT_URLCONF="main",
        SECRET_KEY="fake",
    )
