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
              <b-form-input v-validate="'required|min:6'" name="username" type="text" v-model="username" placeholder="Username"></b-form-input>
              <span v-show="errors.has('username')" class="is-danger">{{ errors.first('username') }}</span>
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
             <b-form-input v-validate="'required|min:6|confirmed'" type="password" class="form-control" id="password" name="password" placeholder="New Password" v-model="password"></b-form-input>
             <span class="is-danger" v-if="errors.has('password')">{{errors.first('password')}}</span>
           </b-col>
         </b-row>
         <b-row>
          <b-col sm="1"><span class="fa fa-lock"></span></b-col>
          <b-col sm="11">
            <b-form-input v-validate="'required'" type="password" class="form-control" id="password_confirmation" name="password_confirmation" placeholder="Verify password"></b-form-input>
          </b-col>
        </b-row>
        <b-button @click="addUser" variant="primary" >Sign up</b-button>
        <b-btn variant="danger"  @click="hideModal" >Close</b-btn>
      </b-form>
      <br>
      <p><i>Already have account? Login <router-link v-on:click.native="logIn" to="/">here</router-link></i></p>
    </div>
  </b-modal>
</div>
</template>
<script>
  export default {
    data() {
      return {
        username: '',
        email: '',
        password: ''
      }
    },
    methods: {
      hideModal:function() {
        this.$refs.signUpModal.hide()
      },
      alert(options) {
        swal(options)
      },
      alertError({
        title = "Error!", text = "Oops...Email already exist!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      addUser:function() {
        var newUser = {
          username : this.username,
          email : this.email,
          password: this.password
        }
        this.$validator.validateAll().then(() => {
          if(this.errors.items.length === 1) {
            this.$store.dispatch('addUser', {"user":newUser})
            console.log(this.$store.state.user.newUser)
            setTimeout(()=> {
                var status = this.$store.state.user.status
                if( status != "ok") {
                  this.alertError();
                } else {
                  this.$emit('getUser', this.$store.state.user.newUser)
                  this.$refs.signUpModal.hide()
                  this.confirmEmail()
                }
            }, 5000)
          }
        })
      },
      logIn: function() {
        this.$root.$emit('bv::show::modal', 'logInModal')
      },
      confirmEmail: function() {

        this.$root.$emit('bv::show::modal', 'confirmModal')
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

  .is-danger {
    color: red;
    font-style: italic;
    font-size: 0.8em;
  }
</style>
