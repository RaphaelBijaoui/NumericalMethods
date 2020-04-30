function [t,x] = RK(f, a, b, p, q, tstart, xstart, tfinal, step_size)
	N = round((tfinal - tstart)/step_size);
	t = [tstart];
	x = [xstart];
	for j = 1:N
        k1 = f(t(end), x(end));
		k2 = f(t(end)+p*step_size, x(end)+q*k1*step_size);
		x(end + 1) = x(end) + step_size * (a*k1 + b*k2);
		t(end + 1) = t(end) + step_size;
	end
end
