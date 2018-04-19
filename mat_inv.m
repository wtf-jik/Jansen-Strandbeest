function b = mat_inv(a)
% Find dimensions of input matrix
[m,n] = size(a);
% Target identity matrix to be transformed into the output 
% inverse matrix
b = eye(m);

%The following code actually performs the matrix inversion by working
% on each element of the input 
for j = 1 : m
    for i = j : m
        if a(i,j) ~= 0
            for k = 1 : m
                s = a(j,k); a(j,k) = a(i,k); a(i,k) = s;
                s = b(j,k); b(j,k) = b(i,k); b(i,k) = s;
            end
            t = 1/a(j,j);
            for k = 1 : m
                a(j,k) = t * a(j,k);
                b(j,k) = t * b(j,k);
            end
            for L = 1 : m
                if L ~= j
                    t = -a(L,j);
                    for k = 1 : m
                        a(L,k) = a(L,k) + t * a(j,k);
                        b(L,k) = b(L,k) + t * b(j,k);
                    end
                end
            end            
        end
        break
    end
end
% Show the evolution of the input matrix, so that we can 
% confirm that it became an identity matrix.
