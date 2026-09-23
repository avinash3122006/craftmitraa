from fastapi import APIRouter

router = APIRouter(prefix='/auth', tags=['auth'])


@router.post('/register')
def register():
    return {'message': 'register endpoint placeholder'}


@router.post('/login')
def login():
    return {'message': 'login endpoint placeholder'}


@router.get('/me')
def me():
    return {'message': 'me endpoint placeholder'}
