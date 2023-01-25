%%Reading in the data:
%info on variables:
%https://www.metoffice.gov.uk/research/climate/maps-and-data/data/haduk-grid/datasets 
%Data also available here:
%"C:\Users\jordi\OneDrive - Imperial College London\Documents - Research
%Data - CI\Jordi\HADUK\1km"
%%%%%
%%%%%
%Start here:
clear
%Step 1: Import the variables we are interested in
%here we are workign with monthly averaged UK climate data (30 years)
filePr= "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\rainfall_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
fileTas ="C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\tas_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filesun = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\sun_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filewind ="C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\sfcWind_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filehurs = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\hurs_hadukgrid_uk_1km_mon-30y_199101-202012.nc";
filepsl = "C:\Users\jordi\OneDrive - Imperial College London\Desktop\Data\HADUK\1km\psl_hadukgrid_uk_1km_mon-30y_199101-202012.nc";

%Step 2: Have a look at what the variables show
ncinfo(filePr) %info on the file structure 
ncdisp(filepsl) %info on the variables contained in the file  

%Step 3: create variables
lat = ncread(filePr,'latitude');
lon =ncread(filePr,'longitude');%this should be the same for all the files so we only do it once.
Pr = ncread(filePr,'rainfall');
tas =ncread(fileTas,'tas');
sun = ncread(filesun,'sun');
wind = ncread(filewind,'sfcWind');
hurs= ncread(filehurs,'hurs');
psl= ncread(filepsl,'psl');

%Quick note: We have a 3D array (e.g.Pr is 900x150x12) so we need to split the third
%dimension(12) which corresponds to each month, e.g 1 here would be Jan, 2
%would be feb...
%%%%%%%%%%%%%
%%%%%%%%%%%%%
%Step 4: Create Plots:
%%

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
%%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%% If we want to use monthly colorbar axis scales or histogram bins:
sgtitle("UK Monthly Averaged Rainfall (mm) over 30yr")
%Jan
subplot(4, 3, 1); %we create a 4*3 array and then plot on the first box.
geoshow(lat, lon, sun(:,:,1), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
%caxis([0 200]); %we can play with the color bar scale here... - perhaps bins would be more appropriate...
title('Jan Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')
%Feb
subplot(4, 3, 2); %we create a 4*3 array and then plot on the first box.
geoshow(lat, lon, Pr(:,:,2), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Feb');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')
%March
subplot(4, 3, 3);
geoshow(lat, lon, Pr(:,:,3), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Mar Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%April
subplot(4, 3, 4);
geoshow(lat, lon, Pr(:,:,4), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Apr Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')
%May
subplot(4, 3, 5);
geoshow(lat, lon, Pr(:,:,5), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('May Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%June
subplot(4, 3, 6);
geoshow(lat, lon, Pr(:,:,6), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Jun Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')
%July
subplot(4, 3, 7);
geoshow(lat, lon, Pr(:,:,7), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Jul Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%August 
subplot(4, 3, 8);
geoshow(lat, lon, Pr(:,:,8), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Aug Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%September
subplot(4, 3, 9);
geoshow(lat, lon, Pr(:,:,9), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Sept Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%October
subplot(4, 3, 10);
geoshow(lat, lon, Pr(:,:,10), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Oct Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%November
subplot(4, 3, 11);
geoshow(lat, lon, Pr(:,:,11), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Nov Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%December
subplot(4, 3, 12);
geoshow(lat, lon, Pr(:,:,12), 'displaytype', 'surface');
colorbar('vert','FontSize',12);
caxis([0 200]);
title('Dec Pr (mm)');
xlim([-9 2])
ylim([49 60])
xlabel('latitude')
ylabel('longitude')

%% %% Monthly Temperature
%Jan
subplot(4, 3, 1);
mymap=pcolor(latitude,longitude,Jantas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Jan Avg Temp (C) 1960-2020')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%Feb
subplot(4, 3, 2);
mymap=pcolor(latitude,longitude,Febtas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Feb')
%caxis([0 250]) %to set the colour gradient scale 
xlim([0 700000]) %setting the lower and upper limits of the graph axis
ylim([0 1300000])

%March
subplot(4, 3, 3);
mymap=pcolor(latitude,longitude,Martas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Mar')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%April
subplot(4, 3, 4);
mymap=pcolor(latitude,longitude,Aprtas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Apr')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])
%May
subplot(4, 3, 5);
mymap=pcolor(latitude,longitude,Maytas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('May')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])
%June
subplot(4, 3, 6);
mymap=pcolor(latitude,longitude,Juntas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Jun')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%July
subplot(4, 3, 7);
mymap=pcolor(latitude,longitude,Jultas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Jul')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%August 
subplot(4, 3, 8);
mymap=pcolor(latitude,longitude,Augtas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Aug')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%September
subplot(4, 3, 9);
mymap=pcolor(latitude,longitude,Septas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Sep')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%October
subplot(4, 3, 10);
mymap=pcolor(latitude,longitude,Octtas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Oct')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])
%November
subplot(4, 3, 11);
mymap=pcolor(latitude,longitude,Novtas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Nov')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])

%December
subplot(4, 3, 12);
mymap=pcolor(latitude,longitude,Dectas)
mymap.EdgeAlpha = 0;
colorbar
xlabel('latitude')
ylabel('longitude')
title('Dec')
%caxis([0 250])
xlim([0 700000])
ylim([0 1300000])


%% Now time for a K-means Cluster ! 

clear

%Example below:
cd 'C:\Users\jordi\OneDrive - Imperial College London\Desktop\Testing\23rdJan'


M = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};

for m = 1:12
    A = arcgridread([M{m}, '.txt']);
    T(:,:,m) = A;
    X(:,m) = A(:);
end

[C,I] = kmeans(X, 7);

imagesc(reshape(C,290,180));

%% seeing how the above works. 

TD = readmatrix("C:\Users\jordi\Downloads\Jan.txt");

TD  = arcgridread("Jan.txt");

%testing the above with m=1
%first loop
m=1;

A = arcgridread([M{m}, '.txt']);
T(:,:,m) = A;
X(:,m) = A(:);
%second loop
m=2;

A = arcgridread([M{m}, '.txt']);
T(:,:,m) = A;
X(:,m) = A(:);

%% Next steps:

%1  %Separate the above climate variables into the 23 river basin regions of
%the UK - I have this shapefile somewhere. 

%2 : Use some sort of weighting ? to find pixel areas which are most
%representative within each river basin ? can then run this as a loop. 





