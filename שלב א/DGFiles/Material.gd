
[General]
Version=1

[Preferences]
Username=
Password=2055
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SARITITI
Name=MATERIAL
Count=10..20

[Record]
Name=MATERIAL_ID
Type=NUMBER
Size=5
Data=Random(100, 99999)
Master=

[Record]
Name=NAME
Type=VARCHAR2
Size=15
Data=List('Cheese', 'Meat', 'Tomatoes', 'Onions', 'Garlic', 'Carrots', 'Potatoes', 'Peppers', 'Mushrooms', 'Spinach', 'Broccoli', 'Cauliflower', 'Zucchini', 'Eggplant', 'Cabbage', 'Lettuce', 'Kale', 'Arugula', 'Chard', 'Basil', 'Parsley', 'Cilantro', 'Thyme', 'Rosemary', 'Oregano', 'Dill', 'Mint', 'Sage', 'Chives', 'Tarragon', 'Ginger', 'Turmeric', 'Cinnamon', 'Nutmeg', 'Cloves', 'Allspice', 'Cumin', 'Coriander', 'Paprika', 'Chili Powder', 'Black Pepper', 'Salt', 'Sugar', 'Honey', 'Maple Syrup', 'Molasses', 'Vanilla', 'Almond Extract', 'Lemon Juice', 'Lime Juice', 'Orange Juice', 'Apple Cider Vinegar', 'Balsamic Vinegar', 'Red Wine Vinegar', 'White Wine Vinegar', 'Rice Vinegar', 'Soy Sauce', 'Worcestershire Sauce', 'Tabasco', 'Sriracha', 'Ketchup', 'Mustard', 'Mayonnaise', 'Barbecue Sauce', 'Ranch Dressing', 'Olive Oil', 'Vegetable Oil', 'Sesame Oil', 'Peanut Oil', 'Canola Oil', 'Butter', 'Margarine', 'Lard', 'Shortening', 'Yogurt', 'Milk', 'Cream', 'Sour Cream', 'Buttermilk', 'Eggs', 'Flour', 'Cornmeal', 'Rice', 'Pasta', 'Quinoa', 'Couscous', 'Oats', 'Polenta', 'Bread', 'Tortillas', 'Crackers', 'Beans', 'Lentils', 'Chickpeas', 'Peas', 'Peanuts', 'Almonds', 'Walnuts', 'Pecans', 'Cashews', 'Hazelnuts', 'Pistachios', 'Macadamia Nuts', 'Sunflower Seeds', 'Pumpkin Seeds', 'Chia Seeds', 'Flaxseeds', 'Sesame Seeds', 'Hemp Seeds', 'Coconut', 'Avocado', 'Bananas', 'Apples', 'Oranges', 'Lemons', 'Limes', 'Grapefruit', 'Strawberries', 'Blueberries', 'Raspberries', 'Blackberries', 'Cherries', 'Peaches', 'Plums', 'Apricots', 'Nectarines', 'Pineapple', 'Mango', 'Papaya', 'Kiwi', 'Grapes', 'Watermelon', 'Cantaloupe', 'Honeydew', 'Pomegranate', 'Figs', 'Dates', 'Prunes', 'Raisins', 'Olives', 'Pickles', 'Capers', 'Anchovies', 'Tuna', 'Salmon', 'Shrimp', 'Crab', 'Lobster', 'Scallops', 'Clams', 'Mussels', 'Oysters', 'Chicken', 'Turkey', 'Duck', 'Beef', 'Pork', 'Lamb', 'Veal', 'Goat', 'Venison', 'Rabbit', 'Quail', 'Pheasant', 'Bison', 'Buffalo', 'Tofu', 'Tempeh', 'Seitan', 'TVP', 'Edamame', 'Miso', 'Natto', 'Tahini', 'Hummus', 'Pesto', 'Salsa', 'Guacamole', 'Chutney', 'Relish', 'Jam', 'Jelly', 'Marmalade', 'Peanut Butter', 'Almond Butter', 'Hazelnut Spread', 'Tahini', 'Miso Paste', 'Tomato Paste', 'Tomato Sauce', 'Coconut Milk', 'Coconut Cream', 'Condensed Milk', 'Evaporated Milk', 'Stock', 'Broth', 'Bouillon', 'Gelatin', 'Agar', 'Pectin', 'Yeast', 'Baking Powder', 'Baking Soda', 'Cornstarch', 'Arrowroot', 'Tapioca', 'Gelatin', 'Agar', 'Pectin', 'Vanilla Beans', 'Chocolate', 'Cocoa Powder', 'Caramel', 'Butterscotch', 'Marshmallows', 'Ice Cream', 'Sorbet', 'Gelato', 'Sherbet'
=)
Master=

[Record]
Name=TYPE
Type=VARCHAR2
Size=15
Data=List('plant', 'meat', 'dairy', 'dried food')
Master=

[Record]
Name=EXPIRYDATE
Type=DATE
Size=
Data=Random(26/05/2024, 26/05/2026)
Master=

