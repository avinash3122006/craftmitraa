from fastapi import APIRouter

router = APIRouter(prefix='/products', tags=['products'])


@router.post('/create')
def create_product():
    return {'message': 'create product placeholder'}


@router.get('/')
def get_products():
    return {'message': 'list products placeholder'}


@router.get('/{product_id}')
def get_product(product_id: str):
    return {'message': f'get product {product_id} placeholder'}


@router.put('/{product_id}')
def update_product(product_id: str):
    return {'message': f'update product {product_id} placeholder'}


@router.delete('/{product_id}')
def delete_product(product_id: str):
    return {'message': f'delete product {product_id} placeholder'}
