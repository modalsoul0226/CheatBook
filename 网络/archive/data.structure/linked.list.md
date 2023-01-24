# Linked List

- [Linked List](#linked-list)
  - [Singly Linked List](#singly-linked-list)
    - [Performance](#performance)
    - [Array vs. Linked List](#array-vs-linked-list)
  - [Doubly Linked List](#doubly-linked-list)
    - [Advantages over singly linked list](#advantages-over-singly-linked-list)
    - [Disadvantages over doubly linked list](#disadvantages-over-doubly-linked-list)
  - [Circular Linked List](#circular-linked-list)
    - [Advantages](#advantages)
  - [Leetcode](#leetcode)


---
## Singly Linked List
A linked list is a **linear data structure**, in which the elements are **not stored at contiguous memory locations**. The elements in a linked list are linked using pointers as shown in the below image:

<img width=600 src='assets/linkedlist.png'>

### Performance
- Access: O(n)
- Insertion (at the front): O(1)
- Deletion: O(n)

### Array vs. Linked List
1. Array is a collection of *similar type element*,  linked list is considered as non-primitive data structure contains *a collection of unordered linked elements* known as nodes.
2. **Array stores elements sequentially**. Therefore, array only takes O(1) time to access an element, but takes O(n) time to perform insertion or deletion. While **linked list has dynamic size** and takes O(1) to do insertion/deletion.
3. Array has better **cache locality**.

---
## Doubly Linked List
A Doubly Linked List (DLL) contains **an extra pointer**, typically called **previous pointer**, together with next pointer and data which are there in singly linked list:

<img width=800 src='assets/doublylinkedlist.png'>

### Advantages over singly linked list
- DLL can be traversed both ways.
- **Deletion is easier**.
- **Easier to insert** a new node before a specific node.

### Disadvantages over doubly linked list
- Extra space for `prev` pointer.
- Extra steps to maintain the `prev` pointer.

---
## Circular Linked List
Circular linked list is a linked list where all nodes are connected to form a **circle**. There is **no NULL at the end**. A circular linked list can be a singly circular linked list or doubly circular linked list.

<img width=650 src='assets/circularlinkedlist.png'>

### Advantages
- Any node can be a starting point.
- Useful for implementation of **queue**.
- Useful in applications to repeatedly go around the list e.g. os round-robin scheduling.
- Used for implementation of advanced data structures like [Fibonacci Heap](https://www.wikiwand.com/en/Fibonacci_heap#:~:text=In%20computer%20science%2C%20a%20Fibonacci,binary%20heap%20and%20binomial%20heap.).

---
## Leetcode
- [Leetcode 题解](https://github.com/CyC2018/CS-Notes/blob/master/notes/Leetcode%20%E9%A2%98%E8%A7%A3%20-%20%E9%93%BE%E8%A1%A8.md)
- [My solutions](https://github.com/modalsoul0226/LeetcodeRepo/tree/master/linked.list)
