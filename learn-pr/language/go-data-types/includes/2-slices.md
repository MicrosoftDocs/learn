We explored arrays in the previous section and learned that arrays are the foundation for slices and maps. You'll understand why in a moment. Like arrays, a slice is a data type in Go that represents a sequence of elements of the same type. But the more significant difference with arrays is that the size of a slice is dynamic, not fixed.

A slice is a data structure on top of an array or another slice. We refer to the originating array or slice as the *underlying array*. With a slice, you can access the whole underlying array or only a subsequence of elements.

A slice has only three components:

- **Pointer to the first reachable element of the underlying array**. This element isn't necessarily the array's first element, `array[0]`.
- **Length of the slice**. The number of elements in the slice.
- **Capacity of the slice**. The number of elements between the start of the slice and the end of the underlying array.

The following image represents what a slice is:

:::image type="content" source="../media/go-slices.png" alt-text="Diagram showing how slices look in Go." border="false":::

Notice how the slice is only a subset of the underlying array. Let's see how you can represent the preceding image in code.

## Declare and initialize a slice

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

Notice how, at the moment, a slice doesn't differ too much from an array. You declare them in the same way. To get the information from a slice, you can use the built-in functions `len()` and `cap()`. We'll continue using these functions to confirm that a slice can have a subsequence of elements from an underlying array.


## Slice items

Go has support for the slice operator `s[i:p]`, where:

- `s` represents the array.
- `i` represents the pointer to the first element of the underlying array (or another slice) to add to the new slice. The variable `i` corresponds to the element at index location `i` in the array, `array[i]`. Remember this element isn't necessarily the underlying array's first element, `array[0]`. 
- `p` represents the number of elements in the underlying array to use when creating the new slice, and also the element position. The variable `p` corresponds to the last element in the underlying array that can be used in the new slice. The element at position `p` in the underlying array is found at the location `array[i+1]`. Notice that this element isn't necessarily the underlying array's last element, `array[len(array)-1]`.

Therefore, a slice could refer to only a subset of elements.

Let's say that you want four variables to represent each quarter of the year, and you have a slice of `months` with 12 elements. The following image illustrates how to slice `months` into four new `quarter` slices:

:::image type="content" source="../media/go-slices-multiple.png" alt-text="Diagram showing how multiple slices look in Go." border="false":::

To represent in code what you saw in the preceding image, you could use the following code:

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

Notice how the length of the slices is the same, but the capacity is different. Let's explore the `quarter2` slice. When you declare this slice, you're saying you want the slice to start at position number three, and the last element is located at position number six. The slice's length is three elements, but the capacity is nine because the underlying array has more elements or positions available but not visible to the slice. For instance, if you try to print something like `fmt.Println(quarter2[3])`, you'll get the following error: `panic: runtime error: index out of range [3] with length 3`.

The capacity of a slice only tells you how much you can extend a slice. For this reason, you could create an extended slice from `quarter2`, like this example:

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

When you run the preceding code, you get the following output:

```output
[April May June] 3 9
[April May June July] 4 9
```

Notice that when you declare the `quarter2Extended` variable, you don't have to specify the initial position (`[:4]`). When you do that, Go assumes that you want the first position of the slice. You can do the same for the last position (`[1:]`). Go will assume that you want to reference all the elements up to the last position of a slice (`len()-1`).

## Append items

We've explored how slices work and how they're similar to arrays. Now let's discover how they differ from arrays. The first difference is that the size of a slice isn't fixed, it's dynamic. After you've created a slice, you can add more elements to it, and the slice will be extended. You'll see in a moment what happens to the underlying array.

To add an element to a slice, Go offers the `append(slice, element)` built-in function. You pass the slice to modify and the element to append as values to the function. The `append` function then returns a new slice that you store in a variable. It could be the same variable for the slice you're changing.

Let's see how the append process looks in code:

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

When you run the preceding code, you should see the following output:

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

This output is interesting. Especially for what the call to the `cap()` function is returning. Everything looks normal until the third iteration, where the capacity changes to 4, and there are only three elements in the slice. In the fifth iteration, the capacity varies again to 8 and in the ninth one to 16.

Do you notice a pattern from the capacity output? *When a slice doesn't have enough capacity to hold more elements, Go doubles its capacity*. It creates a new underlying array with the new capacity. You don't have to do anything for this increase in capacity to happen. Go does it automatically. You do need to be cautious. At some point, a slice might have way more capacity than it needs, and you'll be wasting memory.

## Remove items

You might be wondering, what about removing elements? Well, Go doesn't have a built-in function to remove elements from a slice. You can use the slice operator `s[i:p]` we covered before to create a new slice with only the elements you need.

For instance, the following code removes an element from a slice:

```go
package main

import "fmt"

func main() {
    letters := []string{"A", "B", "C", "D", "E"}
    remove := 2

	if remove < len(letters) {

		fmt.Println("Before", letters, "Remove ", letters[remove])

		letters = append(letters[:remove], letters[remove+1:]...)

		fmt.Println("After", letters)
	}

}
```

When you run the preceding code, you get the following output:

```output
Before [A B C D E] Remove  C
After [A B D E]
```

This code removes an element from a slice. It replaces the element to be removed with the next element in the slice, or none if you're removing the last element.

Another approach is to create a new copy of the slice. We'll learn how to make copies of slices in the next section.

## Create copies of slices

Go has a built-in `copy(dst, src []Type)` function to create copies of a slice. You send the destination slice and the source slice. For instance, you could create a copy of a slice like this example shows:

```go
slice2 := make([]string, 3)
copy(slice2, letters[1:4])
```

Why would you care about creating copies? Well, when you change an element from a slice, you're changing the underlying array too. Any other slices that refer to the same underlying array will be affected. Let's see this process in code, and then we'll fix it by creating a copy of a slice.

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

When you run the preceding code, you see the following output:

```output
Before [A B C D E]
After [A Z C D E]
Slice2 [Z C D]
```

Notice how the change we did on `slice1` affected the `letters` array and `slice2`. You can see in the output that the letter B has been replaced by Z, and it affects everyone who's pointing to the `letters` array.

To fix this problem, you need to create a slice copy, which under the hood makes a new underlying array. You could use the following code:

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

When you run the preceding code, you see the following output:

```output
Before [A B C D E]
After [A Z C D E]
Slice2 [B C D]
```

Notice how the change in `slice1` affected the underlying array, but it didn't affect the new `slice2`.
