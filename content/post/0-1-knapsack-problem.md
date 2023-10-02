+++
title = "0-1 Knapsack Problem"
lastmod = 2023-10-01T23:17:32-06:00
draft = false
author = "Jeffery@slc"
tags = ["Knapsack Problem", "leetcode"]
categories = ["Tech/技术"]
+++


## Introduction to the 0-1 Knapsack Problem {#introduction-to-the-0-1-knapsack-problem}

The 0-1 Knapsack problem is a classic optimization problem. Imagine you have a bag with a certain weight capacity, and you have a set of items, each with its own weight and value.
The problem is to determine which items to include in the bag to maximize its total value without exceeding its weight capacity.


## Brute Force {#brute-force}

The simplest way to tackle the 0-1 Knapsack problem is using a brute-force method. Here, we evaluate every possible combination of items:

For each item, we can either choose to include it in the bag or leave it out, leading to two choices for each item.
This decision-making can be visualized as a binary tree structure, where each node represents a choice, and each level of the tree corresponds to an item.
Given n items, the total number of combinations is 2^n, leading to a time complexity of O(2^n).

```java
 class Solution_bruteforce {
    int maxValue = 0;
    int[] weights;
    int[] values;
    int bagCapacity;

     public void bruteforce(int[] weights, int[] values, int bagCapacity) {
      this.weights = weights;
      this.values = values;
      this.bagCapacity = bagCapacity;
      dfs(0, 0, 0);
      System.out.println(maxValue);
    }

    private void dfs(int n, int curValue, int curWeight) {
      //base case
      if(curWeight > bagCapacity) return;

      if(n == weights.length) {
          maxValue = Math.max(maxValue, curValue);
          return;
      }

      maxValue = Math.max(maxValue, curValue);

      // choose the Nth item
      dfs(n + 1,  curValue + values[n], curWeight + weights[n]);
      // not choose the nth item
      dfs(n + 1, curValue , curWeight);
    }
}
```


## Dynamic Programming with 2D dp array {#dynamic-programming-with-2d-dp-array}

Dynamic Programming (DP) offers a more efficient way to solve the problem. Instead of recalculating results, we store them in a table (usually a 2D array) and refer back to them when needed:

dp[i][j] denotes the maximum value that can be obtained using the first i items, considering a bag capacity of j.
To populate this table, we use previously computed values, building up the solution incrementally.
This method reduces the time complexity to O(m\*n), where m is the number of items and n is the bag's capacity.

```java
class Solution_dp {
    public void dp(int[] weights, int[] values, int bagCapacity) {
      int[][] dp = new int[weights.length][bagCapacity + 1]; // means max value can be stored in bagCapacity

      // init first column
      for (int i = 0; i < weights.length; i++) {
          dp[i][0] = 0;
      }

      // init first row
      for (int j = 1; j <= bagCapacity; j++) {
          dp[0][j] = (j >= weights[0]) ? values[0] : 0;
      }

      for (int i = 1; i < weights.length; i++) {
          for (int j = 1; j <= bagCapacity; j++) {
              dp[i][j] = Math.max(dp[i - 1][j],
                      (j >= weights[i]) ? dp[i - 1][j - weights[i]] + values[i] : dp[i - 1][j]);
          }
      }

      // print the dp array
      for (int i = 0; i < weights.length; i++) {
          for (int j = 0; j <= bagCapacity; j++) {
              System.out.print(dp[i][j] + " ");
          }
          System.out.println();
      }
    }
}
```


## Dynamic Programming with 1D dp array {#dynamic-programming-with-1d-dp-array}

Observing the 2D DP solution, a pattern emerges. The value in a cell only depends on values from the previous row( dp[i][j] = max( dp[i -1][j], dp[i - 1][j - weights[i]] + values[i]))) :

This observation allows us to compress the 2D table into a 1D array, further reducing space complexity.
The idea is to process the items one by one, and for each item, iterate through the array in reverse (must do it in reverse order of weight, for not overwriting the previous state)), updating its values.

```java
class Solution_dp_compress {
     public void dp_compress(int[] weights, int[] values, int bagCapacity){
         int[] dp = new int[bagCapacity + 1];
         int n = weights.length;
         // init dp
         for(int i = 0; i < n; i++) {
             dp[i] = 0;
         }

         for(int i = 0; i < n; i++) {
             for(int j = bagCapacity; j >=0; j--) {
                 dp[j] = Math.max(dp[j], (j - weights[i] >=0)? dp[j - weights[i]] + values[i]:0);
             }
         }
         System.out.println(dp[dp.length - 1]);
     }
 }
```


## Test Results {#test-results}

```java
public static void main(String[] args) {
      // three objects: 0, 1, 2
      int[] weights = { 1, 3, 4 };
      int[] values = { 15, 20, 30 };
      int bagCapacity = 4;

     Solution_bruteforce s2 = new Solution_bruteforce();
     s2.bruteforce(weights, values, bagCapacity);
     // result: 35


     Solution_dp s = new Solution_dp();
     s.dp(weights, values, bagCapacity);
     // print out:
     /*
       0 15 15 15 15
       0 15 15 20 35
       0 15 15 20 35
     */

     Solution_dp_compress s3 = new Solution_dp_compress();
     s3.dp_compress(weights, values, bagCapacity);
     // result: 35
}
```


## Leetcode 474. Ones and Zeroes {#leetcode-474-dot-ones-and-zeroes}

```text
You are given an array of binary strings strs and two integers m and n.
Return the size of the largest subset of strs such that there are at most m 0's and n 1's in the subset.
A set x is a subset of a set y if all elements of x are also elements of y.

Example 1:
Input: strs = ["10","0001","111001","1","0"], m = 5, n = 3
Output: 4
Explanation: The largest subset with at most 5 0's and 3 1's is {"10", "0001", "1", "0"}, so the answer is 4.
Other valid but smaller subsets include {"0001", "1"} and {"10", "1", "0"}.
{"111001"} is an invalid subset because it contains 4 1's, greater than the maximum of 3.
```

The problem of selecting binary strings with a constraint on the number of zeros and ones is a twist on the 0-1 Knapsack problem:

Instead of a single weight capacity, we now have two: m for the number of zeros and n for the number of ones.
The 2D DP array dp[i][j] now represents the maximum number of strings that can be formed with i zeros and j ones..

```java
  class Solution {
    public int findMaxForm(String[] strs, int m, int n) {
        int[][] dp = new int[m + 1][n + 1];
        for(int i = 0; i < strs.length; i++) {
            int[] nums = getZerosNOnes(strs[i]);
            for(int j = m; j >=0; j--) {
                for(int k = n; k>=0; k--) {
                    int thisState = (j - nums[0] >= 0 && k - nums[1] >= 0)? dp[j - nums[0]][k - nums[1]] + 1 : 0; // if i is chosen, the size is incremented by one
                    dp[j][k] = Math.max(dp[j][k], thisState); // dynamic formula
                }
            }
        }

        return dp[m][n];
    }

    private int[] getZerosNOnes(String str) {
        int zeros = 0, ones = 0;
        for(char c : str.toCharArray()) {
            if(c == '0') {
                zeros++;
            }else{
                ones++;
            }
        }
        return new int[]{zeros, ones};
    }
}
```
