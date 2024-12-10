import pytest
from httpx import AsyncClient, ASGITransport
from app.main import app

@pytest.mark.asyncio
async def test_create_book(override_get_db):
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
        response = await client.post("/books/", json={"title": "Test Book", "author": "Author", "price": 100})
    assert response.status_code == 200
    assert response.json()["title"] == "Test Book"

@pytest.mark.asyncio
async def test_get_books(override_get_db):
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
        response = await client.get("/books/")
    assert response.status_code == 200
