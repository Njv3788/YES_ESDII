%% Function for the Algorithm
function center = MATLABmethod(testImageRGB,shift,calibrate)
    persistent Initial;
    type = "uint32";
    size_t = 1024;
    
    testImageGray = rgb2gray(testImageRGB); % convert to grayscale
    testImageGrayU32 = int32(testImageGray);% convert unit8 to uint32
    
    
    character = zeros(2,size_t,type);       % pre allocate vector
    x = sum(testImageGrayU32,1,"native");   % sum pixles in X
    y = sum(testImageGrayU32,2,"native")';  % sum pixles in y
                                            % pad vectors to size t
    character(1,:) = padarray(x,[0,size_t-size(x,2)],0,"post");
    character(2,:) = padarray(y,[0,size_t-size(y,2)],0,"post");
    
    normal = zeros(2,size_t,type);          % pre allocate normalized
                                            % bitshift into qformat u8.8 
    normal (1,:) = bitshift(character(1,:),shift(1));
    normal (2,:) = bitshift(character(2,:),shift(2));
    normal = int32(normal);                 % convert int32 to uint32
    
    if(calibrate == 1)
        Initial = normal;                   % Assign to calibrate 
        center = [];                        % blow away the Center 
    else                                    
        difference = abs(Initial - normal); % subtract from intial 
        [~,idx]= max(difference,[],2);      % find the index of peaks 
        center = unit16(idx);               % convert uint16 
    end
end