<template>
  <div class="login-form">
    <h2 class="text-center"><span class="decorate-span">Coworking space</span></h2>
    <b-row>
      <b-col md="3">Email</b-col>
      <b-col>
        <b-form-input v-model="email"></b-form-input>
      </b-col>
    </b-row>
    <br>
    <b-row>
      <b-col md="3">Password</b-col>
      <b-col>
        <b-form-input type="password" v-model="password"></b-form-input>
      </b-col>
    </b-row>
    <br>
    <b-row>
      <b-col>
        <b-btn variant="outline-success" class="login-btn" @click="loginAdmin">Login</b-btn>
      </b-col>
    </b-row>
  </div>
</template>
<script>
  import { mapActions, mapState } from 'vuex'
  export default {
    data() {
      return {
        email: '',
        password: ''
      }
    },
    computed: {
      ...mapState({
        admin:state => state.account.user,
        status:state => state.account.loginStatus
      })
    },
    methods: {
      ...mapActions({
        'login': 'account/login'
      }),

      loginAdmin() {
        this.login({'user': {
          'email': this.email,
          'password': this.password 
        }})
      }
    },
    watch: {
      admin() {
        localStorage.setItem('admin_token', this.admin.confirm_token)
        this.$router.push('/admin/dashboard')
      }
    }
  }
</script>
<style>
  @import url('https://fonts.googleapis.com/css?family=Pacifico');
  .login-form {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    -webkit-transform: translate(-50%, -50%);
    -moz-transform: translate(-50%, -50%);
    -o-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);

    border-radius: 5px;
    border: 1px solid #28a745;
    padding: 10px;
    z-index: 100;
  }

  .decorate-span {
    font-family: 'Pacifico', cursive;
    color: #28a745;
  }

  .login-btn {
    float: right;
  }
</style>