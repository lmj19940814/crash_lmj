function [a,b,min_time]=order_time(crash_times,n)
 min_time=crash_times(1,2);
 a=1;
 b=2;
for i=1:n
    for j=1:(n+4)
        if crash_times(i,j)<min_time
            min_time=crash_times(i,j);
            a=i;
            b=j;
        end
    end
end