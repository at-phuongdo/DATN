<template>
  <div class="convenient-page" v-if="isLogin">
    <convenient></convenient>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import Convenient from '../../components/admin/convenient/ListConvenient.vue'
  export default {
    components: {
      LeftSideBar,
      Convenient
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