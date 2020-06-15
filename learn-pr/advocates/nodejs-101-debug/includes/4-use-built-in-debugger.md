To put in practice the debugging concepts you just saw, you will create a short Node.js program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers starting with the number 0 and 1, with every other following numbers being the sum of the two previous ones, going on like that:

```
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

Let's create a new Node.js program to illustrate that.
In the terminal on the right, type:

```sh
code fibonacci.js
```

Then paste this code in the editor:

```js
function fibonacci(n) {
  let n1 = 0;
  let n2 = 1;
  let sum = 0;

  for (let i = 2; i < n; i++) {
    sum = n1 + n2;
    n1 = n2;
    n2 = sum;
  }

  return n === 0 ? n1 : n2;
}

const result = fibonacci(5);
console.log(result);
```

Save the file, then run the program using the terminal:

```sh
node fibonacci.js
```

The program should display the result `3` in the console. Oops, it seems there is a bug in there, as we expected `5`. Let's understand what's going wrong using the Node.js built-in debugger.

Start again the program, this time with the built-in debugger enabled:

```sh
node inspect fibonacci.js
```
