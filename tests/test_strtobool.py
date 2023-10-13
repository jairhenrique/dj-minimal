import pytest
from main import strtobool


@pytest.mark.parametrize("value", ["y", "yes", "t", "true", "on", "1"])
def test_should_return_true(value):
    assert strtobool(value)


@pytest.mark.parametrize("value", ["n", "no", "f", "false", "off", "0", "other"])
def test_should_return_false(value):
    assert strtobool(value) is False
