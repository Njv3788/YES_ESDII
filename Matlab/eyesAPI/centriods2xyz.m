function C = centriods2xyz(centriods)
    f = 20.78461;
    b = 4000;
    ps = .04785;

    d = (abs((centriods(:,1)-752/2)-(centriods(:,3)-752/2))*ps); 
    y = (b .* f)./d;                                  
    z = (y .* (centriods(:,3)-752/2) .* ps)./f;
    x = (y .* (centriods(:,4)-480/2) .* ps)./f;

    Z = -z/1000;
    X = -x/1000;
    Y = -((y)/1000-20);

    C = [X,Y,Z];
end

