function [x,y,z] = centriods2xyz(centriods,c,b,f,ps)
    
    d = (abs((centriods(:,1)-c(1))-(centriods(:,3)-c(3)))*ps); 
    z = (b .* f)./d;                                  
    x = (z .* (centriods(:,1)-c(1)) .* ps)./f;
    y = (z .* (centriods(:,2)-c(2)) .* ps)./f;
end

