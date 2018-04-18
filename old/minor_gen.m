%Done by Michael Jacob Mathew
function [sum]=minor_gen(A,n,k)
    t1=0;B=[];
    for i=2:n
        t1=t1+1;t2=0;
        if(i==1)
            i=i+1;
        else
        for j=1:n       
            if(j==(k))
                j=j+1;
            else
             t2=t2+1;
            B(t1,t2)=A(i,j);
            end
        end
        end
    end
    f=size(B);
     if(f(1)==2)
         sum=B(1,1)*B(2,2)-B(1,2)*B(2,1);
     else
      sum=mat_det(B);
     end
end