<template>
  <div>
  <b-modal id="signUpModal" ref= "signUpModal" hide-footer hide-header>
    <div class="d-block text-center">
      <b-form>
        <h1><strong>SIGN UP</strong></h1>
        <h1><span class="decorate-span">Who are you?</span></h1>
        <b-row>
          <b-col sm="1"><span class="fa fa-user"></span></b-col>
          <b-col sm="11">
            <b-form-input type="text" v-model="username" placeholder="Username"></b-form-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col sm="1"><span class="fa fa-envelope"></span></b-col>
          <b-col sm="11">
            <b-form-input type="email" v-model="email" placeholder="Email"></b-form-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col sm="1"><span class="fa fa-lock"></span></b-col>
          <b-col sm="11">
            <b-form-input type="password" v-model="password" placeholder="Password"></b-form-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col sm="1"><span class="fa fa-lock"></span></b-col>
          <b-col sm="11">
            <b-form-input type="password" v-model="passwordConfirm" placeholder="Password Confirm"></b-form-input>
          </b-col>
        </b-row>
         <b-row>
          <b-col sm="1"><span class="fa fa-lock"></span></b-col>
          <b-col sm="11">
            <b-form-input type="text" v-model="firstname" placeholder="Firstname"></b-form-input>
          </b-col>
        </b-row>
        <b-button @click="addUser" variant="primary" >Sign up</b-button>
        <b-btn variant="danger"  @click="hideModal" >Close</b-btn>
      </b-form>
      <br>
      <p><i>Already have account? Login <router-link v-on:click.native="logIn" to="/">here</router-link></i></p>
    </div>
  </b-modal>
  <login-modal></login-modal>
  </div>
</template>
<script>
  import LoginModal from './LoginModal.vue'
  export default {
    components: {
      'login-modal' : LoginModal
    },
    data() {
      return {
        username: '',
        email: '',
        password: '',
        passwordConfirm: '',
        firstname: '',
        newUser: {}
      }
    }, 
    methods: {
      hideModal:function() {
        this.$refs.signUpModal.hide()
      },
      addUser:function() {
        this.newUser.username = this.username
        this.newUser.email = this.email
        this.newUser.password = this.password
        this.newUser.firstname = this.firstname
        this.$store.dispatch('addUser', this.newUser)
        this.$refs.signUpModal.hide()
      },
      logIn: function() {
        this.$root.$emit('bv::show::modal', 'logInModal')
      }
    }
  }
</script>

<style>
  .modal-content {
    border-radius: 1.3rem;
  }

  .modal-dialog {
    padding-top: 100px;
  }

  .modal-body {
    padding: 50px;
  }

  .row {
    margin-bottom: 20px;
  }

  .fa {
    padding-top: 10px;
  }
</style>
