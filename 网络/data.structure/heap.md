# Heap & priority queue

- [Heap & priority queue](#heap--priority-queue)
  - [Heap](#heap)
    - [Max heap properties](#max-heap-properties)
    - [Operations](#operations)
  - [Priority Queue](#priority-queue)
  - [LeetCode](#leetcode)

## Heap

The (binary) heap data structure is an array object $(b)$ that we can view as a nearly complete binary tree $(a)$. Each node of the tree corresponds to an element of the array.

<div align='center'>
    <img width=600 src='assets/heap.png'>
</div>

The tree is completely filled on all levels except possibly the lowest, which is filled from the left up to a point.

### Max heap properties
- For every node $i$ other than the root, $A[Parent(i)] \geq A[i]$.
- Height is $\lfloor logn \rfloor$.
- At a given height $h$, there are at most $\lceil n/2^{h+1} \rceil$
- Has $\lceil n/2 \rceil$ leaves.

### Operations
- **Bubble up & Bubble down** (`MAX_HEAPIFY`) - $O(logn)$: keep comparing with parent or children, and swap two nodes if necessary util the max heap property is restored. This will be at most the height of the tree.
- **MAX** - $O(1)$: return the root value.
- **INSERT** - $O(logn)$: place the node at the end, and bubbles up.
- **EXTRACT_MAX** - $O(logn)$: replace the root with the last element, and bubbles down.
- **BUILD_HEAP** - $O(n)$: for node $i$ from $\lfloor n/2 \rfloor$ to $1$, perform `MAX_HEAPIFY` for each node.

---
## Priority Queue
Heapsort is an excellent algorithm, but a good implementation of quicksort usually beats it in practice. Nevertheless, the heap data structure itself has many uses, and one of the most popular applications of a heap is priority queue.

We can use max priority queue to schedule jobs on a shared computer, min priority queue to create event-driven simulator.

---
## LeetCode
- [Leetcode 题解](https://github.com/CyC2018/CS-Notes/blob/master/notes/Leetcode%20%E9%A2%98%E8%A7%A3%20-%20%E6%8E%92%E5%BA%8F.md#%E5%A0%86)
- [My solutions]()
