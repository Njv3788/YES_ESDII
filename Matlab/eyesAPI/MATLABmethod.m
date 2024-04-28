%% Function for the Algorithm
function center = MATLABmethod(calibrate,leftImageRGB,rightImageRGB,shift)
    persistent initial;
    type = "uint32";
    size_t = 1024;
  
    leftImageGray = rgb2gray(leftImageRGB);    % convert to grayscale
    rightImageGray = rgb2gray(rightImageRGB);  % convert to grayscale
    leftImageGrayU32 = uint32(leftImageGray);  % convert unit8 to uint32
    rightImageGrayU32 = uint32(rightImageGray);% convert unit8 to uint32
    
    character = zeros(4,size_t,type);           % pre allocate vector
    xl = sum(leftImageGrayU32,1,"native");      % sum pixles in X of Left
    yl = sum(leftImageGrayU32,2,"native")';     % sum pixles in Y of Left
    xr = sum(rightImageGrayU32,1,"native");     % sum pixles in X of Right
    yr = sum(rightImageGrayU32,2,"native")';    % sum pixles in Y of Right
                                                % pad vectors to size t
    character(1,:) = padarray(xl,[0,size_t-size(xl,2)],0,"post");
    character(2,:) = padarray(yl,[0,size_t-size(yl,2)],0,"post");
    character(3,:) = padarray(xr,[0,size_t-size(xr,2)],0,"post");
    character(4,:) = padarray(yr,[0,size_t-size(yr,2)],0,"post");
    
    normal = zeros(4,size_t,type);              % pre allocate normalized
                                                % bitshift into qformat u8.8 
    normal (1,:) = bitshift(character(1,:),shift(1));
    normal (2,:) = bitshift(character(2,:),shift(2));
    normal (3,:) = bitshift(character(3,:),shift(1));
    normal (4,:) = bitshift(character(4,:),shift(2));
    normal = int32(normal);                     % convert int32 to uint32
        
    if(calibrate == 1)  
        initial = normal;                       % Assign to calibrate 
        center = [];                            % blow away the Center 
    else                                        
        difference = abs(initial - normal);     % subtract from intial
        [~,idx]= max(difference,[],2);          % find the index of peaks
                                                % convert uint16
        center = uint16([idx(1) idx(3);idx(2) idx(4)]);           
    end
end