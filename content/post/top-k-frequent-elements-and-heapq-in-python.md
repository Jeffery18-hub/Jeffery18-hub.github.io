+++
title = "Top K Frequent Elements and Heapq in Python"
lastmod = 2023-12-09T14:12:48-07:00
draft = false
author = "Jeffery@slc"
tags = ["leetcode", "python", "min-heap"]
categories = ["Tech/技术"]
+++

## Heapq in Python {#heapq-in-python}

This module provides an implementation of the heap queue algorithm, also known as the priority queue algorithm.

Heaps are binary trees for which every parent node has a value less than or equal to any of its children.
This implementation uses arrays for which heap[k] &lt;= heap[2\*k+1] and heap[k] &lt;= heap[2\*k+2] for all k, counting elements from zero.

For the sake of comparison, non-existing elements are considered to be infinite. The interesting property of a heap is that its smallest element is always the root, heap[0].


### Key Methods in Heapq {#key-methods-in-heapq}

1. initialzaiton
2. heappush
3. heappop

Let's delve into the code snippets.


```python
'''
1.  python stl only has min heap, which is called heapq.
2.  As we all know min +heap(tree structure) is a way to realize adt priority queue,
'''

'''two ways to initialize the heap'''

# method 1: init with an empty list
pq = [] # empty list
heappush(pq, 1)
heappush(pq, 2)
heappush(pq, 0)


# init with a list and then call the heapify method
pq2 = [3,6,1,9,0,2]
heapify(pq2)


'''init with a list of tuples, sorting the list according to the first value in tuple'''
pq3 = [(3,1), (1,2), (5,4), (0,9)]
heapify(pq3)

'''heap sort '''
def heap_sort(pq):
    return [heappop(pq) for i in range(len(pq2))]

sorted_pq = heap_sort(pq2)
```


## Top k elements in Leetcode {#top-k-elements-in-leetcode}

we can easily solve this problem in leetcode in less than nlogn time comlexity.


### solution {#solution}

```python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        map = {}

        # dictionary for num and counts
        for num in nums:
            map[num] = map.get(num, 0) + 1

        # creat priority queue
        pq = []

        # push key-value pair to pq
        for num, counts in map.items():
            heapq.heappush(pq, (counts, num)) # sort by val-> counts

            # remove the smallest count when size > k
            if len(pq) > k:
                heapq.heappop(pq)


        # get result
        res = []
        for i in pq: # i is tuple with (counts, num)
            res.append(i[1])

        return res
```


### analysis {#analysis}

1.  The totoal time complexity  is primarily determinded by the construction of a min heap.
2.  Time complexity  of inserting a node into min heap is the height of tree, so here heappush will cost O(logk)
3.  Outer loop will iterate k times and k &lt;= n. So the total time compelxity of this solution is O(klogk).
