<template>
  <div>
    <b-modal id="resetPassword" ref= "resetPassword" hide-footer hide-header>
      <div class="d-block text-center">
        <b-form>
          <h1>RESET YOUR PASSWORD</h1>
          <b-row>
           <b-col sm="1"><span class="fa fa-lock"></span></b-col>
           <b-col sm="11">
             <b-form-input v-validate="'required|min:6|confirmed'" type="password" class="form-control" id="password" name="password" placeholder="New Password" v-model="password">
             </b-form-input>
             <span class="is-danger" v-if="errors.has('password') && onConfirm">{{errors.first('password')}}</span>
           </b-col>
         </b-row>
         <b-row>
          <b-col sm="1"><span class="fa fa-lock"></span></b-col>
          <b-col sm="11">
            <b-form-input v-validate="'required'" type="password" class="form-control" id="password_confirmation" name="password_confirmation" placeholder="Verify password" v-model="password_confirmation">
            </b-form-input>
            <span class="is-danger" v-if="!onConfirm  && password_confirmation">{{errors.first('password')}}</span>
          </b-col>
        </b-row>
        <b-row>
          <b-col sm="1"><span class="fa fa-user"></span></b-col>
          <b-col sm="11">
            <b-form-input v-validate="'required'" name="token" type="text" v-model="token" placeholder="Code"></b-form-input>
            <span class="is-danger" v-if="errors.has('token')">{{errors.first('token')}}</span>
          </b-col>
        </b-row>
        <b-button @click="resetPassword" variant="primary" >OK</b-button>
        <b-btn variant="danger" @click="hideModal" >Close</b-btn>
      </b-form>
      <br>
      <p><i>New user? Sign up<router-link v-on:click.native="signUp" to="/"> here</router-link></i></p>
    </div>
  </b-modal>
</div>
</template>
<script>
  import { mapActions } from 'vuex'
  export default {
    data() {
      return {
        token: '',
        password: '',
        password_confirmation: ''
      }
    },
    computed: {
      onConfirm () {
        if(this.errors.items.length){
          return this.errors.items.find(f => {
            return f.rule !== "confirmed"
          })
        }
      }
    },
    methods: {
      ...mapActions({
        'reset' : 'user/resetPassword'
      }),
      hideModal: function() {
        this.$refs.resetPassword.hide()
      },
      alert(options) {
        swal(options)
      },
      alertSuccess({
        title = "Success!", 
        text = "Congratulations on your successful change of password", 
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
        title = "Error!", text = "Oops...Your code is wrong. Please check mail again!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      resetPassword: function() {
        var paramsReset = {
          token: this.token,
          password: this.password
        }
        this.$validator.validateAll().then( async () => {
          if(this.errors.items.length === 0) {
            await this.reset(paramsReset)
            if (this.$store.state.user.status === this.$getConst('STATUS_OK')) {
              localStorage.setItem('token', this.$store.state.user.currentUser.confirm_token)
              this.alertSuccess()
              this.hideModal()
            }
            else {
              this.alertError()
            }
          }
        })
      }
    }
  }

</script>