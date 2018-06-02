<template>
  <div class="convenient-page" v-if="isLogin">
  <header-admin></header-admin>
    <convenient></convenient>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import Convenient from '../../components/admin/convenient/ListConvenient.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'

  export default {
    components: {
      LeftSideBar,
      Convenient,
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
  .convenient-page {
    width: 100%;
    display: inline-block;
  }
</style>