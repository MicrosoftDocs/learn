Often, data about the same individuals is maintained in more than one
table. For example, one university office might have data about each
student's time to completion of degree, while another has data about the
student's tuition and financial aid.

To understand the students' experience, it may be helpful to put the two
datasets together. If the data are in two tables, each with one row per
student, then we would want to put the columns together, making sure to
match the rows so that each student's information remains on a single
row.

Let us do this in the context of a simple example, and then use the
method with a larger dataset.

The table `cones` is one we have encountered earlier. Now suppose each
flavor of ice cream comes with a rating that is in a separate table.

``` python
cones = Table().with_columns(
    'Flavor', make_array('strawberry', 'vanilla', 'chocolate', 'strawberry', 'chocolate'),
    'Price', make_array(3.55, 4.75, 6.55, 5.25, 5.75)
)
cones
```

``` output
| Flavor     | Price |
|------------|-------|
| strawberry | 3.55  |
| vanilla    | 4.75  |
| chocolate  | 6.55  |
| strawberry | 5.25  |
| chocolate  | 5.75  |  

```

``` python
ratings = Table().with_columns(
    'Kind', make_array('strawberry', 'chocolate', 'vanilla'),
    'Stars', make_array(2.5, 3.5, 4)
)
ratings
```

``` output
| Kind       | Stars |
|------------|-------|
| strawberry | 2.5   |
| chocolate  | 3.5   |
| vanilla    | 4     |  

```

Each of the tables has a column that contains ice cream flavors: `cones`
has the column `Flavor`, and `ratings` has the column `Kind`. The
entries in these columns can be used to link the two tables.

The method `join` creates a new table in which each cone in the `cones`
table is augmented with the Stars information in the `ratings` table.
For each cone in `cones`, `join` finds a row in `ratings` whose `Kind`
matches the cone's `Flavor`. We have to tell `join` to use those columns
for matching.

``` python
rated = cones.join('Flavor', ratings, 'Kind')
rated
```

``` output
| Flavor     | Price | Stars |
|------------|-------|-------|
| chocolate  | 6.55  | 3.5   |
| chocolate  | 5.75  | 3.5   |
| strawberry | 3.55  | 2.5   |
| strawberry | 5.25  | 2.5   |
| vanilla    | 4.75  | 4     |  

```

Each cone now has not only its price but also the rating of its flavor.

In general, a call to `join` that augments a table (say `table1`) with
information from another table (say `table2`) looks like this:

``` python
table1.join(table1\_column\_for\_joining, table2,
table2\_column\_for\_joining)
```

The new table `rated` allows us to work out the price per star, which
you can think of as an informal measure of value. Low values are good --
they mean that you are paying less for each rating star.

``` python
rated.with_column('$/Star', rated.column('Price') / rated.column('Stars')).sort(3)
```

``` output
| Flavor     | Price | Stars | \$/Star |
|------------|-------|-------|---------|
| vanilla    | 4.75  | 4     | 1.1875  |
| strawberry | 3.55  | 2.5   | 1.42    |
| chocolate  | 5.75  | 3.5   | 1.64286 |
| chocolate  | 6.55  | 3.5   | 1.87143 |
| strawberry | 5.25  | 2.5   | 2.1     |  

```

Though strawberry has the lowest rating among the three flavors, the
less expensive strawberry cone does well on this measure because it
doesn't cost a lot per star.

>[!NOTE]
> Does the order we list the two tables matter? Let's try
it. As you see it, this changes the order that the columns appear in,
and can potentially changes the order of the rows, but it doesn't make
any fundamental difference.

``` python
ratings.join('Kind', cones, 'Flavor')
```

``` output
| Kind       | Stars | Price |
|------------|-------|-------|
| chocolate  | 3.5   | 6.55  |
| chocolate  | 3.5   | 5.75  |
| strawberry | 2.5   | 3.55  |
| strawberry | 2.5   | 5.25  |
| vanilla    | 4     | 4.75  |  

```

Also note that the join will only contain information about items that
appear in both tables. Let's see an example. Suppose there is a table of
reviews of some ice cream cones, and we have found the average review
for each flavor.

``` python
reviews = Table().with_columns(
    'Flavor', make_array('vanilla', 'chocolate', 'vanilla', 'chocolate'),
    'Stars', make_array(5, 3, 5, 4)
)
reviews
```
| Flavor    | Stars |
|-----------|-------|
| vanilla   | 5     |
| chocolate | 3     |
| vanilla   | 5     |
| chocolate | 4     |  

``` output
| Flavor    | Stars |
|-----------|-------|
| vanilla   | 5     |
| chocolate | 3     |
| vanilla   | 5     |
| chocolate | 4     |  
```

``` python
average_review = reviews.group('Flavor', np.average)
average_review
```

``` output 
| Flavor    | Stars average |
|-----------|---------------|
| chocolate | 3.5           |
| vanilla   | 5             |  

```

We can join `cones` and `average_review` by providing the labels of the
columns by which to join.

``` python
cones.join('Flavor', average_review, 'Flavor')
```

``` output
| Flavor    | Price | Stars average |
|-----------|-------|---------------|
| chocolate | 6.55  | 3.5           |
| chocolate | 5.75  | 3.5           |
| vanilla   | 4.75  | 5             |  

```

Notice how the strawberry cones have disappeared. None of the reviews
are for strawberry cones, so there is nothing to which the `strawberry`
rows can be joined. This might be a problem, or it might not be - that
depends on the analysis we are trying to perform with the joined table.

## Check your knowledge

Data 8X has opened up a candy store where we sell small bags of candies in groups of different amounts. Each bag contains candies of one color. Each row is a bag of candies. Our table "candy" is as follows

| Color | Amount | Price ($) |
|-------|--------|-----------|
| Red   | 4      | 1.30      |
| Green | 6      | 1.20      |
| Blue  | 12     | 2.00      |
| Red   | 7      | 1.75      |
| Green | 9      | 1.40      |
| Green | 2      | 1.00      |  