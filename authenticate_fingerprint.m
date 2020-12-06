function [person,maximum]=authenticate_fingerprint(watermark1)

A='C:\Users\nikhi\Desktop\project\check\final db\fingerprint_db_final' %assigning path of fingerprint database to A
B=dir(fullfile(A,'*.bmp')); %retrieving all bmp files in A to B
 matches=zeros(1,100); %initialising vector matches of size[1,100] with zeroes to store matching persons
   votes=zeros(1,100); %initialising vector votes of size[1,100] with zeroes to store vote count of matching persons
   C=0
   for q=1:numel(B)
    G=fullfile(A,B(q).name); %G contains the full filename of each image in B
    check=imread(G); %read image from database
    op=auth1(watermark1,check); %getting the fingerprint match score as op
        if op>50 %checking if the match score is greater than threshold    
        flag=0;
        temp=strsplit(B(q).name,'_'); %split the name of image in database
        for t=1:100
            if(str2double(temp(1))==matches(t)) %check if name of person already present in vector matches
                votes(t)=votes(t)+1;  %increment the vote count of corresponding person
                flag=1;
                break;           
            end
        end
        if(flag==0)
              for s=1:100 
                    if(matches(s)==0) %finding index (pos) in matches with value 0 to enter the matching person's name
                        pos=s;
                        matches(pos)=str2double(temp(1)); %entering the matching person's name into matches[]
                        votes(pos)=votes(pos)+1; %incrementing the vote count of corresponding person by 1
                        break;
                    end
                end
             
        end
    end
 
end

    maximum=max(votes); %finding the max value in the vector votes[]
    person=zeros(1,3);
    p=0;
    for a=1:100
        if(votes(a)==maximum) %finding the index in votes[] with maximum value
            p=p+1;
            person(p)=matches(a); %assigning the authenticated person as the person having the max votes
                       
        end
    end
    %{
    for h=1:3
        if(person(h)~=0)
            out=['It has matched with ',num2str(person(h)),'with votes:',num2str(maximum)];
            disp(out);
            saveOutput('output',out)
        end
    end
    %}
%disp(number);
end
