+++
title = "Leetcode 198.House Robber"
lastmod = 2023-11-22T22:52:45-07:00
draft = false
author = "Jeffery@slc"
tags = ["House Robber", "leetcode"]
categories = ["Tech/技术"]
+++

## Problem Description

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

 

Example 1:

Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
Example 2:

Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
Total amount you can rob = 2 + 9 + 1 = 12.
 

Here are two approaches to solving the classic "House Robber" problem: Recursion + Backtracking, and Iteration. Both methods apply dynamic programming effectively, albeit in different ways.


## Solution One (Recursion + Backtracking) {#solution-one--recursion-plus-backtracking}

This solution I found online (author: labuladong) uses recursion and backtracking. I am not sure if this counts as dynamic programming.


### Basic Idea {#basic-idea}

1.  Standing in front of the i-th house, the robber has two options: rob it and jump to the i + 2-th house to avoid being caught, or don’t rob it and move to the i + 1-th house.
2.  Recursive function definition: The parameters are the nums array and the starting index. The return value is the maximum value that can be obtained from the starting index. The recursion stops when the index is greater than or equal to the length of nums, meaning there are no more houses.
3.  Below, I drew a recursion tree based on the example -&gt; nums = [1,2,3,1]. The green arrows represent robbing, the red arrows represent not robbing, the blue arrows represent returning values to the upper layer of recursion, and the black dashed circles represent exceeding the maximum index of the house, meaning such a node doesn’t exist.
    For the top node with a value of 1, you can see that the left tree returns a value of 3, and the right side also returns 3. So, at this initial stage, if the robber chooses to rob, the maximum value is 4, and if not, the maximum value is 3.
    <div align="center">
    <img src="/images/houseRobber/tree1.png" style="width: 400px; height: 400px;">
    </div>
4.  The Python implementation is as follows:
    ```python
    class Solution:
       def __init__(self):
           self.memo = [] # memory list to avoid duplicate computing

       def rob(self, nums: List[int]) -> int:
           if len(nums) == 1:
          return nums[0]

           # initialize the memory list with values -1
           self.memo = [-1] * len(nums)

           return self.recursion(nums, 0)

       def recursion(self, nums, start):
           if start > len(nums) - 1:
          return 0

           if self.memo[start] != -1:
          return self.memo[start]

           res = max(self.recursion(nums, start + 2) + nums[start],
                self.recursion(nums, start + 1))

           self.memo[start] = res

           return res
    ```
5.  From the Python code, you can see that it uses pruning. The purple marks in the diagram below show two identical nodes, which are the houses with a value of 3. If no pruning is done, the maximum value will be recalculated, increasing the complexity. Therefore, the code includes a memo array to check whether a node has been computed before. If it has, it directly returns the value without continuing recursion.


<div align="center">
    <img src="/images/houseRobber/tree2.png" style="width: 400px; height: 400px;">
</div>


## Solution Two (Iteration) {#solution-two--iteration}

The solution I came up with myself seems more in line with the idea of dynamic programming (in my opinion). It is based on past states, establishes a state transition equation, and then deduces the current state, ultimately obtaining the maximum value through iteration.


### Basic Idea {#basic-idea}

1.  Standing at the current node, i.e., the i-th house, if the robber robs, then the adjacent left house cannot be robbed. The maximum value corresponding to the i-th house is based on the maximum value of the i - 2-th house; if not robbing, then the maximum value of the i-th house is based on the i - 1-th house.
2.  Initialize the dp array, where dp[0] = nums[0], dp[1] = max(nums[1], dp[0]).
3.  State transition equation: dp[i] = max(dp[i - 1], dp[i - 2] + nums[i]).
4.  The final maximum value obtained is dp[len(nums) - 1].

The code is as follows:

```python
class Solution:
  def rob(self, nums: List[int]) -> int:
      if len(nums) == 1:
          return nums[0]

      dp = [0] * len(nums)
      dp[0] = nums[0]
      dp[1] = max(dp[0], nums[1])
      for i in range(2, len(nums)):
          dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])

      return dp[-1]
```

I still prefer iteration because, firstly, the code is more concise, and secondly, it requires less space.

The English part of this blog is translated by chatGPT and below is the original Chinese version.

经典动态规划题目了，两种解决思路：


## 解法一（递归 + 回溯） {#解法一-递归-plus-回溯}

这是我网上看到的题解（作者：labuladong），是采用递归和回溯的思路，但我不是很确定这是不是算作动态规划。


### 基本思路 {#基本思路}

1.  强盗站在第i个house前，如果选择抢劫，为了避免被抓，就要跳到第i + 2个房间；不抢，则跳至第i + 1个房间。
2.  递归函数定义：参数一个是nums数组，一个是起始index， 返回值为基于起始index，能够获取的最大价值。 递归退出：在index大于等于nums的长度，返回0，也就是不存在对应的house了。
3.  下面我根据题目的例子[1,2,3,1], 手绘了递归树，其中绿色箭头表示rob，红色箭头表示不去rob，蓝色箭头表示向上一层递归返回值，黑色虚线圆圈表示超过了house最大index，不存在这样一个节点。

对于最顶层的值为1的节点，可以看到左树的返回值为3，右边同样为3，那么如果在这个起始阶段，robber选择抢劫的话，最大价值为4，不抢劫的话最大价值就为3。
   <div align="center">
    <img src="/images/houseRobber/tree1.png" style="width: 400px; height: 400px;">
   </div>

4.  python实现的代码如下
    ```python
     class Solution:
    def __init__(self):
        self.memo = [] # memory list to avoid duplicate computing

    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
       return nums[0]

        # init the memory list with values -1
        self.memo = [-1] * len(nums)

        return self.recursion(nums, 0)

    def recursion(self, nums, start):
        if start > len(nums) - 1:
       return 0

        if self.memo[start] != -1:
       return self.memo[start]

        res = max(self.recursion(nums, start + 2) + nums[start],
               self.recursion(nums, start + 1))

        self.memo[start] = res

        return res
    ```
5.  从python代码可以看到其使用了剪支操作，下图紫色标记出来两个相同的节点，也就是价值为3的房子，如果不做任何剪支的话就会重复计算最大值，增加了复杂度，所以代码中加入了memo数组，用于判断该节点之前是否被计算过，如果计算过就直接返回，不再继续递归。
   <div align="center">
    <img src="/images/houseRobber/tree2.png" style="width: 400px; height: 400px;">
   </div>


## 解法二（迭代） {#解法二-迭代}

我自己想出来的题解比较符合动态规划思想（自我感觉），基于过去的状态，建立状态转移方程，进而推导出当前状态，最终通过迭代方式取得最大价值。


### 基本思路 {#基本思路}

1.  站在当前节点，也就是说第i个house，robber如果抢劫，那么相邻左边的house就不能抢，第i个house对应的最大价值，是基于第i - 2的最大价值得来的；如果不抢劫，则第i个house对应的最大价值，是基于第i - 1个house得来的
2.  初始化dp数组，其中dp[0] = nums[0], dp[1] = max(nums[1], dp[0])
3.  状态转移方程： dp[i] = max(dp[i - 1], dp[i - 2]+ nums[i])
4.  最后求得的最大价值就是dp[len(nums) - 1]

代码如下：

```python
class Solution:
  def rob(self, nums: List[int]) -> int:
      if len(nums) == 1:
          return nums[0]

      dp = [0] * len(nums)
      dp[0] = nums[0]
      dp[1] = max(dp[0], nums[1])
      for i in range(2, len(nums)):
          dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])

      return dp[-1]
```

我还是比较喜欢迭代，一是代码更加简洁，二是空间开销更少。
