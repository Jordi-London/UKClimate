%%%%%%%%%
%%%%%%%%%
%The below code has the following missions:

%Part 1)Create maps which illustrate the spatial variability of UK climate for different climate variables.

%Part 2)Reveal which 1km^(2) grid within each UK basin is the most "climate
%representative".

%%%%%%%%%%%%%
% Climate Data can be downlaoded at: https://www.metoffice.gov.uk/research/climate/maps-and-data/data/haduk-grid/datasets
% Basins Shapefile can be downloaded at: https://ukclimateprojections-ui.metoffice.gov.uk/help/spatial_files

%For those in my research group data is also available here: "C:\Users\jordi\OneDrive - Imperial College London\Documents - Research
%Data - CI\Jordi\HADUK\1km"

%%%%%%%%%%
%%%%%%%%%%
%%
%Start here:
%Part 1:
clear
%Step 1: Import the climate variables we are interested in. The below are
%monthly averaged UK climate data over 30years for each 1km2 grid cell. 
filePr= "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\rainfall_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
fileTas ="C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\tas_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filesun = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\sun_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filewind ="C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\sfcWind_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filehurs = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\hurs_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filepsl = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\psl_hadukgrid_uk_1km_mon-30y_199101-202012.nc";

%Step 2:Have a look at what the variables are
%ncinfo(filePr) %info on the file structure 
%ncdisp(filepsl) %info on the variables contained in the file  

%Step 3: create variables
lat = ncread(filePr,'latitude');
lon =ncread(filePr,'longitude');%the lat lon is the same for all the files.
pr = ncread(filePr,'rainfall'); % Climate Variable 1 - Precipitation
tas =ncread(fileTas,'tas'); %Climate Variable 2 - temperature 
sun = ncread(filesun,'sun');% Climate Variable 3 - sunlight
wind = ncread(filewind,'sfcWind');% Climate Variable 4 - wind
hurs= ncread(filehurs,'hurs');% Climate Variable 5 - humidity 
psl= ncread(filepsl,'psl');% Climate Variable 6 - pressure

%step 4: Set coordinate refences
proj = projcrs(27700); %def proj - osg 36 - what UKCP18 uses. 
[xg, yg] = projfwd(proj, lat, lon); %change lat and long to proj x and y

% %Step 4.5: Creating plots:

Variable = sun; %Insert desired variable.Options:'Pr' 'tas' 'sun' 'wind' 'hurs' 'psl'

%Remember to change change 1)title 2)caxis for each variable

%%loop Start
M = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};

for i = 1:12
    sgtitle("Average duration of bright sunshine hours during each month,1991-2020")
    subplot(4,3,i);
    geoshow(lat, lon, Variable(:,:,i), 'displaytype', 'surface');
    title([M{i}])
    colorbar('vert','FontSize',12);
    %caxis([0 200]); %for Pr
    %caxis([0 20]);%for tas
    xlim([-9 2])
    ylim([49 60])
    xlabel('latitude')
    ylabel('longitude')
end
%loop End

%%%%%%%
%%%%%%%
%%%%%%%
%Part 2:
%Step 5: Loading basins shapefile
basins= "C:\Users\jordi\OneDrive - Imperial College London\Desktop\CurrentWork\Paper 2\QGIS\ukcp18-uk-land-river-hires.shp";

%Read = readgeotable("C:\Users\jordi\OneDrive - Imperial College London\Desktop\CurrentWork\Paper 2\QGIS\ukcp18-uk-land-river-hires.shp"); %table of what data is in the shapefile
basins = shaperead (basins); %loading the shapefile

%basinsr = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\CurrentWork\Paper 2\QGIS\UKSHP27700.shp";
%basinsr = shaperead (basinsr); %loading the shapefile

%mapshow(basins1) %have a look at shapefile

