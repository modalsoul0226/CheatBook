<h2 align="right">Xinze Zhao</h2>
<h6 align="right">
    +1-(647)-913-9156</br>
    <a>xinze.zhao@mail.utoronto.ca</a></br>
    <a href="https://github.com/modalsoul0226">github.com/modalsoul0226</a>
</h6>

# Ext2 File System
In this project, I explored the implementation of a particular file system, ext2, and wrote tools to modify ext2-format virtual disks. These tools include `ext2_cp`, `ext2_ln`, `ext2_rm`, `ext2_mkdir` and so on, they basically have the same functionalities as the native Unix/Linux `cp`, `ln`, `rm` and `mkdir` commands.


---
## PART 1

During the process, I've encountered a lot of problems, and the followings are probably the most interesting and challanging ones.

In order to implement these programs, I first need to understand and grasp the basic structure of an Ext2 file system. However, I started this project from scratch and knew only a little about how a file system is typically implemented. So, I read and learned from a lot of documents and related materials from online sources, and checked whether my understanding is correct by accessing and printing various fields/components of a given disk image.  This process really gave me a chance to **practise and hone my ability of learning a subject in a very short period of time.**

The most difficult part of this project is the surprisingly **complex logic** behind each of these common actions like `cp` or `rm` because I need to implement these features from scratch. The manipulations of metadata is also quite sophisticated and need extra carefulness. After careful and thorough analysis of the logic and steps behind, I found that it is very useful for these programs to share code. For example, I need a function that performs a path walk, or a function that opens a specific directory entry and writes to it. So, I grouped these helper functions into separate standalone files which made them **reusable** and made the whole program much more **modular** and **elegant**. These programs only need to call the helpers without worrying about other technical details, and also reduced each program’s size to have only around 100 lines. **This also reinforced my understanding of encapsulation or layering**, because one of the advantages of making the programs more modular is that we can call those helpers without worrying about the technical details behind them, therefore makes them much more **readable** and **concise**. Additionally, it's also **beneficial for performing unit testings**. You started by performing tests on basic helper functions, and then build other functions on these helpers and so on. This kind of approach really **increases the robustness and correctness of my programs**.

It was also difficult to support recursive operations, because now we need to keep track of multiple inodes at the same time, which means we need to traverse inode table much more frequently, the performance of searching is also required. Since the inode table is tree structured, I decided to implement searching using **backtracking**
 in order to reduce the time complexity. 

---
## PART 2

The program in the attachment is `ext2_cp.c`. This program takes in an ext2 formatted virtual disk, the path to a source file and a destination path on that disk. The following is a sample usage:
```shell
./ext2_cp disk_name.img src dest
```

And this program basically work the same as native command ‘cp’, copying the file onto a specified location on the disk. If the specified file or target location does not exist, then it will raise a proper error.

The basic idea behind the implementation is to write the content of a source file to a designated destination. But we need to do a lot of work before actually copying the content, we need to deal with metadata of the file system i.e. the bitmaps and inode table. In order to create a new file on the disk, corresponding bits in the bitmap need to be set, extra inodes need to be added into the inode table. After that, the content can finally be written to the data blocks of the disk. 

---
## PART 3
The details and demonstration of this project can be found at this link:

https://github.com/modalsoul0226/Ext2-fs-demo
