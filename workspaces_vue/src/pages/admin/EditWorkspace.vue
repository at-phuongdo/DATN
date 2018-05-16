<template>
  <div class="workspace-page" v-if="isLogin">
    <header-admin></header-admin>
    <edit-workspace></edit-workspace>
    <left-side-bar></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  import EditWorkspace from '../../components/admin/workspace/EditWorkspace.vue'
  import HeaderAdmin from '../../components/admin/Header.vue'

  export default {
    components: {
      LeftSideBar,
      EditWorkspace,
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
  .workspace-page {
    width: 100%;
    display: inline-block;
  }
</style>