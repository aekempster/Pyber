

items = ["shirt", "coffee", "car", "computer"]
prices = []
for num in range(4):
    price = input(f"How much was your {items[num]}? ")
    prices.append(price)

# Turn each "price string" into an actual number
for index, price in enumerate(prices):
    price = prices[index]
    prices[index] = int(price)
