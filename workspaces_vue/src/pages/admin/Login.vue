<template>
  <div>
    <login></login>
  </div>
</template>
<script>
  import Login from '../../components/admin/Login.vue'
  export default {
    components: {
      Login
    },
    created() {
      if (localStorage.getItem("admin_token")) {
        this.$router.push('/admin-dashboard')
      }
    }
  }
</script>