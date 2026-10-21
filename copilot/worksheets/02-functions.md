# FUNCTIONS 



### What is a function? 

In programming, a function is a named set of instructions that you can use over and over again. 

* It can take in information (called **inputs** or **parameters**) so it works with different values each time you use it — like a recipe that adjusts based on how many people you're feeding.  
* It can send back a result when it's finished (called a **return value**), which the rest of your code can then use.

### Why are they important? 

They make our code organized and save us time. 

* They follow the **"Don't Repeat Yourself" (DRY)** principle — instead of copying and pasting the same steps in multiple places, you write them once and just call the function's name whenever you need them.  
* They make fixing mistakes easier, since you can test and troubleshoot one function on its own instead of digging through your entire program.

### Worksheet Goals

* Write your own function and use it to display code  
* Understand ***ENCAPSULATION***– containing a process inside a function, so you can easily call it into action.   
* Add inputs to your function and move it around the screen  
* Post your work to the blog

### Worksheet Contents

* [Warmup](#bookmark=id.vgy7r8dfc2vn)  
* [Writing your own functions](#bookmark=id.sl4do6cmozul)  
* [Adding inputs](#bookmark=id.9m96lm9n1vsr)  
* [Extra Activities](https://docs.google.com/document/d/1xXN9gNnSjuH6ekCpdS-8PniLBlxb_0C6_F7KOjGA6Ko/edit?usp=sharing)

### **Examples**

[https\://editor.p5js.org/sidchan/sketches/UmzyOhksC](https://editor.p5js.org/sidchan/sketches/UmzyOhksC)  
[https\://editor.p5js.org/raduan/sketches/78HkTGept](https://editor.p5js.org/raduan/sketches/78HkTGept)

| Warmup:  Go to the [P5 editor](https://editor.p5js.org/) and start a new sketch. Change the background color. Make a simple design using rectangles and ellipses   | function setup() {  createCanvas(400, 400);}function draw() {  background("pink");  fill(0,200,200);  ellipse(100,100,50,60);} |
| ----- | :---- |
| **Calling Functions** In your P5 journey so far, you have now used many built-in functions such as  **ellipse()** **fill** () **background()** (by the way, using functions is usually referred to as *calling*, *running*, or *invoking* them).  |  |
| **Defining Functions**  In addition to calling functions, you have also *defined* several functions. These were the special P5 functions **setup** and **draw**.   We didn’t need to call these; P5 does it for us, automatically.   | function setup() { }function draw() { } |
|  When you run your program, P5 calls **setup** once and then calls **draw** repeatedly, allowing you to create animations.  This is a built-in feature of the p5.js library.  Try replacing the x coordinate of the ellipse with a random number between 0 and 400\.  | function setup() {  createCanvas(400, 400);}function draw() {  background("pink");  fill(0,200,200);    ellipse(random(0,400),100,50,60);} |
| **Check what happens if you put that code inside of setup instead of draw:**  | function setup() {  createCanvas(400, 400);  background("pink");  fill(0,200,200); ellipse(random(0,400),100,50,60);}function draw() { } |
| **Writing New Functions** Now we’ll add something new: creating our own functions, functions which we both define *and* invoke.  |  |
| **Type or copy and paste the code on the right.**   This code ***defines*** a new function, called donut, and it also ***calls*** that function, from inside the setup function. You **define** a function with the word *function* and a set of curly brackets. Once you have defined it, you **call** it from within setup or draw to activate it.    | function setup() {   createCanvas(600, 600);   donut();}function draw() {}function donut() {    ellipse(90, 90, 100, 100);    ellipse(90, 90, 50, 50);} |
|  **Make your own simple shape using rect and ellipse.**   |  |
| Turn your own shape into a function:  ***Define*** your function at the bottom of the program ***Call*** your function inside of draw or setup.   | function setup() {   createCanvas(600, 600);   newShape();}function draw() {}function newShape() {    rect(90, 90, 100, 100);    ellipse(90, 90, 50, 50);} |
|  Let’s talk about ***encapsulation***.  Notice the curly brackets { }  around your function definitions– in setup, in draw and in your own unique function.  The brackets { } control what is contained or ***encapsulated*** in each named process.  A core principle of writing good code is breaking a complex process into simple, understandable, executable chunks.  Once instructions are encapsulated in a function, you can run them just by calling the function’s name.   |  |
| **Functions with Inputs or Parameters** Inputs or parameters can allow your function to be adjustable. You can pass data into the function and it will use that in its process.   |  |
|  The function on the right has two **inputs** for the x and y value.  Notice how the inputs make the function flexible. Can you add another parameter or input to the donut function? Or to your own function?    | function setup() {   createCanvas(600, 600);   donut(100,200);   donut( 300,350);}function draw() {}function donut(x, y) {    fill("brown");    ellipse(x, y, 100, 100);    fill("white");     ellipse(x, y, 50, 50);} |
|  **Add at least two inputs to your own unique function**  |  |
| **For fun, try attaching your function to the location of your mouse:**   For this to work, your function must be inside draw, not setup.  Why do you think this is true? What happens if you move **background("white")**   from draw into setup?  | function setup() {   createCanvas(600, 600);}function draw() {  background("white")  donut(mouseX,mouseY,100,40);}function donut(x, y, d, h) {    fill("brown");    ellipse(x, y, d, d);    fill("white");     ellipse(x, y, h, h);} |
| **Functions that Return a Value** You can also make a new function **with inputs and output** (“this function **returns** a value”)  |  |
|  The function on the right multiplies its input by 2\. Use it as an example and try the following exercises: Write a squared function that takes in a number and returns that number squared (to the power of two). Write a “hello” function that takes in a name string (text in quotes) and puts “hello “ in front of it. Here’s the return statement you need for this:  return “hello “ \+ name;  (the above code will combine the name and the word “hello” with a space and output a greeting).  | function setup() {  createCanvas(600,500);  console.log(multiplyByTwo(4))  console.log(multiplyByTwo(200))}function draw() {  background(240);  text(multiplyByTwo(mouseX), 200,200);  }function multiplyByTwo(num){   return num \* 2;} |
| **MINI-PROJECT:**  Draw a few of your own shapes on the canvas using functions with inputs.  Save your sketch.  Take a picture of your design and post it to the functions page on the blog with a link to your sketch in the p5 editor.   Add a brief description, in your own words, of what is a function and why it is useful.  Make sure your blog post has your name on it.  Follow the format from the Drawing With Code blog page.   |  |

