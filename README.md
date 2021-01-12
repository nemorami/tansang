# tansang Documentation

## Introduction

tansang is 

## Table of Contents




## Hello World

```tansang
type Main
fn init() {
    Console.puts('hello world')
}
```

Save this snippet into a file named `main.tan`. Now do: `tansang run main.tan`.


## Comments

```tansang
# This is a single line comment.

```

## Functions

```tansang
type Main
fn init() {
    let a! = [1, 2, 3, 4, 5]
    Console.puts(add(77, 33))
    Console.puts(sub(100, 50))
    Console.puts(sum(a!))
}

fn add(x Int, y Int) Int {
    return x + y
}

fn sub(x Int, y Int) Int {
    return x - y
}

fn sum(a! Array<Int>) Array<Int>{
    let total! Int = 0
    total! = a.each {
        total! += e # total! = total + e

    }
    a.append!(s)
    return a
}

fn addOne(a! Int) Int {
    a! = a + 1
}



All Function arguments passed by immutable reference.

```
### Returning multiple values

```tansang
type Main
fn init() {
    let a Int, b Int, c Int
    a, b = foo()
    println(a) # 2
    println(b) # 3
    c, _ = foo() # ignore values using `_`

}

fn foo() (Int, Int) {
    return (2, 3)
}

```

### Variable number of arguments

```tansang
type Main
fn sum(a Tuple<Int>) Int {
    let total = 0
    a.each {
        total += e # e is each item in a
    }
    return total # redundancy
}

println(sum(1))   //         1
println(sum(2,3)) //         5
```

## Symbol visibility

```tansang
type Main
getter a
setter b
property c
let a Int, b Int, c Int 
pub fn public_function() {
}

fn private_function() {
}
```
Instance variable is private by default.
To allow access in other type, use getter, setter, property.
Functions are private (not exported) by default.
To allow other type to use them, prepend `pub`. 

## Variables

```
let name = "Bob",  age = 20
let name String = "Bob", age Int = 20
```
Variable is always reference.

### Mutable variables

```
let age1! = 20, age2! Int
println(age1)
age2! = age1
Console.puts(age2) 
Console.puts(age1) # error age1 is void after assign to another variable.
```

## Types

### Basic type

In tansang everyting is an object and object is types.

tansang provides several literals for creating values of some basic types.

| Literal                                                     | Sample values                                           |
|---                                                          |---                                                      |
| [Nil]                                  | `nil`                                                   |
| [Bool]                                | `true`, `false`                                         |
| [Int]                             | `18`, `-12`, `19_i64`, `14_u32`,`64_u8`                 |
| [Float]                            | `1.0`, `1.0_f32`, `1e10`, `-0.5`                        |
| [Char]                                | `'a'`, `'\n'`, `'あ'`                                   |
| [String]                            | `"foo\tbar"`, `%("あ")`, `%q(foo #{foo})`               |
| [Array]                              | `[1, 2, 3]`, `[1, 2, 3] of Int32`, `%w(one two three)`  |
| [Pair]                               | ` "foo" : 2, 
| [Hash]                                | `("foo" : 2)`, `Tuple<Pair<String, Int>>`                 |
| [Range]                              | `1..9`, `1...10`, `0..var`                              |
| [Regex]                             | `/(foo)?bar/`, `/foo #{foo}/imx`, `%r(foo/)`            |
| [NamedTuple]                   | `{name: "Crystal", year: 2011}`, `{"this is a key": 1}` |
| [Proc]                                | `->(x  Int, y  Int) { x + y }`                    |
| [Command]                          | `` `echo foo` ``, `%x(echo foo)`                        |


### Strings

```
String name = "Bob"
puts(name.len)
puts(name[0]) // indexing gives a char B, name.charAt(0)
puts(name[1..3]) // slicing gives a string 'ob' name.slice(1, 3)

```


```
let s = "hello"
s[0] = 'H' # not allowed
```
> error: cannot assign to `s[i]` since s is immutable.
To mutate String object you can use mutate notation.
```
let s! = "hello"
s.setAt!(0, 'i') # s[0]! = 'i' 
Console.puts(s) # "iello"
```

### String interpolation

Basic interpolation syntax is pretty simple - use `${expression}`.
The variable will be converted to a string and embedded into the literal:
```
let age = 20
Console.puts("My age is ${age + 5}!") # My age is 25!
```

Format specifiers similar to those in C's `printf()` are also supported.
`f`, `g`, `x`, etc. are optional and specify the output format.
The compiler takes care of the storage size, so there is no `hd` or `llu`.

```
let x = 123.4567
Console.puts("x = ${x:4.2f}")
Console.puts('[${x:10}]')       // pad with spaces on the left
Console.puts('[${x.toInt():-10}]') // pad with spaces on the right
```

### String operators

