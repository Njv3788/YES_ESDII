%%  testBench for Modify Script 

fid = fopen('../scripts/trajectoryScript.m','w');
if ( 0 == isa(cArg,'function_handle'))
    for i = 2:4
        fprintf(fid,"name = path+file(%d);\n",i);
        fprintf(fid,"[C,leftImage,~] = api.track(name,name);\n");
        if(showImages == true)
            fprintf(fid,"figure(imfig);imshow(leftImage);");
            fprintf(fid,"viscircles(C(1:2), 3,'EdgeColor','b');\n");
            fprintf(fid,"pause(1)\n");
        end
    end
else
    for i = 1:size(trajectory,1)/4
        fprintf(fid,"api = api.manageServer('camera',""runLink"",");
        fprintf(fid,"[%d,%d,%d,0,0,0],3);\n",trajectory(i,3),trajectory(i,1),-trajectory(i,2));
        fprintf(fid,"[C,leftImage,rightImage] = api.track(pose);\n");
        fprintf(fid, "traceFound(%d,:) = C;\n",i);
        if(showImages == true)
            fprintf(fid,"figure(imfig);\n");
            fprintf(fid,"subplot(1,2,1);imshow(leftImage);\n");
            fprintf(fid,"viscircles(C(1:2)', 3,'EdgeColor','b');\n");
            fprintf(fid,"subplot(1,2,2);imshow(rightImage);\n");
            fprintf(fid,"viscircles(C(3:4)', 3,'EdgeColor','b');\n");
        end
    end
end 
fclose(fid);