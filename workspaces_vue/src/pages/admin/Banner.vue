<template>
  <div class="banner-page" v-if="isLogin">
    <header-admin></header-admin>
    <banner></banner>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import Banner from '../../components/admin/banner/Banner.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'
  export default {
    components: {
      LeftSideBar,
      HeaderAdmin,
      Banner
    },
    computed: {
      isLogin() {
        return localStorage.getItem("admin_token")
      }
    }
  }
</script>
<style>
  .banner-page {
    width: 100%;
    display: inline-block;
  }
</style>