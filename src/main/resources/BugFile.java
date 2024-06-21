// JavaScript code with intentional bugs

// Bug 1: Missing 'function' keyword
function greeting() {
  console.log("Hello, world!");
}

// Bug 2: Typo in variable name
let messgae = "This should be 'message'";

// Bug 3: Incorrect comparison operator
let number = 10;
if (number = 10) {
  console.log("Number is 10");
}

// Bug 4: Unmatched quotes
let string = 'This is a string with unmatched quote;

// Bug 5: Missing semicolon
let x = 5
console.log(x);

// Bug 6: Undefined variable used
let y = z + 10;

// Bug 7: Improper function call
console.log(multiply(3, 4));
function multiply(a, b) {
  return a * b;
}

// Bug 8: Incorrect array indexing
let arr = [1, 2, 3];
console.log(arr[3]);

// Bug 9: Incorrect loop condition
for (let i = 0; i <= 5; i++) {
  console.log(i);
}

// Bug 10: Incorrect object property assignment
let obj = {};
obj.name = "John";
obj.age = "30 years old";

console.log(obj);
