function Convection1DSetup

% parameters
N = 2; M = 80;
x1 = 0; x2 = 1;

% set mesh
[~, VX, ~, EToV] = Utilities.Mesh.MeshGen1D(x1, x2, M);
line = StdRegions.Line(N);
mesh = MultiRegions.RegionLine(line, EToV, VX);

% initial condition
var = Convection1DInit(mesh, x1, x2);
FinalTime = 2; % time
a = 1; % flow rate

% create output file
filename =['Convection1D_', num2str(N), '_', num2str(M)];
outfile = CreateNetcdf(filename, mesh, var);

% boundary condition
mesh.vmapP(1) = numel(mesh.x); mesh.vmapP(end) = 1;

% plot initial condition
plot(mesh.x(:), var(:), 'r-.'); hold on;

% solver
var = Convection1DSolver(mesh, var, FinalTime, a, outfile);

% postprocess
plot(mesh.x(:), var(:), '.', 'Markersize', 10);
ylim([-0.05, 1.1])
end% func

function outfile = CreateNetcdf(filename, mesh, var)

nx = numel(mesh.x);

time = Utilities.Netcdf.dimobj('time', 0); % unlimited dimensions
node = Utilities.Netcdf.dimobj('node', nx);

x = Utilities.Netcdf.varobj('loc', node, 'double');
t = Utilities.Netcdf.varobj('time', time, 'double');
var = Utilities.Netcdf.varobj('var', [node, time], 'double');

outfile = Utilities.Netcdf.fileobj(filename, [node, time], [x, t, var]);

% initialize output file
outfile.createFile;

% set vertex location value
outfile.putVarPart('loc', 0, nx, mesh.x);
end% func