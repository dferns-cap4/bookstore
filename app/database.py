from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "postgresql+asyncpg://fastapi_user:secret_password@db/fastapi_db"
#DATABASE_URL = "postgresql+asyncpg://admin:o4vHj7ZXBOVpA1b6WOARHV0swc40MORC@dpg-ct8r9u56l47c73d6ksk0-a.frankfurt-postgres.render.com/devops_1v6d"

engine = create_async_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)

# Define the Base for model definitions
Base = declarative_base()



async def get_db():
    async with SessionLocal() as session:
        yield session

async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)