```
let name = "Bob"
let bobby = name + "by" # + is used to concatenate strings
Console.puts(bobby) # "Bobby"

let s! = "hello "
s! += "world" # `+=` is used to append to a string, s! = s + "world", s.append!("world")
Console.puts(s) // "hello world"
let t! = "hello "
let y! = "world"
t.append(y) # error
t.append!(y)
```


### Numbers

```
let a = 123 # let a = Int(123)
```
varible a references the value of 123. By default `a` will have the type `Int`.
because a is immutable, you can't mutate a.
```
let a = 123
a += 1 # error
let b! = 125
b! = b + 1 # b.add!(1)

Assigning floating point numbers works the same way:

```
let f = 1.0
let f1 = Float(3.14)
```
### Number operators



### Arrays

```
let nums = [1, 2, 3]
println(nums) # "[1, 2, 3]"
println(nums[1]) # "2"
nums[1] = 5 # error
#### for mutate
```
let nums! = [1, 2, 3]
nums[1]! = 5 # nums.setAt!(1, 5)
nums.append!(5)
nums.append!("str") # error, nums is Array<Int>
```

#### Declare an empty array:
```
let users = []Int # Array<Int>
users = [1, 2, 3] # OK
users = [4, 5, 6] # error
let users = []Int|String # Array<Int|String>
users = [30, "Bob"]
```

#### Array operations

```
let nums! = [1, 2, 3]
nums! << 4
println(nums) // "[1, 2, 3, 4]"

let names! = ["John"]
names! << "Peter"
names! << "Sam"
# names << 10  <-- This will not compile. `names` is an array of strings.
Console.puts(names.len) // "3"
Console.puts("Alex" in names) # "false"
names.each {
    Console.puts(e)
}
```

`<<` is an operator that appends a value to the end of the array.
It can also append an entire array.

`val in array` returns true if the array contains `val`.

#### Array methods

Arrays can be efficiently filtered and mapped with the `.filter()` and
`.map()` methods:

```
let nums = [1, 2, 3, 4, 5, 6]
let even = nums.filter{e % 2 == 0}
Console.puts(even) // [2, 4, 6]

let words = ["hello", "world"]
let upper = words.map{e.toUpper()}
Console.puts(upper) # ["HELLO", "WORLD"]
```

`e` is a builtin variable which refers to element currently being processed in filter/map methods.

#### Multidimensional Arrays

Arrays can have more than one dimension.

2d array example:
```
let a = [][]Int # Array<Array<Int>>
a = [[0,0,0],[1,1,1]]
```


### Hash

```
let h = ["one":1, "two":2] # Hash<String, Int>("one":1, "two":2)
Console.puts(h["one"]) # 1
let m! = Hash<String,Int>  #
m["one"]! = 1 # m.insert("one", 1)
m["two"]! = 2
Console.puts(m["one"]) #
m.delete!("two")
```

## imports


### Selective imports


### Module import aliasing


## Statements & expressions

### If

```
let a = 10
let b = 20
if (a < b) {
    println('$a < $b')
} elif (a > b) { 
    println('$a > $b')
}
else {
    println('$a == $b')
}
```

`if` can be used as an expression:

```
let num = 500
let s = if (num % 2 == 0) {
    "even"
else 
    "odd"
}
Console.puts(s) # "even"
```

### In operator

`in` allows to check whether an array or a map contains an element.

```
let nums = [1, 2, 3]
println(1 in nums) # true

let m = ["one": 1, "two": 2]
println("one" in m) # true
```

### For loop

tansang has only one looping keyword: `for`.
```
for(true) {
    do
}
```

### when

```
let os = "windows"
Console.print("tansang is running on ")
when(os) {
    "mac": print("macOS"),
    "linux":{print("linux"), print("OS")},     
    else: print("OtherOS")
}
```

A when statement is a shorter way to write a sequence of `if - else` statements.
finding matching branch, the following statement block will be run.
The else branch will be run when no other branches match.

```
A when expression returns the final expression from each branch.
let number = 2
let s = when(number) {
    1:"one",
    2:"two", 
    else:"many"
}
Consloe.puts(s) # "two"
```

```
enum Color {
    red,
    blue,
    green,
}

fn is_red_or_blue(c Color) bool {
    return when c {
        .red, .blue :   true, # comma can be used to test multiple values
        .green : false 
    }
}
```

A when statement can also be used to branch on the variants of an `enum`
by using the shorthand `.variant_here` syntax. An `else` branch is not allowed
when all the branches are exhaustive.

```
let c = 'T'
let typ = when(c) {
    '0'..'9' :  "digit",
    'A'..'Z' : "uppercase",
    'a'..'z' : "lowercase",
    else      : "other"
}
println(typ) # 'lowercase'
```

You can also use ranges as `match` patterns. If the value falls within the range
of a branch, that branch will be executed.


## Generics

```
type Main

fn init() {
    Console.puts(sum(5 + 1))
    Console.puts(sum(3.14 + 3.2))
}

fn sum(a T1, b T1) T1 {
    return a + b
}
