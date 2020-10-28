Python code doesn't have to reside in notebooks. Simple programs can provide a useful tool for investigating your data. 

To see this in action, open the program k-Means.py in the GitHub repository in Microsoft Visual Studio Code. The program is largely the code from earlier in this notebook. Now run k-Means.py from the command-line interface on your local computer. It will ask for the number of clusters and the file path for the USDA dataset that you have been using in this section.

### Try it yourself

Run k-Means.py by using several different numbers for $k$ (including those indicated by the WCSS graph). Do they provide intuitive groupings of food groups?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Open a terminal and run the k-means.py file and input 4 for the number of clusters as an example.

  ```input
  $ python3 k-Means.py
  Input number of clusters 4
  Enter file path to USDA-nndb-combined.csv (without quotes around file path) <YOUR_DATA_PATH>
  ```

  The output is:

  ```Output
  Cluster 0
  Beef Products                    255
  Pork Products                     93
  Poultry Products                  86
  Lamb, Veal, and Game Products     39
  Sausages and Luncheon Meats        7
  Fast Foods                         6
  Name: FoodGroup, dtype: int64
  
  Cluster 1
  Baked Products                       176
  Sweets                                82
  Snacks                                69
  Cereal Grains and Pasta               50
  Breakfast Cereals                     22
  Fruits and Fruit Juices               11
  Baby Foods                             8
  Dairy and Egg Products                 8
  Fast Foods                             8
  Meals, Entrees, and Side Dishes        8
  Beverages                              7
  Soups, Sauces, and Gravies             7
  Fats and Oils                          5
  Vegetables and Vegetable Products      5
  Legumes and Legume Products            4
  Nut and Seed Products                  3
  Spices and Herbs                       2
  Name: FoodGroup, dtype: int64
  
  Cluster 2
  Vegetables and Vegetable Products    157
  Fruits and Fruit Juices              120
  Baby Foods                            60
  Soups, Sauces, and Gravies            41
  Dairy and Egg Products                26
  Beverages                             16
  Cereal Grains and Pasta               12
  Sweets                                11
  Legumes and Legume Products           11
  Meals, Entrees, and Side Dishes        9
  Breakfast Cereals                      6
  Restaurant Foods                       5
  Fats and Oils                          1
  Spices and Herbs                       1
  Nut and Seed Products                  1
  Name: FoodGroup, dtype: int64
  
  Cluster 3
  Breakfast Cereals                    28
  Snacks                                5
  Spices and Herbs                      3
  Poultry Products                      3
  Beef Products                         3
  Beverages                             3
  Vegetables and Vegetable Products     2
  Baby Foods                            2
  Cereal Grains and Pasta               1
  Baked Products                        1
  Name: FoodGroup, dtype: int64
  ```

</details>

<br /><br />

***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> One reason for Python's popularity in the data-science community is its extreme flexibility. It provides numerous tools that data scientists can use in a variety of ways.
