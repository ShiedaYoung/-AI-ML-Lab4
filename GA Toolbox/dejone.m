function y = dejone(x)

for i=1:size(x,1)
    y(i,:)=sum(x(i,:).^2);
end

