<template>
  <div class="banner-page" v-if="isLogin">
    <banner></banner>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import Banner from '../../components/admin/banner/Banner.vue'
  export default {
    components: {
      LeftSideBar,
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
  .workspace-page {
    width: 100%;
    display: inline-block;
  }
</style>