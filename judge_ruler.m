function judge_initialization=judge_ruler(handle,n,r)
judge_initialization=1;
for i=1:(n-1)
    for j=(i+1):n
        if ((handle(1,i)-handle(1,j))^2+(handle(1,i)-handle(1,j))^2)^0.5<2*r
           judge_initialization=0;
           break;
        end
    end
end