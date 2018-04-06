<template>
  <div>
    <div class="workspace-avatar">
      <h4>Insert workspace's avatar(only one)</h4>
      <label class="input-image">
        <input type="file" ref="avatarRefs" @change="previewAvatar" style="display: none" accept=".jpg, .jpeg, .png" required>
        Select your avatar
      </label>
      <div v-if="avatarToUpload.length>0">
        <img  :src="avatarToUpload"/>
        <span class="fa fa-times-circle" @click="removeAvatar()"></span>
      </div>
    </div>
    <div class="workspace-photos">
      <h4>Insert your workspace's photos(5 photos)</h4>
      <label class="input-image">
        <input type="file" ref="photoRefs" @change="previewPhotos" multiple style="display: none" accept=".jpg, .jpeg, .png">
        Select photos
      </label>
      <div class="photos-list" v-if="photoToShow.length>0">
        <div v-for="n in photoToShow.length" :key="n">
          <img  :src="photoToUpload[n-1]"/>
          <span class="fa fa-times-circle" @click="removePhoto(n)"></span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    dependencies : ['uploadPhotoService'],
    created() {
      this.uploadPhotoService.uploadPhotos = this.upload;
    },
    data() {
      return {
        avatarToUpload: [],
        avatarToShow: [],
        photoToShow: [],
        photoToUpload: [],
        allPhoto: []
      }
    },
    computed: {
      ...mapState({
        photosURL: state => state.workspace.listPhotos
      })
    },
    methods: {
      ...mapActions({
        uploadAvatarCloudinary: 'workspace/uploadAvatar',
        uploadPhotosCloudinary: 'workspace/uploadPhotos'
      }),
      previewAvatar() {
        var avatarInput = this.$refs.avatarRefs.files[0]
        this.avatarToShow.push(avatarInput)
        var reader = new FileReader()

        reader.onload = (e) => {
          this.avatarToUpload.push(e.target.result)
        }
        reader.readAsDataURL(this.avatarToShow[0])
      },
      previewPhotos() {
        var myfile = this.$refs.photoRefs
        var files = this.$refs.photoRefs.files
        for (var i = 0; i < files.length; i++) {
          this.photoToShow.push(files[i])
          this.createImage(myfile, files[i]);
        }
      },
      createImage(item, file) {
        var reader = new FileReader()

        reader.onload = (e) => {
          this.photoToUpload.push(e.target.result)
        };
        reader.readAsDataURL(file)
      },
      removeAvatar: function() {
        this.avatarToUpload = []
        this.avatarToShow = []
      },
      removePhoto: function (n) {
        this.photoToUpload.splice(n-1,1)
        this.photoToShow.splice(n-1,1)
      },
      upload: function() {
        this.allPhoto.push(this.avatarToUpload[0])
        for (var i = 0; i < this.photoToUpload.length; i++) {
          this.allPhoto.push(this.photoToUpload[i])
        }
        this.uploadPhotos()
      },
      uploadPhotos: function() {
        this.uploadPhotosCloudinary(this.allPhoto)
      }
    },
    watch: {
      photosURL: function() {
        this.$emit('getPhotos', this.photosURL)
      }
    }
  }
</script>
<style scoped>
  .image-upload {
    border: 1px solid;
    height: 400px;
  }

  img {
    width: 80%;
  }

  .input-image {
    width: 100%;
    height: 100px;
    border: 1px solid;
  }

  .photos-list {
    float: left;
  }
</style>
