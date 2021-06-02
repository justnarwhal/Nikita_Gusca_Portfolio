ncfile = 'o3_surface_20180701000000.nc';

clc;

a = 1; %% variable for the main menu if statement
b = 1; %% variable for the colour blind menu if statement

if (a == 1) %% basic menu code, using a variable for an if statement
    modelchoice = input('Please choose one of the options: 1.Eurad, 2. Mocage, 3. Lotoseuros, 4. Chimere, 5. Ensemble, 6. Silam, 7. Emep, 8. Match \n \n'); %% options that are shown in the menu. \n \n");
    if modelchoice == 1
        titlechoice = 'eurad_ozone';
        ozone_choice = ('eurad_ozone');
    elseif modelchoice == 2
        titlechoice = 'mocage_ozone';
        ozone_choice = ('mocage_ozone');
    elseif modelchoice == 3
        titlechoice = 'lotoseuros_ozone';
        ozone_choice = ('lotoseuros_ozone');
    elseif modelchoice == 4
        titlechoice = 'chimere_ozone';
        ozone_choice = ('chimere_ozone');
    elseif modelchoice == 5
        titlechoice = 'ensemble_ozone';
        ozone_choice = ('ensemble_ozone');
    elseif modelchoice == 6
        titlechoice = 'silam_ozone';
        ozone_choice = ('silam_ozone');
    elseif modelchoice == 7
        titlechoice = 'emep_ozone';
        ozone_choice = ('emep_ozone');
    elseif modelchoice == 8
        titlechoice = 'match_ozone';
        ozone_choice = ('match_ozone');
    end
    a = 0;
end

clc;

o = ncread(ncfile, ozone_choice);                   %% starts a model coresponding to the users input in the main menu
t = ncread(ncfile,'hour');                          %% variable for time
lon = ncread(ncfile,'lon');                         %% variable for longitude
lat = ncread(ncfile,'lat');                         %% variable for latitude
[X,Y] = meshgrid(lon,lat) ;                         %% using MATLAB meshgrid command
ct = length(t) ;                                    %% variable for time in a colourblind menu
figure('Name', titlechoice,'NumberTitle','off');    %% formating the information
set(gcf, 'Position', get(0, 'Screensize'));         %% enables fullscreen
clf; 

for i = 1:ct %% loop which will go for 24 times to show how the ozone level changes.
    clf;
    map = pcolor(X,Y,o(:,:,i)');         %% enables the data to be shown on the map
    ylabel('Longitude')                  %% shows the name of the Y Axis on the map
    xlabel('Latitude')                   %% shows the name of the X Axis on the map
    if (b == 1)                          %% basic menu code for the colourblind menu using an if statement
        info = menu('Color Blind Options', 'Non Color blind', 'Deutan Color Blidness', 'Protan Color Blindness','Tritan Color Blidness','Achromatopsia Color Blindness');
        if info == 1
            colormap default;  %% used colormaping options provided by MATLAB to change the color of the data
        elseif info == 2
            colormap hot;      %% colormap without any green
        elseif info == 3
            colormap parula;   %% colormap without any red
        elseif info == 4
            colormap pink;     %% colormap without any blue or yellow
        elseif info == 5
            colormap gray;     %% black and white colormap
        end
        b = 0;
    end
    clr = colorbar;            %% enables a colorbar on the right from the map, which shows the ozone levels
    clr.Label.String = 'Ozone Levels'; %% Title of the colorbar
    load coast;                %% loads the coast
    hold on;
    C  = load('coast');
    plot(C.long,C.lat,'k')     %% plots the map
    shading interp ;           %% adds shading 
    title(sprintf('Time : %f',t(i))) %% shows the time above the map
    pause(0.1)                 %% Pause which shows the data every hour
end