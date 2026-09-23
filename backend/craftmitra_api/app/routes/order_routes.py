from fastapi import APIRouter

router = APIRouter(prefix='/orders', tags=['orders'])


@router.post('/')
def create_order():
    return {'message': 'create order placeholder'}


@router.get('/my-orders')
def my_orders():
    return {'message': 'my orders placeholder'}


@router.get('/{order_id}')
def get_order(order_id: str):
    return {'message': f'get order {order_id} placeholder'}


@router.put('/{order_id}/status')
def update_order_status(order_id: str):
    return {'message': f'update order status {order_id} placeholder'}
