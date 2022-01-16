# ArrayClass
Better arrays/ds_lists for GameMaker Studio 2.3

ArrayClass is a library that improves the developing experience and reduces frustration when working with arrays.

It's main focus is not performance, but rather handiness for developer

### Maintained by [@evolutionleo](https://github.com/evolutionleo)

## > Edit: 04.21
As of GMS version 2.3.1 YoYo Games introduced a handier API for arrays, so this lib is not as relevant as it previously was

So it's no longer really worth it using this just for simple append/delete logic, but instead only if you need any somewhat complex array functionality (e.x. shuffle, get random, filter, etc.)

ArrayClass will always be slower than native arrays, but as stated above it's intended to be a handy shortcut, rather than high-performant solution. (e.x. `arr.quicksort()` while quick, is still slower than the internal `array_sort()` method)

The performance difference is only really noticeable on huge quantities of data though and doesn't matter that much unless you're making a really huge project

## Features:

- **Methods for every possible situation.** Even if you ever need a function that is not in the list, you can write your own implementation using forEach().
- **Automatic garbage collection.** No need to manually destroy the Array, GM will do it for you.
- **Chaining methods.** Most of the methods return the array, so you can do stuff like this: `arr.add(1).reverse().remove(0).slice(1, 4).find(pi)` (perfectly valid)
- **Intuitive API,** built to be handy for developers; easy conversion to and from ds_lists/arrays for more flexibility
- **Battle-tested.** I developed a card game using ArrayClass and added new functions whenever a need appeared (`.shuffle()`, `.getRandom()`, `.some()`, `.removeValue()` were added during the development)
- **Customizable sorting.** It's weird that most of the sort functions I've seen only had the ascending/descending option. My implementation of quicksort takes a custom function to compare values. Sort any types of data in any way you want.
- **Additional features** like iterators or ranges

P.s. Also I was bored and implemented a couple sorting algorithms for fun. You shouldn't really use any of those but .quicksort() or .sort() though

## Getting Started:

### Importing into an existing project
- **Download the .yymps file**
- Open GameMaker IDE, click Tools/Import Local Package
- Import ArrayClass.gml, documentation is included
- *You can also Import Tests.gml to see examples on how to use the library
### Exerimenting with API
- Download the project folder
- Open the project
- Try editing Tests.gml in different ways and see what happens!


## > Note:
GMS2 doesn't allow you to access any local variables inside a function, so here's a very useful solution that works around it called `Pack.gml`:
https://gist.github.com/evolutionleo/e87b805719f45ad0d11956e97f708637

it's basically like using global variables, except they never leak out and mess up anything in your game + you don't have to make up new names every time

This might really come in handy when using `.forEach()`

## Some Examples:

## Adding Values:

### GM arrays:
```gml
[pre 2.3.1] arr[array_length(arr) - 1] = item
[2.3.1+]    array_push(arr, item)
```
### Array Class:
```gml
arr.add(item)
```

## Looping:
### GM arrays:
```gml
for(var i = 0; i < array_length(arr); i++) {
  foo(arr[i], i)
}
```
### Array Class:
```gml
arr.forEach(foo)
```

## Deleting values:
### GM arrays:
```gml
[pre 2.3.1] for(var i = pos; i < array_length(arr) - 1; i++) {
              arr[i] = arr[i + 1];
            }
[2.3.1+]    array_delete(arr, pos, 1)
```
### Array Class:
```gml
arr.remove(pos)
```



P.s. a new commit erased the old README file, so I was forced to write a new one :(
