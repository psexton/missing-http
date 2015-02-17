%ONLOAD Hook for loading Missing HTTP.

function onLoad()
  packagePath = fileparts(mfilename('fullpath'));
  addpath(fullfile(packagePath, 'matlab'));

  % Add the jar to the dynamic classpath
  jarPath = fullfile(packagePath, 'java', 'dist', 'missing-http.jar');
  if exist(jarPath, 'file') == 2
    javaaddpath(jarPath);
  else
    warning('missinghttp:onLoad:missingJavaComponent', ...
      ['Missing HTTP could not locate its Java component. Functionality will be ' ...
       'limited to non-existent.']);
  end

  % If a released version is being loaded, the directory containing release
  % information should be added to MATLAB's path to make sure the toolbox
  % properly shows up in the documentation and in the output of the ver command
  releaseInformationPath = fullfile(packagePath, 'missing-http');
  if exist(releaseInformationPath, 'dir') == 7
    addpath(releaseInformationPath);
  end
end
