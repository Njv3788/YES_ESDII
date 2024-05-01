function revData = zynqLink(TCP_Handle,cmd,inData)
    if(size(TCP_Handle,1) == 0)
       revData = intmax('int16');
       return;
    end

    write(TCP_Handle,'0');
    flush(TCP_Handle);
    
    write(TCP_Handle,inData(:))
    [~] = read(TCP_Handle,1);
    
    switch(cmd)
        case 0
            write(TCP_Handle,'2')
            flush(TCP_Handle);
        case 1
            write(TCP_Handle,'1');
            flush(TCP_Handle); 
    end
    revData = read(TCP_Handle,4,'uint16');
end 

