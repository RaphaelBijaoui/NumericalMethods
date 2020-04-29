% Exercise 5, Group 7

%Successive Over Relaxation- same thing as relaxation, but with a
%factor on r, which at the right value can accelerate convergence
%Here, our "factor on r" is w. 1<w<2
%Script: tests various values on w for fastest convergence.

for p = 0:19
w = 1+p*0.05;

%Drawing grid (basic)
gridsize = 0.06;
axis_limit = 1; %for 0<x<1 and 0<y<1
num_elements = round(axis_limit/gridsize);
x = 0:gridsize:num_elements*gridsize; 
y = 0:gridsize:num_elements*gridsize;
u = zeros(num_elements+1,num_elements+1); %initializing all inner values to 0

%Setting boundary conditions in matrix, calculating bordsum
bordsum = 0;
for i = 1:num_elements+1
    bordsum = bordsum + 2 * (x(i)+y(i));
    u(i,1) = x(i);
    u(i,end) = x(i);
    u(1,i) = y(i);
    u(end,i) = y(i);
end

%Determining average inner value k
k = bordsum / (4*(num_elements+1)); 

%Setting all inner points to k
for i = 2:length(x) - 1 %for every inner x value
    for j = 2:length(y) - 1 %for every inner y value
        u(i,j) = k;
    end
end

full_matrix_iterations = 0; %to assess performance of method

while(true)
        full_matrix_iterations = full_matrix_iterations + 1;
        max_residue = 0; %for convergence to threshold
        for i = 2:length(x) - 1
                for j = 2:length(y) - 1
                    residue = u(i+1,j) + u(i-1,j) + u(i,j+1) + u(i,j-1)...
                        - 4*u(i,j);
                    u(i,j) = u(i,j) + w*residue/4; %Gauss-Seidel method               
                    if(abs(residue) > max_residue)
                           max_residue = abs(residue);
                    end
                end
        end
        if(max_residue < threshold)
            full_matrix_iterations %prints final iterations
            break;
        end
end
       

%Visualising
figure;
surf(x,y,u);
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
  title(['Solution to Laplace Equation using SOR, w= ' ...
      num2str(w) ' num iterations= ' num2str(full_matrix_iterations)]);
    saveas(gcf, ['exercise5.SORfactor.' num2str(w) '.svg']);
end
