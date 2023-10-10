+++
title = "Functions in Kotlin"
lastmod = 2023-10-10T12:25:04-06:00
draft = false
author = "Jeffery@slc"
tags = ["kotlin", "function"]
categories = ["Tech/技术"]
+++

In this post, I aim to summarize the essential aspects of function syntax in Kotlin. While this post touches upon some commonly used functionalities, especially in Android development,
it doesn't delve deep into the advanced usages.


## Regular Functions {#regular-functions}

Regular functions are the basic building blocks. Here's a simple function that compares the lengths of two strings:

```kotlin
fun compare(a: String, b: String): Boolean {
    return a.length < b.length
}
```

It's necessary to specify the types of parameters. However, the return type can often be inferred by the compiler.


### Default Arguments {#default-arguments}

Functions can have default values for their parameters. For instance:

```kotlin
fun compare(a: String = "hello", b: String = "hi"): Boolean {
    return a.length < b.length
}
```

This allows you to call the function as \`compare()\` or \`compare("hi", "hello")\`.


## Single-expression Functions {#single-expression-functions}

For functions comprising just a single expression, you can drop the curly braces and use the \`=\` symbol:

```kotlin
fun double(x: Int): Int = x * 2
```

Moreover, if the compiler can infer the return type, you can omit it:

```kotlin
fun double(x: Int) = x * 2
```


## Generic Functions {#generic-functions}

Generics enable functions to operate on different data types, ensuring code reusability and type safety.

```kotlin
fun <T> printMe(value: T) {
    println(value)
}

// You can call the function with any data type:
printMe("Hello")
printMe(25)
```


## Lambdas {#lambdas}

In Kotlin, functions are first-class, meaning they can be stored in variables, passed around, and returned from other functions.


### Defining Function Types {#defining-function-types}

Function types can be defined similar to other types:

```kotlin
val onClick: () -> Unit = { println("hello") }
```

Here, \`onClick\` is a variable of a function type. This function takes no arguments and returns \`Unit\` (similar to \`void\` in other languages).


### Lambda Expressions {#lambda-expressions}

Lambda expressions, or simply lambdas, represent small chunks of code. They can be used primarily to define inline functions. The syntax is concise:

```nil
val sum: (Int, Int) -> Int = { x, y -> x + y }
```

In this lambda:

-   The expression is enclosed in curly braces.
-   The parameter types can be omitted if they can be inferred.
-   The lambda body follows the \`-&gt;\` symbol.
-   If the return type isn't \`Unit\`, the last expression is taken as the return value.


### Trailing Lambdas {#trailing-lambdas}

A nifty Kotlin feature is the ability to move lambdas out of parentheses if they're the last argument in a function call:

```kotlin
fun foo(x: String, y: String, z: (a: String, b: String) -> Boolean) {
    println(z(x,y))
}
foo("hi", "hello") { a, b -> a.length < b.length }
```
