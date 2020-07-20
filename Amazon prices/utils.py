import requests


def check_products_list(products):
    count = 0
    for product in products:
        if 'iphone' in product.text.lower():
            count = count + 1

    limit = len(products) * 0.8
    if count >= limit:
        return True
    else:
        return False


def find_more_expensive(products, values):
    most_expensive = 0
    for product, value in zip(products, values):
        if 'iphone' in product.text.lower():
            current_value = float(value.text.replace('R$', '').replace(' ', '').replace('.', ''))
            if current_value > most_expensive:
                most_expensive = current_value
    return most_expensive


def find_iphone_less_expensive(products, values):
    less_expensive = 999999
    for product, value in zip(products, values):
        if 'iphone' in product.text.lower():
            current_value = float(value.text.replace('R$', '').replace(' ', '').replace('.', ''))
            if current_value < less_expensive:
                less_expensive = current_value
    return less_expensive


def find_not_iphones(products):
    not_iphones = []
    for product in products:
        if 'iphone' not in product.text.lower():
            not_iphones.append(product)
    return not_iphones


def convert_to_dolar(value):
    request = requests.get('https://api.exchangeratesapi.io/latest', {'base': 'USD'})
    data = request.json()
    exchange_value = data['rates']['BRL']

    return int(value) / exchange_value


def check_cheapest_values(cheapest, products, values):
    is_cheapest = True
    for product, value in zip(products, values):
        if 'iphone' not in product.text.lower():
            current_value = float(value.text.replace('R$', '').replace(' ', '').replace('.', ''))
            if cheapest > current_value:
                is_cheapest = False
    return is_cheapest
