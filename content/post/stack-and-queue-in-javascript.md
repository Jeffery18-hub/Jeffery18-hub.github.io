+++  
title = "Implementing Stack and Queue in JavaScript"  
lastmod = 2024-04-25T23:24:17-06:00  
draft = false  
author = "Jeffery@slc"  
tags = ["javascript", "data structure", "stack", "queue", "priority queue", "leetcode"]  
categories = ["Tech/技术"]  
+++

In JavaScript, both stack and queue data structures are commonly implemented using arrays.  
Here’s a brief conclusion on how to implement these structures, excluding priority queues which are slightly more complex and typically use third-party libraries.

## Stack {#stack}

Stacks follow the LIFO principle. Using JavaScript arrays, we can mimic this behavior easily.

1. create a stack

```javascript
const stack = [];
```

1. push to the top of stack

```javascript
stack.push(0);
stack.push(1);
stack.push(2);

// top side: 2 1 0
```

1. pop from the top of stack

```javascript
const poped = stack.pop(); // here the poped value is 2.
```

## Queue {#queue}

1. create a queue

```javascript
const queue = [];
```

1. add to the end of a queue

```javascript
queue.push(0, 1, 2); // [0, 1, 2] ->
```

1. pop from the front of a queue

```javascript
const poped = queue.shift()
```

## Priority Queue {#priority-queue}

Priority queue is a bit tricky and if you are working on leetcode questions, you can use some third-party module, like  
5.4.0 version of datastructures-js/priority-queue which is recommended officially. Note that datastructures-js/priority-queue now has  
new versions v6.

The Priority queue is implemented via data structure of heap, and heap is based on the array as well.

I found that using MinPriorityQueue and MaxPriorityQueue are handy. For more info about how to use them, please check the github reop link.[https://github.com/datastructures-js/priority-queue/tree/v5](https://github.com/datastructures-js/priority-queue/tree/v5)

1. import the module(not neccessary in leetcode)

```javascript
// type -> module (ES6)
  import {
  MinPriorityQueue,
  MaxPriorityQueue,
  PriorityQueue,
} from "@datastructures-js/priority-queue";
```

1. enqueue

If the object you added into the queue is just a number, the implementation will use the value of number as the priority. If not, you should explicitly set the priority.

```javascript
// numeric queue is pretty simple
numericMinPriorityqueue.enqueue(1)
numericMinPriorityqueue.enqueue(2)
numericMinPriorityqueue.enqueue(3)

// numericminpriorityqueue.front() == 1

carsMinPriorityqueue.enqueue(car1, car1.price); // if car1.price == 5000
carsMinPriorityqueue.enqueue(car2, car2.price); // if car2.price == 4000
carsMinPriorityqueue.enqueue(car1, car3.price); // if car3.price == 6000

// carsminpriorityqueue.front() == car2 // car2 has the cheapest price 4000
```

1. dequeue

`dequeue` will return the element with highest priority and pop it off from the queue,  
while `front` and `back` methods just peek the element with highest and lowest priority.

```javascript
const highestNumber = numericminpriorityqueue.dequeue() // 1
const highestCar = carsminpriorityqueue.dequeue() // car2
```

1. construct from a array

The array contains element-priority pairs(array of two elements)

```javascript
 const carsMinQueue = MinPriorityQueue.from([
  ["tesla", 90000],
  ["toyota", 50000],
  ["byd", 60000],
]);

console.log(carsMinQueue.front()); //  { priority: 50000, element: 'toyota' }
```

## Miscellaneous {#miscellaneous}

Array has another two methods which are super useful that need to be recorded in this post.

1. slice

```javascript
const array = [1,2,3,4];
const array_copy1 = array.slice(); // [1,2,3,4] without params, return the complete copy
const array_copy1 = array.slice(1, ); // [2,3,4] start position, end position is null
const array_copy1 = array.slice(1, 3); // [2,3] end index is not included
```

1. splice

```javascript
const array = [1,2,3,4,5]
array.splice(1,2); // remove 2 elements from index 1 inclusivly:  array == [1,4,5]
array.slice(1,1,6,7); // remove one element from index 1 and insert 6 and 7: array == [1,6,7,5]
array.slice(1,0,8); // dont remove and insert 8 at index 1:  array == [1,8,6,7,5]
```