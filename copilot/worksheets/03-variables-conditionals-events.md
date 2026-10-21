

| Variables  Conditional Statements  Events |  |
| :---- | :---- |

**Vocab**

* **VARIABLE**: A named container that stores a value so you can reuse and change it later.  
* **CONDITIONAL STATEMENT**: Code that checks if something is true and picks what to do next: 

  `if (condition is true) { do a thing }` 

  `else { do a different thing }`

* **EVENT**: Code that runs once, automatically, when something happens — like a key press or mouse click.

**Learning Goals**

* Understand variables and practice using them  
* Understand conditional statements and explore how a program uses them to make choices  
* Understand JavaScript events and practice how an event can update a variable or trigger a conditional statement. 

| Variable A named container that stores a value so you can reuse and change it later.  | A variable is a way to store and name data. I have ten cookies. cookies \= 10   If I eat one, I have nine cookies.   |
| ----- | ----- |
| **1\. Draw a colored ellipse using the code on the right: ** | function setup() {  createCanvas(600,400);  background(80);}function draw() {  fill(200,10,0);  ellipse(100,200,50,70);} |
| **2\. Add a variable that controls the ellipse’s x coordinate.**  Call it **xValue**, as in the x value of the ellipse.. **The word “let” at the top of the program tells p5 that you will be using the word xValue as a variable.**   | let xValue \= 50;function setup() {  createCanvas(600,400);  background(80);}function draw() {  fill(200,10,0);  ellipse(xValue,200,50,70);} |
|  Try changing the value of Xvalue from 50 to something else. Watch what happens in the program.   |  |
| **3\. Now, add a line of code to *update* xValue.** This is called *reassignment*.  **You declare the variable once. You can update the variable as many times as you want.    Draw runs as a loop.** It repeats itself over and over and over again infinitely until you close your browser window.  **Setup is different. It runs only once,** the first time you open the sketch. These functions were created this way by the designers of p5.  | let xValue \= 50; // declarefunction setup() {  createCanvas(600,400);  background(80);}function draw() {   fill(200,10,0);   ellipse(xValue,200,50,70);   xValue \= xValue \+ 5; // update  } |
|  That looks like really bad math, right?  How can xValue \= xValue \+ something else? *This is not an expression, like in math, but rather a set of instructions\! You are literally telling the computer: each time you run the draw loop, add 50 to the value of distance.*   |  |
| **Try putting the same code in setup and see what happens.**   Notice the curly brackets { } that distinguish what is encapsulated in draw and what is encapsulated in setup.  Remember, setup runs once and draw is a loop. This is a built-in feature of the p5 system.  | let xValue \= 50;function setup() {  createCanvas(600,400);  background(80);  fill(200,10,0);  ellipse(xValue,200,50,70);  xValue \= xValue \+ 5;}function draw() {  } |
| **Conditionals** Code that checks if something is true and picks what to do next:  `if (condition is true) { do a thing }  else { do a different thing }`  |  |
| **4\. Let’s add another variable to control the speed of the shape’s movement across the screen.**   Note that we’ve moved the background, fill, ellipse and xValue update into function draw This will make it refresh or animate Try changing the value of speed to 1 or to 10  Try changing the speed to \-5 | let xValue \= 50;let speed \= 5; function setup() {  createCanvas(600,400);}function draw() {  background(80);  fill(200,10,0);  ellipse(xValue,200,50,70);  xValue \= xValue \+ speed;} |
| **5\. Now, let’s add a conditional statement** Before you run this — what do you think happens when `xValue` reaches 600? Write down a guess. Run it and see if you were right. A conditional checks if something is true, and does something different depending on the answer. Here, it's checking: *has the ball reached the edge?* Try changing `600` to a different number. Where does the ball turn around now?  | let xValue \= 50;let speed \= 5; function setup() {  createCanvas(600,400);}function draw() {  background(80);  fill(200,10,0);  ellipse(xValue,200,50,70);  xValue \= xValue \+ speed;  if(xValue \>= 600){    speed \= \-5  }} |
| **Adding Text Did you know there are different *types* of variables?**  Programs separate values into types so they know what operations make sense — you can add two numbers, but adding two words doesn't mean anything the same way. Quotes `" "` are how you tell the computer "this is text, not math." **Common JavaScript variable types: Number —** `let bottles = 99;` (no quotes — used for math, positions, sizes) **String —** `let drink = "fanta";` (quotes — used for words, sentences, labels) **Boolean —** `let isRunning = true;` (only ever `true` or `false` — used for yes/no decisions. We’ll revisit this later in the course)  |  |
| **6\. A variable doesn’t have to be a number.**   Use the [text function](https://p5js.org/reference/p5/text/) and a variable to store and print the name of your favorite food or drink.   Declare your variable at the very top of the code, and print your text inside the setup function. Notice when ‘fanta’ appears and when ‘word’ appears.  Try replacing ‘word’ with drink and see what happens.  | let drink \= "fanta";function setup() {  createCanvas(600,400);  textSize(32);  text(drink, 10, 30);  fill(0, 102, 153);  text('word', 10, 60);  fill(0, 102, 153, 51);  text('word', 10, 90);} |
| **7\. Add another variable to count how many bottles of fanta you have.**   In JavaScript, you can define all your new variable types with the word let. But, strings need quotes around them.   | let drink \= "fanta";let bottles \= 99;  |
| **6\. Use number and string variable types to write a statement to the screen about how many bottles you have.**   Play around with colors and text styling to make the sketch visually appealing.  Use the typography section of the p5 reference to explore many ways that you can style your strings.   | let drink \= "fanta";let bottles \= 99; function setup() {  createCanvas(600,400);  textSize(32);  fill("orange");  text(bottles, 10, 30);  text(drink, 50, 30);}function draw() {} |
| **7\. You can combine variables with text using the `+` symbol. This is called *concatenation* — "chaining" pieces together into one string.** **The quoted parts are literal text** (`"I have "`, `" bottles of "`) — exactly what's inside the quotes gets printed, spaces included. That's why there's a space baked into `"I have "` before the closing quote. **The unquoted parts are variables** — `bottles` and `drink` get replaced with whatever value they currently hold, not the words "bottles" and "drink" themselves. This is the payoff of using variables in the first place: change `bottles = 99` to `bottles = 3` anywhere above, and the sentence updates itself — no need to retype the whole string.  | let drink \= "fanta";let bottles \= 99; function setup() {  createCanvas(600,400);  textSize(32);  fill("orange");  text("I have "\+ bottles \+ "  bottles of " \+ drink, 10, 30);} |
| **Events** Code that runs once, automatically, when something happens — like a key press or mouse click. Unlike `draw()`, which loops constantly, an event function only runs when its specific trigger occurs.  |  |
| **8\. Use the `keyPressed` function to change the number of bottles.** Notice `keyPressed()` is a new kind of function — you didn't call it yourself, and it's not inside `draw()`. p5 calls it automatically, every time *any* key is pressed. Run the code and press any key a few times. Watch what happens to the number. *When using keyPressed, you must click inside the JavaScript canvas to switch from editing the code to interacting with the sketch.*  | let drink \= "fanta";let bottles \= 99; function setup() {  createCanvas(600,400);  }function draw() {    background("blue");  textSize(32);  fill("orange");  text("I have "\+ bottles \+ " bottles of " \+ drink, 10, 30);}function keyPressed(){  bottles \= bottles \-1;} |
| **8\. Add a conditional to prevent an error.** Right now, nothing stops `bottles` from going negative. Let's use a conditional *inside* the event — so the decision happens exactly when the key is pressed: if (something is true) {   do the stuff in here } else {   do something else instead }  | function keyPressed(){  if(bottles \> 0){  bottles \= bottles \-1;  }  else {    bottles \= 99;  }} |
| **SYNTAX: comparing vs. assigning** One equals sign (`=`) **assigns** a value: `bottles = 99` means "set bottles to 99." Two or three equals signs (`==` or `===`) **compare** two values and check if they're equal: `if (bottles == 0)` means "is bottles equal to 0?" Mixing these up is one of the most common bugs in programming — a single `=` inside an `if` statement won't do what you expect.  |  |
| **Inspiration:** these two games rely heavily on variables, conditionals and events to create an exciting interactive experience.  |  |
| ****   [Clicking Game by Greg Wittmann](https://openprocessing.org/sketch/172603)                                  | **** [Letter shuffle by Aaron Reuland](https://openprocessing.org/sketch/1419579)  |
| **VARIABLES AND IF STATEMENTS MINI PROJECT:** Create an interactive drawing using variables, keyboard events and conditional statements.   Use what you’ve already made in this worksheet as a starting point. Use the p5 [typography](https://p5js.org/reference/#Typography) options to customize your text. Try adding a graphic.  What happens if you input a variable as a property of your graphic (x, y, width, height)? Make your drawing change based on the value of your variable.  Extra challenge. Load a custom font. Browse and download at DaFont.com then use [loadFont](https://p5js.org/reference/p5/loadFont/) to put it into your sketch. You will need to use asynchronous file loading, so [here is a resource](https://docs.google.com/document/d/1rCbCcXMcANeNH1GWht10o9ljOPV1EK3Ft0lhOhxsfPU/edit?usp=sharing).  Upload a screenshot and a link to the variables page of the class blog. Include a description in your own words: what’s a variable, a conditional statement, and a JavaScript event?   |  |

Extra Reference:   
Loading Custom Fonts





