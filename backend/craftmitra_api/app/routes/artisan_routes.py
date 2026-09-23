from fastapi import APIRouter

router = APIRouter(prefix='/artisans', tags=['artisans'])


@router.get('/profile')
def get_artisan_profile():
    return {'message': 'artisan profile placeholder'}


@router.put('/profile')
def update_artisan_profile():
    return {'message': 'update artisan profile placeholder'}


@router.get('/products')
def get_artisan_products():
    return {'message': 'artisan products placeholder'}
