<template>
  <div>
    <b-modal id="logInModal" ref= "logInModal" hide-footer hide-header>
      <div class="d-block text-center">
        <b-form>
          <h1><span class="decorate-span">Welcome to Our website</span></h1>
          <b-row>
            <b-col sm="1"></b-col>
            <b-col sm="11">
              <div class="fb-login-button" data-width="348px" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-use-continue-as="false" onlogin="checkLoginState()"></div>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="1"><span class="fa fa-envelope"></span></b-col>
            <b-col sm="11">
              <b-form-input v-validate="'required|email'" name="email" v-model="email" type="text" placeholder="Email"></b-form-input>
              <span v-show="errors.has('email')" class="is-danger">{{ errors.first('email') }}</span>
            </b-col>
          </b-row>
          <b-row>
           <b-col sm="1"><span class="fa fa-lock"></span></b-col>
           <b-col sm="11">
             <b-form-input v-validate="'required|min:6'" type="password" class="form-control" id="password" name="password" placeholder="Your Password" v-model="password"></b-form-input>
             <span class="is-danger" v-if="errors.has('password')">{{errors.first('password')}}</span>
           </b-col>
         </b-row>
         <b-row>
           <b-col sm="11" offset="1">
             <i class="resetPassword"><router-link v-on:click.native="resetPassword" to="/">Forgot your password</router-link></i>
           </b-col>
         </b-row>
         <b-button @click="login" variant="primary" >Login</b-button>
         <b-btn variant="danger" @click="hideModal" >Close</b-btn>
       </b-form>
       <br>
       <p><i>New user? Sign up<router-link v-on:click.native="signUp" to="/"> here</router-link></i></p>
     </div>
   </b-modal>
 </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        uid: '',
        email: '',
        password: '',
        newUser: {}
      }
    },
    created() {
      window.checkLoginState = this.checkLoginState
    },
    computed: {
      ...mapState({
        currentuser:state => state.user.currentUser,
        userStatus:state => state.user.status
      })
    },
    methods: {
      ...mapActions({
        'loginFacebook': 'user/loginFacebook',
        'logIn': 'user/logIn'
      }),
      hideModal: function() {
        this.$refs.logInModal.hide()
      },
      alert(options) {
        swal(options)
      },
      alertSuccess({
        title = "Success!", 
        text = "Welcome to our website!", 
        timer = 2000, 
        showConfirmationButton = false
      } = {}) {
        this.alert({
          title: title,
          text: text,
          timer: timer,
          button: showConfirmationButton,
          icon: 'success'
        });
      },
      alertError({
        title = "Error!", text = "Oops...Email or password invalid"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      alertConfirm({
        title = "Error!", text = "Your account is not confirm. \nPlease check mail to confirm your account!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      login: function() {
        var userLogin = {
          email: this.email,
          password: this.password
        }
        this.logIn({ "session": userLogin })
        setTimeout(() => {
          var user = this.currentuser
          var status = this.status
          if(status === this.$getConst('STATUS_OK')){
            localStorage.setItem("token", user.confirm_token);
            this.$refs.logInModal.hide()
            this.alertSuccess()
          }
          else if (status === 'no_content') {
            this.$emit('getUser', user)
            this.confirm()
          }
          else{
            this.alertError()
          }
        }, 500)
      },
      signUp: function() {
        this.$root.$emit('bv::show::modal', 'signUpModal')
      },
      confirm: function() {
        this.$root.$emit('bv::show::modal', 'confirmModal')
      },
      resetPassword: function() {
        this.$root.$emit('bv::show::modal', 'mailToReset')
      },
      getUserData: function() {
        var self = this
        FB.login(function(response) {
          var session = {}
          FB.api('/me?access_token='+response.authResponse.accessToken, { fields: 'id, name, email, picture' },
            async function(userInformation) {
              session = {
                uid: userInformation.id,
                username: userInformation.name,
                email: userInformation.email,
                avatar: userInformation.picture.data.url
              }
              await self.loginFacebook({'session': session })
              var user = self.currentuser
              localStorage.setItem("token", user.confirm_token)
            });
        }, {scope: 'email'});
      },
      checkLoginState: function() {
        this.getUserData()
        this.hideModal()
      }
    }
  }
</script>
<style scoped>
  .resetPassword {
    float: left;
  }
</style>
