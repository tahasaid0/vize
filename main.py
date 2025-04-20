Main.py KODLARI

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Veritabanı Bağlantısı
DATABASE_URL = "postgresql://postgres:post1234@localhost:5432/okul"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()

# FastAPI Başlat
app = FastAPI()

# CORS Ayarları
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Üretimde sadece frontend IP eklenmeli!
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Ana Sayfa
@app.get("/")
def root():
    return {"message": "FastAPI çalışıyor!"}

# SQLAlchemy Modeli (tasks tablosuna uygun)
class Task(Base):
    __tablename__ = "tasks"
    id = Column(Integer, primary_key=True, index=True)
    ad = Column(String)
    soyad = Column(String)
    yas = Column(Integer)
    sinif = Column(Integer)
    puan = Column(Integer)

# Tabloyu oluştur (varsa atla)
Base.metadata.create_all(bind=engine)

# Pydantic Modelleri
class TaskCreate(BaseModel):
    ad: str
    soyad: str
    yas: int
    sinif: int
    puan: int

class TaskOut(TaskCreate):
    id: int

# CRUD: Yeni Task Ekle
@app.post("/tasks/", response_model=TaskOut)
def task_ekle(task: TaskCreate):
    db = SessionLocal()
    db_task = Task(**task.dict())
    db.add(db_task)
    db.commit()
    db.refresh(db_task)
    db.close()
    return db_task

# CRUD: Task Listele
@app.get("/tasks/", response_model=List[TaskOut])
def task_listele():
    db = SessionLocal()
    tasks = db.query(Task).all()
    db.close()
    return tasks

# CRUD: Task Güncelle
@app.put("/tasks/{task_id}", response_model=TaskOut)
def task_guncelle(task_id: int, guncel_task: TaskCreate):
    db = SessionLocal()
    task = db.query(Task).filter(Task.id == task_id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task bulunamadı")
    for key, value in guncel_task.dict().items():
        setattr(task, key, value)
    db.commit()
    db.refresh(task)
    db.close()
    return task

# CRUD: Task Sil
@app.delete("/tasks/{task_id}")
def task_sil(task_id: int):
    db = SessionLocal()
    task = db.query(Task).filter(Task.id == task_id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task bulunamadı")
    db.delete(task)
    db.commit()
    db.close()
    return {"message": "Task silindi"}
