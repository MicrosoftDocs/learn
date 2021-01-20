We explored arrays in the previous section, and we said that arrays are the foundation for slices and maps. You'll understand why in a moment. Like arrays, a slice is a data type in Go to represent a sequence of elements that have the same type. But the more significant difference with arrays is that the size of a slice is dynamic, not fixed.

A slice is simply a data structure on top of an array known as the *underlying array*. Therefore, with a slice, you can either have **access to the whole underlying array or only to a subsequence of elements**.

A slice has only three components:

- A **pointer** to the first element reachable of the underlying array (not necessarily the array's first element).
- A **length** that indicates the number of elements in the slice.
- A **capacity** that shows the number of elements between the start of a slice and the end of the underlying array.

The image below represents what a slice is:

:::image type="content" source="media\go-slices.jpg" alt-text="Diagram showing how slices in Go look.":::

Notice how the slice is only a subset of the underlying array. Let's see how you can represent the above image in code.

## Declaring and initializing a slice

To declare a slice, you do it in the same way you declare an array. For instance, the following code represents what you saw in the slice image:

```go
package main

import "fmt"

func main() {
    months := []string{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
    fmt.Println(months)
    fmt.Println("Length:", len(months))
    fmt.Println("Capacity:", cap(months))
}
```

When you run the code, you see the following output:

```output
[January February March April May June July August September October November December]
Length: 12
Capacity: 12
```

Notice how, at the moment, a slice doesn't differ too much from an array; you declare them in the same way. To get the information from a slice, you can use the built-in functions `len()` and `cap()`. We'll continue using these functions to confirm that a slice can have a subsequent number of elements from an underlying array.

## Slicing items

Go has support for the slice operator `s[i:j]`, where `s` represents the array, `i` represents the pointer to the first element of the array (or another slice) that will use, and `j` that represents in which position is the last element the slice will use. In other words, a slice can refer only to a subset of elements.

For instance, let's say that you'd like to have four variables representing each quarter of the year. The following image illustrates how that looks in Go:

:::image type="content" source="media\go-slices-multiple.jpg" alt-text="Diagram showing how multiple Slices in Go look.":::

To represent in code what you saw in the image above, you could use the following code:

```go
package main

import "fmt"

func main() {
    months := []string{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
    quarter1 := months[0:3]
    quarter2 := months[3:6]
    quarter3 := months[6:9]
    quarter4 := months[9:12]
    fmt.Println(quarter1, len(quarter1), cap(quarter1))
    fmt.Println(quarter2, len(quarter2), cap(quarter2))
    fmt.Println(quarter3, len(quarter3), cap(quarter3))
    fmt.Println(quarter4, len(quarter4), cap(quarter4))
}
```

When you run the code, you get the following output:

```output
[January February March] 3 12
[April May June] 3 9
[July August September] 3 6
[October November December] 3 3
```

Notice how the length of the slices is the same, but the capacity is different. Let's explore the `quarter2` slice. When you declare this slice, you're saying you want the slice to start at position number three, and the last element is located at position number six. Therefore, the slice's length is three elements, but the capacity is 9 because the underlying array has more elements or positions available but not visible to the slice. For instance, if you try to print out something like this `fmt.Println(quarter2[3])`, you'll get the following error: `panic: runtime error: index out of range [3] with length 3`.

The capacity of a slice only tells you how much you can extend a slice. Therefore, you could create an extended slice from `quarter2`, like this:

```go
package main

import "fmt"

func main() {
    months := []string{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
    quarter2 := months[3:6]
    quarter2Extended := quarter2[:4]
    fmt.Println(quarter2, len(quarter2), cap(quarter2))
    fmt.Println(quarter2Extended, len(quarter2Extended), cap(quarter2Extended))
}
```

When you run the above code, you get the following output:

```output
[April May June] 3 9
[April May June July] 4 9
```

Notice that when declaring the `quarter2Extended` variable, we didn't have to specify the initial position (`[:4]`). When you do that, Go assumes that you want the first position of the slice. You can do the same for the last position (`[1:]`), and Go will assume that you want to reference all the elements up to the latest position of a slice (`len()-1`).

## Appending items

Now that we've explored how slices work and how they're similar to arrays, it's time to cover how they differ from arrays. And the first difference is that size of a slice is not fixed; it's dynamic. Once you've created a slice, you can add more elements to it, and the slice will be extended. You'll see in a moment what happens to the underlying array.

To add an element to a slice, Go offers the `append(slice, element)` built-in function. You need to send the slice you want to modify and the element you want to append as values to the function. The `append` function then returns a new slice that you need to store in a variable (it could be the same variable for the slice you're changing).

Let's see how this looks in code:

```go
package main

import "fmt"

func main() {
    var numbers []int
    for i := 0; i < 10; i++ {
        numbers = append(numbers, i)
        fmt.Printf("%d\tcap=%d\t%v\n", i, cap(numbers), numbers)
    }
}
```

When you run the above code, you should see the following output:

```output
0       cap=1   [0]
1       cap=2   [0 1]
2       cap=4   [0 1 2]
3       cap=4   [0 1 2 3]
4       cap=8   [0 1 2 3 4]
5       cap=8   [0 1 2 3 4 5]
6       cap=8   [0 1 2 3 4 5 6]
7       cap=8   [0 1 2 3 4 5 6 7]
8       cap=16  [0 1 2 3 4 5 6 7 8]
9       cap=16  [0 1 2 3 4 5 6 7 8 9]
```

That was an interesting output, right? Especially for what the call to the `cap()` function is returning. Everything looks normal until the third iteration, where the capacity changes to 4, and there are only three elements in the slice. In the fifth iteration, the capacity varies again to 8 and in the ninth one to 16. 

Do you notice a pattern from the capacity output? Well, **when a slice doesn't have enough capacity to hold more elements, Go doubles its capacity**. This means that it creates a new underlying array with the new capacity. You don't have to do anything for this to happen. Go does it automatically. However, you need to be cautious because at some point, a slice might have way more capacity than it needs, and you'll be wasting memory.

## Removing items

You might be wondering, what about removing elements? Well, Go doesn't have a built-in function to remove elements from a slice. However, you can simply use the slice operator `s[i:j]` we covered before to create a new slice with only the elements you need.

For instance, the following code removes an element from a slice:

```go
package main

import "fmt"

func main() {
    letters := []string{"A", "B", "C", "D", "E"}
    remove := 2

    fmt.Println("Before", letters)

    letters[remove] = letters[len(letters)-1]
    letters = letters[:len(letters)-1]

    fmt.Println("After", letters)
}
```

When you run the above code, you get the following output:

```output
Before [A B C D E]
After [A B E D]
```

Notice that to remove an element from a slice, the above code replaces the element you want to remove with the slice's latest one. Then, it creates a new slice that doesn't include the last element.

Another approach could be to create a new copy of the slice, but we haven't covered how to make copies of a slice, so let's get into it.

## Creating copies of slices

Go has a built-in `copy(dst, src []Type)` function to create copies of a slice. You send the destination slice and the source slice. For instance, you could create a copy of a slice like this:

```go
slice2 := make([]string, 3)
copy(slice2, letters[1:4])
```

Why would you care about creating copies? Well, when you change an element from a slice, you're changing the underlying array too. Therefore, any other slices that refer to the same underlying array will get affected. Let's see this in code, and then we'll fix it by creating a copy of a slice.

Use the following code to confirm that a slice points to an array, and every change you make in a slice affects the underlying array.

```go
package main

import "fmt"

func main() {
    letters := []string{"A", "B", "C", "D", "E"}
    fmt.Println("Before", letters)

    slice1 := letters[0:2]
    slice2 := letters[1:4]

    slice1[1] = "Z"

    fmt.Println("After", letters)
    fmt.Println("Slice2", slice2)
}
```

When you run the above code, you see the following output:

```output
Before [A B C D E]
After [A Z C D E]
Slice2 [Z C D]
```

Notice how the change we did on `slice1` affected the `letters` array and `slice2`. You can see in the output that the letter B has been replaced by Z, and it affects everyone who's pointing to the `letters` array.

To fix the above problem, you need to create a slice copy, which under the hood makes a new underlying array. You could use the following code:

```go
package main

import "fmt"

func main() {
    letters := []string{"A", "B", "C", "D", "E"}
    fmt.Println("Before", letters)

    slice1 := letters[0:2]

    slice2 := make([]string, 3)
    copy(slice2, letters[1:4])

    slice1[1] = "Z"

    fmt.Println("After", letters)
    fmt.Println("Slice2", slice2)
}
```

When you run the above code, you see the following output:

```output
Before [A B C D E]
After [A Z C D E]
Slice2 [B C D]
```

Notice now how the change in `slice1` did affect the underlying array, but it didn't affect the new `slice2`.
