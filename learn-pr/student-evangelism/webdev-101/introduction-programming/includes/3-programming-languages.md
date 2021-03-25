Programming languages serve a main purpose: for developers to build instructions to send to a device. Devices only can understand binary (1 s and 0s), and for most developers that's not an efficient way to communicate. Programming languages are a vehicle for communication between humans and computers.

Programming languages come in different formats and may serve different purposes. For example, JavaScript is primarily used for web applications, while Bash is primarily used for operating systems.

Low-level languages typically require fewer steps than high-level languages for a device to interpret instructions. However, what makes high-level languages popular is its readability and support. JavaScript is considered a high-level language.

The following code illustrates the difference between a high-level language with JavaScript and low-level language with ARM assembly code.

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

Believe it or not, they're both doing the same thing: printing a Fibonacci sequence up to 10.

> [!TIP]
> A Fibonacci sequence is defined as a set of numbers such that each number is the sum of the two preceding ones, starting from 0 and 1.

