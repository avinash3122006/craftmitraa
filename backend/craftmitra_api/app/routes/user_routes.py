from fastapi import APIRouter

router = APIRouter(prefix='/users', tags=['users'])


@router.get('/profile')
def get_profile():
    return {'message': 'user profile placeholder'}


@router.put('/profile')
def update_profile():
    return {'message': 'update profile placeholder'}
