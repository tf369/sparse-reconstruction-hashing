function Dh = hammingDist_sparse(B, th)

% loop-up table:
bit_in_char = uint16([...
    0 1 1 2 1 2 2 3 1 2 2 3 2 3 3 4 1 2 2 3 2 3 ...
    3 4 2 3 3 4 3 4 4 5 1 2 2 3 2 3 3 4 2 3 3 4 ...
    3 4 4 5 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 1 2 ...
    2 3 2 3 3 4 2 3 3 4 3 4 4 5 2 3 3 4 3 4 4 5 ...
    3 4 4 5 4 5 5 6 2 3 3 4 3 4 4 5 3 4 4 5 4 5 ...
    5 6 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 1 2 2 3 ...
    2 3 3 4 2 3 3 4 3 4 4 5 2 3 3 4 3 4 4 5 3 4 ...
    4 5 4 5 5 6 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 ...
    3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 2 3 3 4 3 4 ...
    4 5 3 4 4 5 4 5 5 6 3 4 4 5 4 5 5 6 4 5 5 6 ...
    5 6 6 7 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 4 5 ...
    5 6 5 6 6 7 5 6 6 7 6 7 7 8]);

[n, nwords] = size(B);

Dh = sparse([n n]);
for j = 1:n
    tmp=zeros(1,n,'uint16');
    for k=1:nwords
        y = bitxor(B(j,k),B(:,k));
        tmp=tmp+bit_in_char(y+1);
%         Dh(j,:) = Dh(j,:) + bit_in_char(y+1);
    end
    I=find(tmp<=th);
    if(~isempty(I))
        Dh(j,I)=tmp(I);
    end
end

