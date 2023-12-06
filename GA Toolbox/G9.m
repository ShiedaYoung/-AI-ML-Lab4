function y = G9(x)
    % Matlab Code by A. Hedar (Nov. 23, 2005).
    % Constraints
    v1 = 2*x(1)^2;
    v2 = x(2)^2;
    z(1) = v1+3*v2^2+x(3)+4*x(4)^2+5*x(5)-127;
    z(2) = 7*x(1)+3*x(2)+10*x(3)^2+x(4)-x(5)-282;
    z(3) = 23*x(1)+v2+6*x(6)^2-8*x(7)-196;
    z(4) = 2*v1+v2-3*x(1)*x(2)+2*x(3)^2+5*x(6)-11*x(7);
    % Variable lower bounds
    constraint = 0;
    for i =1:4
        if z(i) > 0
            constraint = constraint + z(i);
        end
    end
    if constraint == 0

        %calculate objective function value if meet the constraint conditions
        y = (x(1)-10)^2+5*(x(2)-12)^2+x(3)^4+3*(x(4)-11)^2+...
            10*x(5)^6+7*x(6)^2+x(7)^4-4*x(6)*x(7)-10*x(6)-8*x(7);
    end
    if constraint > 0

        %Eliminate individuals which do not meet the constraint conditions
        y = 100000;
    end
end