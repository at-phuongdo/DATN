<template>
  <div>
    <b-modal id="editProfileModal" ref="editProfileModal" hide-footer hide-header>
      <div class="d-block text-center" v-if="currentUser">
        <b-form>
          <h1><strong>Edit your profile</strong></h1>
          <img class="avatar" :src="currentUser.avatar" style="width: 50%; height: 50%">
          <br>
          <b-row>
            <b-col sm="4">
              <span>User name</span>
            </b-col>
            <b-col sm="8">
              <b-form-input v-model="currentUser.username"></b-form-input>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>First name</span>
            </b-col>
            <b-col sm="8">
              <b-form-input v-model="currentUser.first_name"></b-form-input>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>Last name</span>
            </b-col>
            <b-col sm="8">
              <b-form-input v-model="currentUser.last_name"></b-form-input>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>Phone</span>
            </b-col>
            <b-col sm="8">
              <b-form-input v-model="currentUser.phone"></b-form-input>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>Birthday</span>
            </b-col>
            <b-col sm="8">
              <b-form-input v-model="currentUser.birthday" type="date"></b-form-input>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>Avatar</span>
            </b-col>
            <b-col sm="8">
              <div v-if="!image">
                <input type="file" @change="onFileChange">
              </div>
              <div v-else>
                <img :src="image" style="width: 100%; height: 100%;" />
                <button @click="removeImage">Remove image</button>
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="4">
              <span>Gender</span>
            </b-col>
            <b-col sm="8">
              <b-form-select v-model="currentUser.gender" :options="genderList" class="mb-3" />
            </b-col>
          </b-row>
        </b-form>
        <b-row align-h="center">
            <b-col sm="2">
              <circle4 v-show="loading"></circle4>
            </b-col>
          </b-row>
        <div class="button-control">
          <b-button variant="primary" @click="updateProfile">Save</b-button>
          <b-button variant="danger " @click="hideModal">Close</b-button>
        </div>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  import {Circle4} from 'vue-loading-spinner'
  export default {
    components: {
      Circle4
    },
    props: ['currentUser'],
    data() {
      return {
        file: null,
        newAvatar: null,
        avatarToUpload: [],
        image: '',
        status: '',
        genderList: [
        {value: 'male', text: 'male'},
        {value: 'female', text: 'female'}
        ],
        loading: false
      }
    },
    computed: {
      ...mapState({
        updateStatus:state => state.user.updateStatus,
        avatar:state => state.workspace.avatar
      })
    },
    watch: {
      updateStatus() {
        this.status = this.updateStatus
      },
      avatar() {
        this.newAvatar = this.avatar
        this.updateNewProfile()
      }
    },
    methods: {
      ...mapActions({
        'update': 'user/updateProfile',
        'uploadAvatar': 'workspace/uploadAvatar'
      }),
      hideModal() {
        this.$refs.editProfileModal.hide()
      },
      alert(options) {
        swal(options)
      },
      alertSuccess({
        title = "Success!", 
        text = "Update your profile success", 
        timer = 2000, 
        showConfirmationButton = false
      } = {}) {
        this.alert({
          title: title,
          text: text,
          timer: timer,
          button: showConfirmationButton,
          icon: 'success'
        });
      },
      onFileChange(e) {
        var files = e.target.files || e.dataTransfer.files;
        if (!files.length)
          return;
        this.createImage(files[0]);
      },
      createImage(file) {
        var image = new Image();
        var reader = new FileReader();
        var vm = this;

        reader.onload = (e) => {
          vm.image = e.target.result;
        };
        reader.readAsDataURL(file);
      },
      removeImage: function () {
        this.image = '';
      },
      updateProfile() {
        if (!!this.image) {
          this.loading = true
          this.uploadAvatar(this.image)
        } else {
          this.newAvatar = this.currentUser.avatar
          this.updateNewProfile()
        }
      },
      updateNewProfile() {
        let updateParams = {
          username: this.currentUser.username,
          first_name: this.currentUser.first_name,
          last_name: this.currentUser.last_name,
          phone: this.currentUser.phone,
          birthday: this.currentUser.birthday,
          avatar: this.newAvatar,
          gender: this.currentUser.gender
        }
        this.update(updateParams)
        this.loading = false
        this.hideModal()
        this.alertSuccess()
      }
    }
  }
</script>
<style scoped>
  .avatar {
    padding-bottom: 20px;
  }
</style>