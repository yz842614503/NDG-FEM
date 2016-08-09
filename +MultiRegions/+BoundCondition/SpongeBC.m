classdef SpongeBC
%SONGEBC Sponge boundary condition.
%   Detailed explanation goes here

properties
    BCfile          % boundary condition files
    nBV             % number of boundary vertex
    time            % time vector
    nSpE            % number of sponge element
    SpEToE          % sponge element to computation elements
    SpEToBV         % sponge element to boundary vertex
    sigma_max       % sigma max
end

methods
    function obj = SpongeBC(BCflag, fileName)
        % boundary netcdf file
        obj.BCfile = Utilities.PostProcess.ResultFile(fileName);
        % get nBV
        ncid  = netcdf.open(fileName, 'NC_NOWRITE');
        dimid = netcdf.inqDimID(ncid, 'nBV'); % the dimension name must be nBV
        [~, obj.nBV] = netcdf.inqDim(ncid, dimid);
        % get time
        obj.time = obj.BCfile.GetVarData('time');
        % the connection between sponge element to computation element
        obj.nSpE = sum(BCflag);
        obj.SpEToE = find(BCflag);
    end% func
end
    
end
