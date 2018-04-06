import injector from 'vue-inject';

import UploadPhotoService from './uploadPhoto.service.js'

injector.service('uploadPhotoService', function () { 
  return UploadPhotoService 
});