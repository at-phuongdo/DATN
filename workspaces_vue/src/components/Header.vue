<template>
  <div id="header">
   <div class="container">
    <b-navbar toggleable="md" type="dark">
      <b-navbar-brand href="#">
        <img src="http://www.myiconfinder.com/uploads/iconsets/256-256-8d0b15014c0fd4c1edaed92510d161db.png" alt="" height="80px">
        <span>COWORKING SPACES</span>
      </b-navbar-brand>
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-collapse is-nav id="nav_collapse">
        <b-navbar-nav class="ml-auto" v-if="isLogin">
          <b-nav-item>
            <b-button class="profile-button">{{currentUser.username}}</b-button>
          </b-nav-item>
          <b-nav-item>
            <b-button class="add-button">Add new space</b-button>
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
  <signup-modal></signup-modal>
  <login-modal></login-modal>
</div>
</template>
<script>
  import SignUpModal from './users/SignUpModal.vue'
  import LoginModal from './users/LoginModal.vue'

  var $ = window.jQuery = require('jquery')
  
  export default {
    components: {
      'signup-modal': SignUpModal,
      'login-modal' :LoginModal
    },
    data() {
      return {
        isLogin: false
      }
    },
    created() {
      this.$store.dispatch("getCurrentUser")
    },
    computed: {
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
      }
    }
  }
  $(function(){
        var headerTop = $('#header').offset().top;

        $(window).scroll(function(){
          if( $(window).scrollTop() > headerTop ) {
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
}
span {
  color: #28a745;
}

.profile-button,
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
