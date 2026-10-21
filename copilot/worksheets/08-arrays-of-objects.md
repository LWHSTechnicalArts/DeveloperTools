2\. ARRAYS OF OBJECTS  
  
For help with this module, you can watch a 10 minute tutorial about objects and classes: [7.3: Arrays of Objects - p5.js Tutorial](https://www.youtube.com/watch?v=fBqaA7zRO58)

|  Draw many objects from one class by making many class instances with varying parameters. [Here is an example](https://editor.p5js.org/lizzybrooks/sketches/XI0IiMhyT) for you to use as a reference.   |  |
| ----- | ----- |
|  ***Create a new p5 sketch for this lesson.***   |  |

| Creating new objects automatically  Object syntax becomes really powerful when you automate the process, so you create a new object every time a certain condition is met (e.g. when a key is pressed, when 2 seconds have passed, when your avatar bumps their head on a brick, etc. etc.)  |  |
| ----- | :---- |
| **Make your Ball class.**  You’ll use this class to make the objects we’ll be working with. This class will need the following two class methods: drawball and moveball.  Use the [Classes & Objects worksheet](https://docs.google.com/document/d/171w9XsIzRuoY35Jiu_dq99xJjiPJmsd5oB4AIWWZjj0/edit?usp=sharing) for reference if you need.  | // write your own class\!  |
| **Make an array to hold all your objects:**   At the top of your code, create an empty array (like a list) called balls.  If you’re going to make a lot of objects and you don’t know how many, you make an empty array to hold all the objects you make.   | let balls \= \[\]; |
| **Make an object and PUSH it to the array:**  Put the code on the right inside your setup function. Make a variable, called b, and in it create a new Ball  “Push” that ball into the empty array. Print the whole array to see the ball that you created.  |   let  b \= new Ball(100, 100, "green");  balls.push(b);  print(balls); |
| Make a few more variables with balls in them, and push them into the array.  |  |
| **Push an object into the array every time you press a key:**  Copy the code on the right and paste it into your sketch, not inside any other function.  The keyPressed function allows you to do something every time you push any key.   | function keyPressed(){   let  z \= new Ball(10,10,"red");  balls.push(z);  print(balls);} |
| Now change the code so the ball appears at (200,200). Can you make it appear at a random location?  Can you make it a random color?  |  |

|  Now, you need to draw and move ALL the balls in the array  |  |
| :---- | :---- |
| **First, a bit about arrays:**  Items in an array get accessed with this syntax: balls\[0\]  is the first ball balls\[1\]  is the second ball, etc.  Use the code on the right to draw a specific ball from your array  | balls\[0\].drawBall();balls\[3\].drawBall(); |
| **Use a loop to draw and move all the balls:**  Put the code on the right into your draw function You can use a *for loop* to draw and move all the balls in the array.  So, you can cycle through all the balls in the array using the syntax balls \[ n \] where n counts from 0 to the highest number in the array.  Your array is changing in length every time you add a new ball to the array, so you say balls.length as the ending condition.  | for (let n \= 0; n \< balls.length; n++){       balls\[n\].drawBall();       balls\[n\].moveBall();	} |

|  Customize this sketch  |  |
| ----- | ----- |
|  [Here is a really fun example that uses images.](https://editor.p5js.org/lizzybrooks/sketches/BqEopmgDv) (full video support available [here](https://www.youtube.com/watch?v=FVYGyaxG4To)) Use the keyPressed entry in the  [p5 reference](https://p5js.org/reference/#/p5/keyCode) to assign ball creation to a specific key. Then you can create a different object with another key.  Use this technique to create something for your game. Think about, what’s a game element that you need to make a lot of (e.g. platforms, treasures, exploding suns,   |  |
| **POST THE FOLLOWING INFO TO THE BLOG:**   Title your first post with today’s date and Arrays of Objects  Post a screenshot or gif of your sketch. If you have a mac, I recommend using the [GIPHY CAPTURE](https://giphy.com/apps/giphycapture) software to create animated gifs.  Post a link to your code Write a 1-2 sentence description of your learning. |  |

