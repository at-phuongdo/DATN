<template>
  <div class="header-content">
    <div class="logout">
      <span @click="logOut">Log out</span>
    </div>
  </div>
</template>
<script>
  export default {
    methods: {
      logOut() {
        localStorage.removeItem('admin_token')
        this.$router.push('/admin')
      }
    }
  }
</script>
<style>
  .header-content {
    width: 85%;
    height: 50px;
    background-color: #cacdd0;
    float: right;
  }

  .logout {
    float: right;
    padding-right: 10px;
  }
</style>
