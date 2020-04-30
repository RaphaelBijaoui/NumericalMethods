# NumericalMethods
Solving ODEs and PDEs using numerical analysis in Matlab.

<p align="center">
  <img width=550 src="https://github.com/RaphaelBijaoui/images/blob/master/NMrelaxation.png">
</p>
<p align="center">
  <i><b>Figure:</b> Solution of Laplace equation for boundary conditions u(0, y) = u(1, y) = y , for 0 < y < 1; u(x, 0) = u(x, 1) = x , for 0 < x < 1;</i>
</p>

As defined in spec.pdf, as part of ELEC95018 Mathematics 2C: Numerical Analysis, we were tasked to work on five different exercises, focusing on the numerical analysis of ordinary and partial differential equations with the help of MATLAB. 

Three second order Runge-Kutta methods are covered throughout the course of this project, namely Heun’s method, midpoint method, and a method of our choice. Following this, we applied the Gauss-Seidel relaxation method, followed by an adaptation of it with Successive Over-Relaxation (SOR).

Numerical methods are mathematical methods that find/approximate the solution to complicated problems, by reducing it to a series of addition, subtraction, or multiplication operations. It provides a fast solution to many mathematical problems which are present in various fields of engineering.

By annotating the relevant MATLAB code, explaining the results, and elaborating the mathematical processes behind the results in our Project Report, we aim to provide a concise explanation of how numerical methods can be used to solve problems faced by engineers in the modern world.

## Setup
First, if you haven't already, make sure you have MATLAB installed on your local machine! 
<a href="https://www.mathworks.com/downloads/">This link</a> should help facilitate that.

Next, ensure you have this project locally. Run this command in terminal, from the folder you would like the file to be in.
```
git clone https://github.com/RaphaelBijaoui/NumericalMethods.git
```
Open Matlab and from there, open the folder you just downloaded.

Now onto the fun stuff!

### Running Scripts
All scripts can be run from the Matlab application. This is a general guide of what each script does:
- **RK.m:** a matlab function that implements Heun’s method, the midpoint method and a new method we devised.
- **RK2_script.m:** contain calls to the function RK.m, for a number of different examples, as outlined in spec.pdf page 2.
- **error_script.m:** error analysis for the solution of an RC circuit, basic case with R, C, qC(0) as above, with a cosine wave as input.
- **RLC_script.m:** solves the ODE from an RLC circuit for a range of input functions. See Exercise 3 from spec.pdf for more.
- **RK4.m:** a matlab function that implements the classic fourth-order Runge-Kutta algorithm for any system of two coupled first order equations. Needs to be passed arguments.
- **relaxation.m:** implements the Gauss-Seidel relaxation method for Laplace’s equation on the unit square, with boundary conditions u(0, y) = u(1, y) = y , for 0 < y < 1; u(x, 0) = u(x, 1) = x , for 0 < x < 1; 
- **SOR.m:** a more computationally efficient solution of Laplace's equation using Successive Over-Relaxation (SOR.m)

## Final Comments
For a more in-depth analysis of these numerical methods, have a look at ProjectReport.pdf, which details our findings along this exciting project defined in spec.pdf for ELEC95018 Mathematics 2C: Numerical Analysis, completed alongside George Chen, Archibald Crichton, Karl K Melaimi, Samuel Sim, and Stacey Wu. 

----------------------------------------------------------------------------------------------------------------------------

... and as usual, if anything, the door is always open. Contact details in bio!

Enjoy :)
