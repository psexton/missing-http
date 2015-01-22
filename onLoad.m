%ONLOAD Script for loading MissingHTTP.
function onLoad()
  packagePath = fileparts(mfilename('fullpath'));
  addpath(fullfile(packagePath, 'matlab'));

  % Add the jar to the dynamic classpath
  jarPath = fullfile(packagePath, 'java', 'dist', 'missing-http.jar');
  if exist(jarPath, 'file') == 2
    javaaddpath(jarPath);
  else
    warning('missinghttp:onLoad:missingJavaComponent', ...
      ['MissingHTTP could not locate its Java component. Functionality will be ' ...
       'limited to non-existent.']);
  end
end
