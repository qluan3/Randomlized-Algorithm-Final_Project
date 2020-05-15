lmax = 1000;
kmin = 28;
kmax = 128;
result = zeros(101, 1000);
k_plot = zeros(1,101);
n = 1024;

crt = 0;
for k = kmin:kmax
    for l = 1:lmax
        data = [];
        % Initilaze the graph G(n, 1/2)
        r_list = [];
        c_list = [];
        G = zeros(n,n);
        G_r = zeros(n,n);
        
        for x = 1:n-1
            for y = x+1:n
                r = rand;
                    if r < 0.5
                        G(x, y) = 1;
                        G_r(x, y) = 1;
                    end
            end
        end
        
        % Check whether the graph is a clique
        for r = 1:n
            min = n - r;
            index = -1;
            %calculate degree
            degree = zeros(1,n);
            for x = 1:n
                for y = 1:n
                    degree(x) = degree(x) + G_r(x, y) + G_r(y, x);
                end
            end
            ava = find(degree > 0);
            for elem = 1:length(ava)
                if min > degree(ava(elem)) && degree(ava(elem)) > 0
                    min = degree(ava(elem));
                    index = ava(elem);
                end           
            end
            if (index < 0)
                size = n - r + 1;
                
                c_list = find(degree > 0);
                size_first = degree(c_list(1))/2;
                break
            end
            for a = 1:n
                 G_r(a, index) = 0;
                 G_r(index, a) = 0;
            end
            r_list = [r_list, index];
        end
        data_before = length(c_list);
        for a = 1: length(r_list)
            for b = 1:length(c_list)
                 if(G(r_list(a), c_list(b)) + G(c_list(b), r_list(a)) == 0)
                     break
                 end
            end
            if(b == length(c_list))
                c_list = [c_list, r_list(a)];
            end
        end
        data_l = length(c_list);
        size = data_l + size_first;
        data = [data, data_l];
 
    end
    result(kend - kmin + 1, l) = size;
    k_plot(kend - kmin + 1) = k_plot(kend - kmin + 1) + size/1000; 
end



%k_plot(kend - kmin + 1) = k_plot(kend - kmin + 1) + size;
%result(kend - kmin + 1, l) = size;



