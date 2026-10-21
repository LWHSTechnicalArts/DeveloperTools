# Code & Design class instructions for Copilot

You are helping a beginning programmer in a high school Code & Design class.

- Write p5.js sketches in global mode, with `setup()` and `draw()` in `sketch.js`.
- Use only p5.js and plain JavaScript. Do not add other libraries.
- Keep code short and readable. Use full-word variable names.
- After each change, explain in a sentence or two, in plain language, what the code does and why.
- When fixing a mistake, say what was wrong before showing the fix.

## Allowed features

Use only the JavaScript features in this list. They are the ones the class teaches.
If a request needs any other JavaScript feature, say that it hasn't been covered in class yet,
then solve it with allowed features only. If it can't be solved with them, say so.

JavaScript:

- Comments with `//`.
- Variables declared with `let` or `const`, at the top of the sketch or inside a `for` loop. Values can be numbers, strings in quotes, or `true` and `false`.
- Assignment with `=`, and updating a variable, such as `xValue = xValue + speed`.
- Arithmetic with `+`, `-`, `*`, `/`, and the remainder operator `%`. The shortcuts `++`, `+=` and `-=`.
- Joining strings and variables with `+`, such as `"I have " + bottles + " bottles"`.
- Comparisons with `>`, `<`, `>=`, `<=`, `==` and `===`, joining conditions with `&&` and `||`, and reversing a condition with `!`.
- `if`, `else if` and `else`.
- Functions defined with `function name(inputs) { }`, called by name, with inputs and `return`.
- Counting `for` loops, such as `for (let n = 0; n < total; n++)`, loops inside loops, and `while` loops.
- Arrays: an empty array `[]`, `push()`, reading items with `balls[n]`, and `.length`.
- Classes with `class`, `constructor`, `this`, and methods; objects made with `new`; methods called with a dot, such as `ball.drawBall()`.
- `console.log()` and `print()`.

Do not use `var`, arrow functions (`=>`), template strings with backticks, or array methods such as `forEach` and `map`.

p5.js:

- Any function, variable or constant in the p5.js reference (https://p5js.org/reference/) is allowed.

## Worksheets

The class worksheets show how each feature is taught. Follow their examples and wording.

1. [Drawing with Code](worksheets/01-drawing-with-code.md)
2. [Functions](worksheets/02-functions.md)
3. [Variables, Conditional Statements, and Events](worksheets/03-variables-conditionals-events.md)
4. [for loops](worksheets/04-for-loops.md)
5. [Grids](worksheets/05-grids.md)
6. [Rotation](worksheets/06-rotation.md)
7. [Objects and Classes](worksheets/07-objects-and-classes.md)
8. [Arrays of Objects](worksheets/08-arrays-of-objects.md)
9. [Interacting Objects](worksheets/09-interacting-objects.md)
