# ArrayClass
Better arrays/ds_lists for GameMaker Studio 2.3

ArrayClass is a library that improves the developing experience and reduces frustration when working with arrays.

It's main focus is not performance, but rather handiness for developer


### Maintained by [@evolutionleo](https://github.com/evolutionleo)

## Features:

- **Methods for every possible situation.** Even if you ever need a function that is not in the list, you can write your own implementation using forEach().
- **Automatic garbage collection.** No need to manually destroy the Array, GM will do it for you.
- **Chaining methods.** Most of the methods return the array, so you can do stuff like this: `arr.add(1).reverse().remove(0).slice(1, 4).find(pi)` (perfectly valid)
- **Intuitive API,** built to be handy for developers; easy conversion to and from ds_lists/arrays for more flexibility
- **Customizable sorting.** It's weird that most of the sort functions I've seen only had the ascending/descending option. My implementation of bubble sort takes a custom function to compare values. Sort any types of data in any way you want
- **Additional features** like iterators or ranges

## Getting Started:

### Importing into an existing project
- **Download the .yymps file**
- Open GameMaker IDE, click Tools/Import Local Package
- Import ArrayClass.gml, documentation is included
- *Also Import Tests.gml to see examples on how to use the library
### Exerimenting/Learning API
- Download the project folder
- Open the project
- Try editing Tests.gml in different ways and see what happens!



## Some Examples:

## Adding Values:

### GM arrays:
```
arr[array_length(arr) - 1] = item
```
### Array Class:
```
arr.add(item)
```

## Looping:
### GM arrays:
```
for(var i = 0; i < array_length(arr); i++) {
  foo(arr[i], i)
}
```
### Array Class:
```
arr.forEach(foo)
```

## Deleting values:
### GM arrays:
```
for(var i = pos; i < array_length(arr) - 1; i++) {
  arr[i] = arr[i + 1];
}
```
### Array Class:
```
arr.remove(pos)
```



P.s. a new commit erased the old README file, so I was forced to write a new one :(
