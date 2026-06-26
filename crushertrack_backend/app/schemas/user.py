from pydantic import BaseModel
from pydantic import EmailStr

from datetime import datetime


class UserCreate(BaseModel):

    username: str

    email: EmailStr

    password: str


class UserLogin(BaseModel):

    email: EmailStr

    password: str


class UserResponse(BaseModel):

    id: int

    username: str

    email: EmailStr

    role: str

    is_active: bool

    created_at: datetime

    class Config:
        from_attributes = True
class LoginUser(BaseModel):
    id: int
    username: str
    email: str
    role: str

    class Config:
        from_attributes = True


class Token(BaseModel):
    access_token: str
    token_type: str
    user: LoginUser


class TokenData(BaseModel):
    email: str | None = None