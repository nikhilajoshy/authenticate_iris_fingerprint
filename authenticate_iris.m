
function [person,maximum]=authenticate_iris(watermark1) %iris authentication
matches=zeros(1,20);
votes=zeros(1,20);
D='C:\Users\nikhi\Desktop\iris_db\iris_db_final';
S=dir(fullfile(D,'*.bmp'));
for q=1:numel(S) %to read through every image in the iris database
    F=fullfile(D,S(q).name);
    check=imread(F);
    [c2 r2]=irisDetection(check);
    [norm2]=Unrolling( check , c2, r2, r2+35 ,360,35);
    watermark2=extract_features_iris(norm2);
   
    count=0;
    for i=1:length(watermark1) %hamming distance calculation
       if(watermark1(i)~=watermark2(i))
                count=count+1;
            end
        end
    
    if(count<702) %threshold is 702
        flag=0;
        temp=strsplit(S(q).name,'_');
        for t=1:20
            if(str2double(temp(1))==matches(t)) %if a previous match was already found
                votes(t)=votes(t)+1;
                flag=1;
                break;           
            end
        end
        if(flag==0) %if a previous match was not found
              for s=1:20
                    if(matches(s)==0)
                        pos=s; %find the next empty position
                        matches(pos)=str2double(temp(1));
                        votes(pos)=votes(pos)+1;
                        break;
                    end
                end
             
        end
             
                            
    %disp(count);
    %disp(S(q).name);
    %number=number+1;
    end
 
end

    maximum=max(votes); %get the person with the maximum number of votes.
    person=zeros(1,3);
    p=0;
    for a=1:20
        if(votes(a)==maximum)
            p=p+1;
            person(p)=matches(a);
            %break;       
        end
    end
 %   for h=1:3
  %      if(person(h)~=0)
   %         out=['Iris has matched with ',num2str(person),' having votes ',num2str(maximum),'%'];
    %        disp(out);
     %   end
    %end
%disp(number);
end


