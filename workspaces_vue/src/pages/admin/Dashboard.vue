<template>
  <div>
    <left-side-bar v-if="isLogin"></left-side-bar>
  </div>
</template>
<script>
  import LeftSideBar from '../../components/admin/LeftSideBar.vue'
  export default {
    components: {
      LeftSideBar
    },
    computed: {
      isLogin() {
        return localStorage.getItem("admin_token")
      }
    }
  }
</script>