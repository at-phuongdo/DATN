import injector from 'vue-inject';

import WorkspaceService from './workspace.service.js'

injector.service('workspaceService', function () { 
  return WorkspaceService 
});