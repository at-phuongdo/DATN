<template>
  <div id="header" ref="header">
   <div class="container">
    <b-navbar toggleable="md" type="dark">
      <router-link to="/">
        <b-navbar-brand>
          <img src="http://www.myiconfinder.com/uploads/iconsets/256-256-8d0b15014c0fd4c1edaed92510d161db.png" alt="" height="40px">
          <span>COWORKING SPACES</span>
        </b-navbar-brand>
      </router-link>
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-collapse is-nav id="nav_collapse">
        <b-navbar-nav class="ml-auto" v-if="currentUser">
          <b-nav-item>
            <div  class="dropdown">
              <img class="avatar" :src="currentUser.avatar" width="40px" v-if="currentUser.avatar">
              <img class="avatar" src="https://research.kent.ac.uk/clho/wp-content/plugins/wp-person-cpt/images/featured-default.png" width="60px" v-else>
              <b-button class="profile-button">
                Hi, {{currentUser.username}}
              </b-button>
              <div class="dropdown-content" style="left:0;">
                <router-link v-on:click.native="editProfile" to="/"> Edit profile</router-link>
                <router-link to="/my-workspace" v-if="currentUser.role=='partner'"> My workspace</router-link>
                <router-link v-on:click.native="logOut" to="/"> Log out</router-link>
              </div>
            </div>
            <router-link to="/new-workspace">
              <b-button class="add-button"><span class="fa fa-plus"></span>Add new space</b-button>
            </router-link>
            <router-link to="/orders" v-if="currentUser.role=='partner'">
              <b-button variant="outline-primary" class="order-btn">Order</b-button>
              <span class="fa fa-comment"></span>
              <span class="num">{{countWaitingOrder}}</span>
            </router-link>
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
  <edit-profile :currentUser="currentUser"></edit-profile>
</div>
</template>
<script>
  import SignUpModal from './users/SignUpModal.vue'
  import LoginModal from './users/LoginModal.vue'
  import ConfirmModal from './users/ConfirmModal.vue'
  import MailToReset from './users/MailToReset.vue'
  import ResetPassword from './users/ResetPassword.vue'
  import EditProfile from './users/EditProfileModal.vue'
  import { mapState, mapActions } from 'vuex'

  var $ = window.jQuery = require('jquery')

  export default {
    components: {
      'signup-modal': SignUpModal,
      'login-modal': LoginModal,
      'confirm-modal': ConfirmModal,
      'mail-modal': MailToReset,
      'reset-password': ResetPassword,
      'edit-profile': EditProfile
    },
    data() {
      return {
        user: '',
        currentUser: null,
        isLogin: false,
        countWaitingOrder: 0
      }
    },
    mounted() {
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
    },
    created() {
      this.getCurrentUser(localStorage.getItem("token"))
    },
    computed: {
      ...mapState({
        userLogin:state => state.user.currentUser,
        loginStatus:state => state.user.isLogin,
        waitingOrder:state => state.order.orderWaiting
      })
    },
    methods: {
      ...mapActions({
        'getCurrentUser': 'user/getCurrentUser',
        'getWaitingOrder': 'order/getWaitingOrder'
      }),
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
      },
      editProfile() {
        this.$root.$emit('bv::show::modal', 'editProfileModal')
      }
    },
    watch: {
      userLogin() {
        if (!!this.userLogin.confirm_at) {
          this.currentUser = this.userLogin
          if (this.currentUser.workspaces[0]) {
            this.getWaitingOrder(this.currentUser.workspaces[0].id)
          }
        }
      },
      loginStatus() {
        this.isLogin = this.loginStatus
      },
      waitingOrder() {
        this.countWaitingOrder = this.waitingOrder.length
      }
    }
  }
  // $(function(){
  //   var headerTop = $('#header').offset().top;
  //   $(window).scroll(function(){
  //     if( $(window).scrollTop() >= headerTop ) {
  //       $('#header').css({position: 'fixed', top: '0px'});
  //     } else {
  //       $('#header').css({position: 'static', top: '0px'});
  //     }
  //   });
  // });
</script>
<style scoped>
  #header {
    background-color: white;
    width: 100%;
    z-index: 1;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
  }

  .navbar {
    padding: 0;
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

  .order-btn {
    position: relative;
  }
  span.fa-comment {
    position: absolute;
    font-size: 2em;
    top: -12px;
    color: red;
    right: -15px;
  }
  span.num {
    position: absolute;
    top: 1px;
    color: #fff;
    right: -3px;
  }
</style>
