<template>
  <div class="user-page" v-if="isLogin">
    <user></user>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import User from '../../components/admin/user/User.vue'
  export default {
    components: {
      LeftSideBar,
      User
    },
    computed: {
      isLogin() {
        return localStorage.getItem("admin_token")
      }
    }
  }
</script>
<style>
  .user-page {
    width: 100%;
    display: inline-block;
  }
</style>