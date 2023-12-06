function FitnV = penalty(NIND, x, FitnV)    
    % Additional Constraints
    for i = 1:NIND
        g1 = 2*x(i,1)^2 + 3*x(i,2)^2 + x(i,3) + 4*x(i,4)^2 + 5*x(i,5) - 127;
        g2 = 7*x(i,1) + 3*x(i,2) + 10*x(i,3)^2 + x(i,4) - x(i,5) - 282;
        g3 = 23*x(i,1) + x(i,2)^2 + 6*x(i,6)^2 - 8*x(i,7) - 196;
        g4 = 4*x(i,1)^2 + x(i,2)^2 - 3*x(i,1)*x(i,2) + 2*x(i,3)^2 + 5*x(i,6) - 11*x(i,7);
        
        if g1 > 0 || g2 > 0 || g3 > 0 || g4 > 0
            FitnV(i,1) = 0;
        end
    end
end