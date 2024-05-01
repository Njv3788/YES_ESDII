function [x,y,z] = centriods2xyz(centriods,c,b,f,ps)
    
    d = (abs((centriods(:,1)-c(1))-(centriods(:,3)-c(3)))*ps); 
    z = (b .* f)./d;                                  
    x = (z .* (centriods(:,3)-c(3)) .* ps)./f;
    y = (z .* (centriods(:,4)-c(4)) .* ps)./f;
end

