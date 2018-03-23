<template>
  <div id="header">
   <div class="container">
    <b-navbar toggleable="md" type="dark">
      <b-navbar-brand href="#">
        <img src="http://www.myiconfinder.com/uploads/iconsets/256-256-8d0b15014c0fd4c1edaed92510d161db.png" alt="" height="60px">
        <span>COWORKING SPACES</span>
      </b-navbar-brand>
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-collapse is-nav id="nav_collapse">
        <b-navbar-nav class="ml-auto" v-if="isLogin">
          <b-nav-item>
            <div  class="dropdown">
            <img class="avatar" :src="currentUser.avatar" width="60px" v-if="currentUser.avatar">
              <img class="avatar" src="https://research.kent.ac.uk/clho/wp-content/plugins/wp-person-cpt/images/featured-default.png" width="60px" v-else>
              <b-button class="profile-button">
                Hi, {{currentUser.username}}
              </b-button>
              <div class="dropdown-content" style="left:0;">
                <router-link v-on:click.native="editProfile" to="/"> Edit profile</router-link>
                <router-link v-on:click.native="logOut" to="/"> Log out</router-link>
              </div>
            </div>
            <b-button class="add-button"><span class="fa fa-plus"></span>Add new space</b-button>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav class="ml-auto" v-else>
          <b-nav-item>
            <b-button variant="outline-success" @click="signUp">Sign up</b-button>
          </b-nav-item>
          <b-nav-item>
            <b-button class="login-button" @click="logIn">Login</b-button>
          </b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
  <signup-modal v-on:getUser="getUser($event)"></signup-modal>
  <login-modal v-on:getUser="getUser($event)"></login-modal>
  <confirm-modal :user="user" ></confirm-modal>
  <mail-modal></mail-modal>
  <reset-password></reset-password>
</div>
</template>
<script>
  import SignUpModal from './users/SignUpModal.vue'
  import LoginModal from './users/LoginModal.vue'
  import ConfirmModal from './users/ConfirmModal.vue'
  import MailToReset from './users/MailToReset.vue'
  import ResetPassword from './users/ResetPassword.vue'

  var $ = window.jQuery = require('jquery')

  export default {
    components: {
      'signup-modal': SignUpModal,
      'login-modal' : LoginModal,
      'confirm-modal' : ConfirmModal,
      'mail-modal' : MailToReset,
      'reset-password' : ResetPassword

    },
    data() {
      return {
        user: ''
      }
    },
    created() {
      this.$store.dispatch("getCurrentUser", localStorage.getItem("token"))
    },
    computed: {
      isLogin() {
        return this.$store.state.user.isLogin
      },
      currentUser() {
        return this.$store.state.user.currentUser
      }

    },
    methods: {
      signUp: function() {
        this.$root.$emit('bv::show::modal', 'signUpModal')
      },
      logIn: function() {
        this.$root.$emit('bv::show::modal', 'logInModal')
      },
      logOut: function() {
        localStorage.removeItem("token")
        this.$store.commit('LOGOUT_VALUE')
        location.reload()
      },
      getUser: function(user) {
        this.user = user
      }
    }
  }
  $(function(){
    var headerTop = $('#header').offset().top;

    $(window).scroll(function(){
      if( $(window).scrollTop() >= headerTop ) {
        $('#header').css({position: 'fixed', top: '0px'});
      } else {
        $('#header').css({position: 'static', top: '0px'});
      }
    });
  });
</script>
<style scoped>
  #header {
    background-color: white;
    width: 100%;
    z-index: 1;
  }

  span {
    color: #28a745;
  }

  .fa-plus {
    color: white;
    padding-top: 0;
  }

  .profile-button,
  .add-button {
    background: #28a745;
    color: #fff;
    display: inline-block;
  }

  .profile-button {
    background: #316eb1;
  }

  .add-button:hover {
    color: #fff;
  }

  .navbar-toggler {
    background-color: #28a745;
  }

  .dropdown {
    position: relative;
    display: inline-block;
  }

  .dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
  }

  .dropdown-content a:hover {
    background-color: #f1f1f1
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }

  .dropdown:hover .profile-button {
    background-color: #3a71c9;
  }

  .avatar {
    border-radius: 50%;
  }
</style>
