<template>
  <div>
    <b-modal id="mailToReset" ref="mailToReset" hide-footer hide-header>
      <div class="d-block text-center">
        <b-form>
          <h1>Forgot password</h1>
          <h3><span class="decorate-span">Please give us your email</span></h3>
          <b-row align-h="center">
            <b-col sm="2">
              <circle4 v-show="loading"></circle4>
            </b-col>
          </b-row>
          <b-row>
            <b-col sm="1"><span class="fa fa-envelope"></span></b-col>
            <b-col sm="11">
              <b-form-input v-validate="'required|email'" name="email" v-model="email" type="text" placeholder="Email"></b-form-input>
              <span v-show="errors.has('email')" class="is-danger">{{ errors.first('email') }}</span>
            </b-col>
          </b-row>
          <b-button @click="sendmail" variant="primary">OK</b-button>
          <b-btn variant="danger"  @click="hideModal" >Close</b-btn>
        </b-form>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import {Circle4} from 'vue-loading-spinner'
  export default {
    components: {
      Circle4
    },
    data() {
      return {
        email: '',
        loading: false
      }
    },
    methods: {
      alert(options) {
        swal(options)
      },
      alertError({
        title = "Error!", text = "Oops...Email not valid! Please try again!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      sendmail: async function() {
        this.loading = true
        await this.$store.dispatch('sendEmailToReset', {'email': this.email})
        this.loading = false
        if (this.$store.state.user.status === this.$getConst('STATUS_OK')) {
          this.resetPassword()
        }
        else {
          this.alertError()
        }
      },
      hideModal: function() {
        this.$refs.mailToReset.hide()
      },
      resetPassword: function() {
        this.$root.$emit('bv::show::modal', 'resetPassword')
      }
    }
  }

</script>