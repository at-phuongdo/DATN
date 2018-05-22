<template>
  <div class="dashboard-page" v-if="isLogin">
    <header-admin></header-admin>
    <left-side-bar v-if="isLogin"></left-side-bar>
    <dashboard></dashboard>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'
  import Dashboard from '../../components/admin/Dashboard.vue'
  export default {
    components: {
      LeftSideBar,
      HeaderAdmin,
      Dashboard
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