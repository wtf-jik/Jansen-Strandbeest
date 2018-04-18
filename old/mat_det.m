%Done by Michael Jacob Mathew
function [sum]=mat_det(A)
    [m,n]=size(A);
    if(m~=n)
        disp('Determinant cannot be found');
    elseif(n==1)
        sum=A(1,1);
    elseif(n==2)
        sum=A(1,1)*A(2,2)-A(1,2)*A(2,1);
    else
        sum=0;
        for i=1:m
           if(mod(i,2)==0)
               p=2*i-1;
           else
               p=2*i;
           end
            B=minor_gen(A,m,i);
            sum=sum+(((-1)^p)*A(1,i))*B;
        end
    end
end