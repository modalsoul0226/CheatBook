# Vue.js: Up and Running

## Table of Contents

- [Week 6: Memory Management](#week-6-memory-management)
- [Week 7 + 9 1/2: Paged Virtual Memory](#week-7-paged-virtual-memory)
- [Week 10 + 9 1/2: Disk and File System](#week-10-file-systems)
- [Week 11: File Systems Integrity](#week-11-file-systems-integrity)
- [Week 12: Deadlock](#week-12-deadlock)

### Chapter 1: The basics

---
#### Why Vue.js?
`Vue.js` is the library that allows us to create powerful client-side application. 

In `Vue.js` the actual logic of the app is completely separated from the view logic.

---
#### `v-if` vs. `v-show`
`Vue` won't attempt to generate the element until the `v-if` statement is `true`.

So, `v-if` has a performance cost. Every time an element is added or removed, work has to be done to generate the DOM tree underneath it. While `v-show` has no such cost beyond the intial setup cost. If something is expected to change frequently, `v-show` might be the best choice.

Also, if the element contains any images, using `v-show` allows the browser to download the image ahead of it being displayed.

---
#### Looping in Templates
`for (value, key) in array/object`

Example:
 ```HTML
 <div id="app">
    <ul>
        <li v-for="(rent, city) in averageRent">
            The average rent in {{ city }} is ${{ rent }}
        </li>
    </ul>
 </div>
 <script>
    new Vue({
        el: '#app',
        data: {
            averageRent: {
                london: 1650,
                paris: 1730,
                NYC: 3680,
            },
        },
    });
 </script>
 ```

 ---
 #### Binding Arguments
 The `v-bind` directive is used to bind a value to an HTML attribute.

 ---
 #### Reactivity
 `Vue` is reactive, meaning that it watches the `data` object for changes and updates the DOM when the data changes.

 `Vue`'s reactivity works by modifying every object added to the data object so that `Vue` is notified when it changes.
 > Every porperty in an object is replaced with a getter and setter so that you can use the object as a normal object, but when you change the property, `Vue` knows that it has changed.

 ---
 #### Two-way data binding

 `v-bind` only allows one-way binding, while `v-model` allows two-way binding. It works on input elements to bind the value of the input to the corresponding property of the data object so that in addition to the input receiving the initial value of the data, when the input is updated, the data is updated too. 

---
#### Setting HTML Dynamically
`<div v-html="yourHTML></div>"`

Whatever HTML is contained in `yourHTML` will be written directly to the page without being escaped first. Use `v-html` only with data you trust in order to avoid XSS vulnerabilities.

---
#### Methods
Since `vue` is reactive, if argument is changed, the method will be called again with the new argument, and the information outputted to the page will be updated.
