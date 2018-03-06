<template>
  <div>
    <b-modal id="logInModal" ref= "logInModal" hide-footer hide-header>
      <div class="d-block text-center">
        <b-form>
          <h1><span class="decorate-span">Welcome to Our website</span></h1>
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
         <b-button @click="login" variant="primary" >Login</b-button>
         <b-btn variant="danger" @click="hideModal" >Close</b-btn>
       </b-form>
       <p><i>New user? Sign up<router-link v-on:click.native="signUp" to="/"> here</router-link></i></p>
     </div>
   </b-modal>
 </div>
</template>
<script>
  export default {
    data() {
      return {
        email: '',
        password: ''
      }
    },
    methods: {
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
      login: function() {
        var userLogin = {
          email: this.email,
          password: this.password
        }
        this.$store.dispatch('logIn', { "session": userLogin })
        setTimeout(() => {
          var user = this.$store.state.user.currentUser
          var checkLogin = Object.keys(user).length === 0
          if(!checkLogin){
            localStorage.setItem("token", user.confirm_token);
            this.$refs.logInModal.hide()
            this.alertSuccess()
          }
          else{
            this.alertError()
          }
        }, 500)
      },
      signUp: function() {
        this.$root.$emit('bv::show::modal', 'signUpModal')
      }
    }
  }
</script>
