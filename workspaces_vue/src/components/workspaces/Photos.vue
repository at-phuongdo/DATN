<template>
  <div>
    <div class="workspace-avatar">
      <h4>Insert workspace's avatar(only one)</h4>
      <label class="input-image">
        <input type="file" ref="avatarRefs" @change="previewAvatar" style="display: none">
        Select your avatar
      </label>
      <div v-if="avatar.length>0">
        <img  :src="avatar"/>
        <span class="fa fa-times-circle" @click="removeAvatar()"></span>
      </div>
    </div>
    <div class="workspace-photos">
      <h4>Insert your workspace's photos(5 photos)</h4>
      <label class="input-image">
        <input type="file" ref="photoRefs" @change="previewPhotos" multiple style="display: none">
        Select photos
      </label>
      <div class="photos-list" v-if="photosArr.length>0">
        <div v-for="n in photosArr.length" :key="n">
          <img  :src="listPhotos[n-1]"/>
          <span class="fa fa-times-circle" @click="removePhoto(n)"></span>
        </div>
      </div>
    </div>
    <button type="" @click="upload">OK</button>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    data() {
      return {
        avatar: [],
        avatarArr: [],
        photosArr: [],
        listPhotos: []
      }
    },
    methods: {
      ...mapActions({
        uploadCloudinary: 'workspace/uploadImage'
      }),
      previewAvatar() {
        var avatarInput = this.$refs.avatarRefs.files[0]
        this.avatarArr.push(avatarInput)
        var reader = new FileReader()

        reader.onload = (e) => {
          this.avatar.push(e.target.result)
        }
        console.log(this.avatarArr[0])
        reader.readAsDataURL(this.avatarArr[0])
      },
      previewPhotos() {
        var myfile = this.$refs.photoRefs
        var files = this.$refs.photoRefs.files
        console.log(files)
        for (var i = 0; i < files.length; i++) {
          this.photosArr.push(files[i])
          this.createImage(myfile, files[i]);
        }
      },
      createImage(item, file) {
        var reader = new FileReader()

        reader.onload = (e) => {
          this.listPhotos.push(e.target.result)
        };
        reader.readAsDataURL(file)
      },
      removeAvatar: function() {
        this.avatar = []
        this.avatarArr = []
      },
      removePhoto: function (n) {
        this.listPhotos.splice(n-1,1)
        this.photosArr.splice(n-1,1)
      },
      upload: function() {
        var formData = new FormData();
        formData.append('file', this.avatar[0])
        formData.append('upload_preset', 'kbtjckge')
        this.uploadCloudinary(formData)
      }
    },
    watch: {
      avatar: function() {
        this.$emit('getAvatar', this.avatar)
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