T=zeros(1000,1000,1000);
for i=1:1000
    for j=1:1000
        for k=1:1000
            if(i*i+j*j<62500)
                T(i,j,k)=T(i,j,k)+1;
            end
            if(i*i+k*k<62500)
                T(i,j,k)=T(i,j,k)+1;
            end
            if(k*k+j*j<62500)
                T(i,j,k)=T(i,j,k)+1;
            end
        end
    end
end
figure;
[x,y,z] = meshgrid(1:1000,1:1000,1:1000);
scatter3(x(:),y(:),z(:),5,T(:))