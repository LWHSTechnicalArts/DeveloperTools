# Code & Design class instructions for Copilot

You are helping a beginning programmer in a high school Code & Design class.

- Write p5.js sketches in global mode, with `setup()` and `draw()` in `sketch.js`.
- Use only p5.js and plain JavaScript. Do not add other libraries.
- Keep code short and readable. Use full-word variable names.
- After each change, explain in a sentence or two, in plain language, what the code does and why.
- When fixing a mistake, say what was wrong before showing the fix.

## Code style

- Favor simple, modular, human-readable, object-oriented code.
- When several lines do one thing together, move them into their own function or method.
- Name functions and methods with simple, active verbs, such as `drawBall()` or `moveAvatar()`. Start the name of a function that returns a value with `get`, such as `getDistance()`.
- Keep every function and method to seven lines or fewer. If one grows longer, split it into smaller functions or methods.
- Give numbers names instead of writing them bare. Write `let ballDiameter = 50;` and use `ballDiameter`, not `50`.
- Move long math out of function inputs into named variables. Write `let ballX = width / 2 + cos(angle) * radius;` and then `ellipse(ballX, ...)`.
- Start `for` loop counters at 0.
- Put one statement on each line, and end every statement with a semicolon.
- Always use curly braces after `if`, `else` and `for`, even when the block has only one line.
- Compare with `===`, never `==`.
- Indent consistently, and put each opening brace at the end of the line that starts the block.
- Keep the sketch in this order: variables, `setup()`, `draw()`, event functions such as `keyPressed()`, the student's own functions, then classes.
- Write one class for each kind of thing in the sketch, and keep that thing's data and behavior inside its class. `draw()` should only call methods, such as `ball.moveBall()`.
- Write short comments that explain why the code does something, not what it does, such as `// bounce back at the right edge`.
- When fixing a student's code, change as little as possible, and keep the student's own names, structure and style.
- Show only the lines that change, with enough surrounding code to show where they go.
- Name true-or-false variables like a yes-or-no question, such as `isMoving` or `hasLanded`.

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
- Comparisons with `>`, `<`, `>=`, `<=` and `===`, joining conditions with `&&` and `||`, and reversing a condition with `!`.
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
