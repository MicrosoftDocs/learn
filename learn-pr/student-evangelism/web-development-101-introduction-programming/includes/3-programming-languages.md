The principal purpose of programming languages is for developers to build instructions to send to a device. 

Programming languages are a vehicle for communication between humans and computers. Devices can understand only the binary characters 1 and 0. For most developers, using only binary characters isn't an efficient way to communicate. 

Programming languages come in a variety of formats and can serve different purposes. For example, JavaScript is used primarily for web applications, and Bash is used primarily for operating systems.

## Low-level and high-level languages

To be interpreted by a device, low-level languages typically require fewer steps than do high-level languages. However, what makes high-level languages popular is their readability and support. JavaScript is considered a high-level language.

The code in the next section illustrates the difference between a high-level language, such as JavaScript, and a low-level assembly language.

### Code comparison

The following code is written in JavaScript, a high-level language. It implements an algorithm by using constructs such as variables, for-loops, and other statements.

```javascript
let number = 10
let n1 = 0, n2 = 1, nextTerm;

for (let i = 1; i <= number; i++) {
    console.log(n1);
    nextTerm = n1 + n2;
    n1 = n2;
    n2 = nextTerm;
}
```

The preceding code illustrates an algorithm for implementing a Fibonacci sequence. Now, here's the corresponding code in the assembly language:

```armasm
area ascen,code,readonly
 entry
 code32
 adr r0,thumb+1
 bx r0
 code16
thumb
 mov r0,#00
 sub r0,r0,#01
 mov r1,#01
 mov r4,#10
 ldr r2,=0x40000000
back add r0,r1
 str r0,[r2]
 add r2,#04
 mov r3,r0
 mov r0,r1
 mov r1,r3
 sub r4,#01
 cmp r4,#00
 bne back
 end
```

Believe it or not, both examples are intended to do the same thing. Which one was easier to understand?

> [!NOTE]
> A Fibonacci sequence is defined as a set of numbers such that each number is the sum of the two preceding numbers, starting from 0 and 1.