%Step 6: Get climate variables for each basin. 

    for i=1:numel(basins) %so for 1:23
        X = basins(i).X;
        Y = basins(i).Y; %lat and lon for basin i
        in = inpolygon(xg, yg, X, Y); % mask for basin i.
        %masked = in.*(pr(:,:,1));
        %prbasins(:,:,i) = masked; %we get 900x1450x23
            for m = 1:12 % for every month
                monthlypr = in.*(pr(:,:,m)); %1
                monthlypr(monthlypr==0)=NaN;
                monthlytas = in.*(tas(:,:,m));%2
                monthlytas(monthlytas==0)=NaN;
                monthlywind = in.*(wind(:,:,m));%3 - works
                monthlywind(monthlywind==0)=NaN;
                monthlyhurs = in.*(hurs(:,:,m));%4
                monthlyhurs(monthlyhurs==0)=NaN;
                monthlypsl = in.*(psl(:,:,m));%5
                monthlypsl(monthlypsl==0)=NaN;
                monthlysun = in.*(sun(:,:,m));%6
                monthlysun(monthlysun==0)=NaN;
                output(:,:,i,m,1) = monthlypr;
                output(:,:,i,m,2) = monthlytas;
                output(:,:,i,m,3) = monthlywind;
                output(:,:,i,m,4) = monthlyhurs;
                output(:,:,i,m,5) = monthlypsl;
                output(:,:,i,m,6) = monthlysun;
            end
    end 
    
    clearvars -except basins output 

 %%  
% Step 7: Get lat lon of most climate representative point.
T = struct2table(basins);
points = table();
points.region= T.geo_region;
points.lat = zeros(size(T.geo_region));
points.lon = zeros(size(T.geo_region));

E = zeros(size(output)); % 900x1450x23x12 - only for pr
for b =1:23

    for m = 1:12 % if b=1 output should be lat long for basin 1 %1:5 are climate variables.
        E(:,:,b,m) = abs(output(:,:,b,m,1)-mean(output(:,:,b,m,1),'all','omitnan'))/abs(mean(output(:,:,b,m,1),'all','omitnan')) + ...
        abs(output(:,:,b,m,2)-mean(output(:,:,b,m,2),'all','omitnan'))/abs(mean(output(:,:,b,m,2),'all','omitnan')) + ...
        abs(output(:,:,b,m,3)-mean(output(:,:,b,m,3),'all','omitnan'))/abs(mean(output(:,:,b,m,3),'all','omitnan')) + ...
        abs(output(:,:,b,m,4)-mean(output(:,:,b,m,4),'all','omitnan'))/abs(mean(output(:,:,b,m,4),'all','omitnan')) + ...
        abs(output(:,:,b,m,5)-mean(output(:,:,b,m,5),'all','omitnan'))/abs(mean(output(:,:,b,m,5),'all','omitnan')) + ...
        abs(output(:,:,b,m,6)-mean(output(:,:,b,m,6),'all','omitnan'))/abs(mean(output(:,:,b,m,6),'all','omitnan'));
    end

%E_all = sum(E, 4); %supposed to get E for each grid here. 
E_all = E(:,:,b,1)+E(:,:,b,2)+E(:,:,b,3)+E(:,:,b,4)+E(:,:,b,5)+E(:,:,b,6); %Overall E for each grid here. 

[i, j] = find(E_all == min(E_all, [], 'all', 'omitnan'));
lon = ncread("C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\psl_hadukgrid_uk_1km_mon-30y_199101-202012.nc", 'longitude');
lat = ncread("C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\psl_hadukgrid_uk_1km_mon-30y_199101-202012.nc", 'latitude');
%fprintf('most representative location Lon: %f, Lat: %f \n',lon(i, j),lat(i, j))

points.lat(b) = lat(i, j);
points.lon(b) = lon(i, j);
end 

%%%%%
%%%%%
%Step 8: Save results.
save('UKclimatebasins','points','points');

save('myFile.mat', 'output', '-v7.3') % if we want to save a file which is over 2GB

proj = projcrs(27700); %def proj - osg 36 - what UKCP18 uses. 
for i=1:23
    [lat, lon] = projinv(proj, basins(i).X, basins(i).Y); %change lat and long to proj x and y
    geoplot(lat,lon)
    hold on
end 
hold on 
geoscatter(points.lat,points.lon, "MarkerEdgeColor","k")
geolimits([48 60],[-5 5])

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%

%% Now time for a K-means Cluster ! 
% 
% clear
% 
% %Example below:
% cd 'C:\Users\jordi\OneDrive - Imperial College London\Desktop\Testing\23rdJan'
% 
% 
% M = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
% 
% for m = 1:12
%     A = arcgridread([M{m}, '.txt']);
%     T(:,:,m) = A;
%     X(:,m) = A(:);
% end
% 
% [C,I] = kmeans(X, 7);
% 
% imagesc(reshape(C,290,180));
