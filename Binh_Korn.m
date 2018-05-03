function f = Binh_Korn(x)
% Test optimization function
f(1) = 4*x(1)^2 + 4*x(2)^2;
f(2) = (x(1) - 5)^2 + (x(2) - 5)^2;
f = [f(1)
    f(2)];
end

