from fastapi import FastAPI, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select  # Import select here
from app.database import get_db
from app.models import Book
from app.schemas import BookCreate, BookResponse
from app.database import init_db

app = FastAPI()

@app.on_event("startup")
async def on_startup():
    # Ensure the database is initialized
    await init_db()

@app.post("/books/", response_model=BookResponse,status_code=201)
async def create_book(book: BookCreate, db: AsyncSession = Depends(get_db)):
    new_book = Book(**book.model_dump())
    db.add(new_book)
    await db.commit()
    await db.refresh(new_book)
    return new_book

@app.get("/books/", response_model=list[BookResponse])
async def get_books(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Book))  # Using select
    return result.scalars().all()
