function [t,x,y] = RK4(fx, fy, tstart, xstart, ystart, tfinal, step_size)
	N = round((tfinal - tstart)/step_size); % finding number of steps to do
	t = [tstart]; % initialising array of t values
	x = [xstart]; % initialising array of x values
    y = [ystart]; % initialising array of y values
	for j = 1:N
        % finding base case k1 values
        k1x = fx(t(end), x(end), y(end));
        k1y = fy(t(end), x(end), y(end));
        % using k1 to find k2 values
		k2x = fx(t(end)+.5*step_size, x(end)+.5*k1x*step_size, y(end)+.5*k1y*step_size);
		k2y = fy(t(end)+.5*step_size, x(end)+.5*k1x*step_size, y(end)+.5*k1y*step_size); 
		% using k2 to find k3 values
        k3x = fx(t(end)+.5*step_size, x(end)+.5*k2x*step_size, y(end)+.5*k2y*step_size);
		k3y = fy(t(end)+.5*step_size, x(end)+.5*k2x*step_size, y(end)+.5*k2y*step_size);
		% using k3 to find k4 values
        k4x = fx(t(end)+step_size, x(end)+k3x*step_size, y(end)+k3y*step_size);
		k4y = fy(t(end)+step_size, x(end)+k3x*step_size, y(end)+k3y*step_size);
        % combining k values to find next value of x and y
        x(end + 1) = x(end) + step_size * ((1/6)*(k1x+k4x) + (1/3)*(k2x+k3x));
        y(end + 1) = y(end) + step_size * ((1/6)*(k1y+k4y) + (1/3)*(k2y+k3y));
		t(end + 1) = t(end) + step_size;
	end
end
