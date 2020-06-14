### Vim cheat sheet

### *Navigation*

#### Basic Movement
```
    k
  h   l
    j
```

`h`: left; `j`: down; `k`: up; `l`: right;

---
#### Word movement
`w`(word): move to the **start** of the **next** word.
`b`(beginning): move to the **beginning** of the word.
`e`(end): move to the **end** of the word. 

Notice that a **number** can be prepended.

---
#### Line movement
`0`: go to start of line
`$`: go to end of line

---
#### Goto line
`gg`: go to the start of file
`G`: go to the end of file
`num + G`: go to the specified line `num`

---
#### Matching parantheses
`%`: go to matching parantheses 


### *Searching*

---
#### Find a character
`f`: find occurance of the next specified character

---
#### Find word under cursor
Find the next occurrence of the word under cursor with `*`, and the previous with `#`.

---
#### Search a word
`/` and enter the text you are looking for. Press `enter` and `n` or `N` to search for the next or previous occurrences respectively.

### *Insert and delete*

`o`: insert a new line, after the insertion, the editor is set to `normal` mode.

`x`: remove a character in `normal`.

`r`: replace character in place.

`d`: delete current word, can be used together with `w` or `b`.

`.`: repeat the previous command.


> References:
> 
> [1. Open Vim](https://www.openvim.com/)
> 
> [2. Vim cheat sheet](https://www.fprintf.net/vimCheatSheet.html)