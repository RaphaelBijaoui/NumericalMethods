% Exercise 4, Group 7

threshold = 2^(-15);

%Drawing grid (basic)
gridsize = 0.01;
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
                    u(i,j) = u(i,j) + residue/4; %Gauss-Seidel method               
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
       

%Visualising u(x,y) 
figure;
surf(x,y,u);
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
  title(['Solution to Laplace Equation using relaxation, gridsize= ' ...
      num2str(gridsize) ' num iterations= ' num2str(full_matrix_iterations)]);
  view(90,0); %alter this for different default angle view of 3D space
    saveas(gcf, ['exercise4.gridsizeY.' num2str(gridsize) '.pdf']);
