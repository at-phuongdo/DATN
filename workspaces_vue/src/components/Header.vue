<template>
 <div class="container">
  <b-navbar toggleable="md" type="dark">
    <b-navbar-brand href="#">
      <img src="http://www.myiconfinder.com/uploads/iconsets/256-256-8d0b15014c0fd4c1edaed92510d161db.png" alt="" height="80px">
      <span>COWORKER SPACES</span>
    </b-navbar-brand>
    <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
    <b-collapse is-nav id="nav_collapse">
      <b-navbar-nav class="ml-auto">
        <b-nav-item>
          <b-navbar-brand href="#">
            <span>Sign up </span>
          </b-navbar-brand>
        </b-nav-item>
        <b-nav-item>
          <b-button class="login-button">Login</b-button>
        </b-nav-item>
        <b-nav-item>
          <b-button class="add-button">Add new space</b-button>
        </b-nav-item>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</div>
</template>
<script>

</script>
<style scoped>
  span {
    color: #28a745;
  }
  .login-button {
    border: 2px solid #dedede;
    margin-right: 8px;
    padding: 6px 20px !important;
  }

  .add-button {
    background: #28a745;
    color: #fff;
    padding: 8px 20px !important;
    display: inline-block;
  }

  .add-button:hover {
    color: #fff;
  }

  .navbar-toggler {
    background-color: #28a745;
  }
</style>