**Drawing With Code** in JavaScript  


**Goals for this worksheet:** 

* Explore, experiment   
* Use the console and the reference  
* Make a piece of art

**Core Concepts**

* A ***code library*** is a collection of pre-written, reusable functions (or other code) that other programmers can use in their own programs instead of writing everything from scratch.  
* The ***JavaScript Canvas*** is a web page element that acts like a blank drawing surface, letting you use JavaScript code to draw shapes, images, and animations directly on a webpage.  
* The ***JavaScript Console*** is a tool built into web browsers that lets you see messages, check for errors, and test small pieces of JavaScript code while you're building a program.

| Part 1: Drawing shapes in your new code editor |  |
| ----- | ----- |
|  Go to the [p5.js web editor](https://editor.p5js.org/) and create an account.  Look on the top right for the log in or sign up button.    |   |
| Push the play button to see default code.  You’re creating a canvas that’s 400x400 pixels wide. You’re filling that canvas with a gray color.   |  |
| Try changing the size of the canvas to 500x500. Push Play to see your work.  |  |
| Now change the background color of the canvas.  First type the name of [a color you like](https://developer.mozilla.org/en-US/docs/Web/CSS/named-color), in quotes, like this: “turquoise”  Push PLAY to see your work. Then try entering a color numerically.  Go to an [RGB color picker](https://www.google.com/search?q=rgb+color+picker&oq=rgb+color+picker&aqs=chrome..69i57j0l5.2339j0j7&sourceid=chrome&ie=UTF-8), and find the red, green and blue values of a color you like, (e.g. 66, 244, 229).  Enter those numbers into  background() and push PLAY.  |  |
| Now draw a shape somewhere on the screen. Use the [shapes menu in the p5 reference manual](https://p5js.org/reference/#group-Shape) to get the code and the parameters for drawing shapes: The canvas is an x,y grid where (0,0) is the upper left corner.  [https\://p5js.org/reference/\#group-Shape](https://p5js.org/reference/#group-Shape) |  |
| Use the [fill() function](https://p5js.org/reference/p5/fill/) to give your shape a color.  Set your fill before you draw your shape (think about it like choosing which paint to use, then painting).  Play with [stroke(), strokeWeight()](https://p5js.org/reference/p5/stroke/) and [noStroke()](https://p5js.org/reference/#/p5/noStroke) |  |
| Draw a few more shapes.  Play with transparency: Add a fourth parameter to your color name: fill(30,210,45,150); [Explore complimentary and contrasting colors](https://color.adobe.com/create/color-wheel/). (We will do more with color later in the class).  |  |
|  **Hooray\! You are now programming shapes in P5\!**    |  |
|  **Part 2: The JavaScript console\* & the p5 coordinate plane** \*a useful tool that helps you understand what your code is doing |  |
|  The console is a place where you can get messages from the computer.  First, we will use it to better understand the coordinate plane in p5.   |  |
| Find the console window in your p5 editor (below the place where you write your code. So far, we have not asked the computer to print or log anything in the console, so it’s blank. Unless you had an error in your code— if that happened you saw an error message in there.   |  |
| Now we’ll ask the computer to log the x and y location of the mouse on the p5 canvas, and write that information to the console.  Add this line of code into your draw function. Move your mouse around over the canvas and watch the console.  You are “logging” your mouse coordinates.   |    console.log(mouseX,mouseY) |
|  ***What do you notice about the way the coordinate plane works in p5?***   |  |
|  Try using the mouse coordinates to control the placement of a shape	  |  rect(mouseX,mouseY,60,60) |
|  **Part 3: Using the [*p5 reference*](https://p5js.org/reference/)**   |  |
| p5js is a code library — also known as a module — for the larger JavaScript language.  That means that it’s a collection of pre-written code that you can use so you don’t have to reinvent the wheel— or, the line, as the case may be here. Every good code library has a robust documentation area, where you can browse for new tools or look up the specifics of how a specific piece of code works.  Programming languages and modules are written by humans, and we use the documentation to translate them into our various languages.  |  |
| Look up [line](https://p5js.org/reference/#/p5/line).  Draw some lines that look roughly like these three. |  |
| Play around with the arc function.  [Set your angle mode to DEGREES](https://p5js.org/reference/p5/angleMode/) (the default mode is radians): You can use stroke and fill to color your arcs too.   |   |
|  Look up [beginShape](https://p5js.org/reference/p5/beginShape/).  Draw a funky 7-sided shape. Use your knowledge of the coordinate plane to place your shape’s vertices.   |  |
| Look up **triangle** in the [P5 reference](https://p5js.org/reference/). Draw something fun with a triangle  |  |
|  **Drawing With Code** mini project  |  |
|  *Using your new ability to draw shapes, lines, and arcs, and to color them, create a shape or pattern of your own.*   |  |
| **Creative Prompt A:** Make a drawing about something that happened to you today– it can be as abstract or as realistic as you want  |  |
| **Creative Prompt B:** Make a digital painting inspired by the work of [Manolo Gamboa Naon](https://www.artnome.com/news/2018/8/8/generative-art-finds-its-prodigy) & [https\://x.com/manoloidee](https://x.com/manoloidee)                                                                                        |  |
| The following techniques might help you in your drawing *(they are optional\! Use as needed\!)*:  Read about [bezier](https://p5js.org/reference/p5/bezier/) curves. Add an interesting curved line to your canvas. [Here is a really great 10 minute video about bezier curves.](https://www.youtube.com/watch?v=Czbt_f8gmm8)  Read about [bezierVertex](https://p5js.org/reference/p5/bezierVertex/). This is how to chain multiple curved shapes together into one shape. Add a shape that looks like a butterfly to your canvas. This function is tricky, do some experiments and get as far as you can…  |  |
|  **To Turn in Your Work Follow All Three steps below:**   |  |
| **1: SAVE YOUR WORK**   Save your project in the p5 editor. You must be logged in to save.  |  |
| **2: TAKE A PICTURE**  Take a screenshot of your drawing. In Mac: COMMAND SHIFT 4 In Windows: Start —\> Applications —\> Snipping Tool.   |  |
| **3: POST YOUR PICTURE AND LINK TO THE CLASS BLOG** Go to the [Drawing With Code page on our class blog](https://sites.google.com/lwhs.org/gg-fall-2026/lessons/drawing-with-code).  Add your name a **SCREENSHOT**  a **LINK** to your PROJECT in the p5 editor One thing you learned about the p5js library and one thing you’re wondering.  Click the blue PUBLISH button to save your post.  |  |



















