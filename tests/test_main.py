from http import HTTPStatus

import pytest


@pytest.mark.asyncio
async def test_should_pass(async_client):
    response = await async_client.get("/")
    assert response.status_code == HTTPStatus.OK
    assert response.content == b"<h1>A minimal Django async response!</h1>"
