<template>
  <div class="dashboard-page" v-if="isLogin">
    <header-admin></header-admin>
    <left-side-bar v-if="isLogin"></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'
  export default {
    components: {
      LeftSideBar,
      HeaderAdmin
    },
    computed: {
      isLogin() {
        return localStorage.getItem("admin_token")
      }
    }
  }
</script>
<style>
  .dashboard-page {
    width: 100%;
    display: inline-block;
  }
</style>