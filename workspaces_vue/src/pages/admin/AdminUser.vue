<template>
  <div class="user-page" v-if="isLogin">
    <header-admin></header-admin>
    <user></user>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'
  import User from '../../components/admin/user/User.vue'
  export default {
    components: {
      LeftSideBar,
      HeaderAdmin,
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