<template>
  <div>
    <b-modal id="confirmModal" ref="confirmModal" hide-footer hide-header>
      <div class="d-block text-center">
        <b-form>
          <h1><span class="decorate-span">Confirm your account</span></h1>
          <h3>Please check mail to get your code</h3>
          <b-row>
            <b-col>
              <b-form-input v-model="code" type="text" placeholder="Confirm code"></b-form-input>
            </b-col>
          </b-row>
          <b-button @click="confirm" variant="primary">OK</b-button>
          <b-btn variant="danger" @click="hideModal" >Close</b-btn>
        </b-form>
      </div>
    </b-modal>
  </div>
</template>
<script>
  export default {
    props: ['user'],
    data() {
      return {
        code: ''
      }
    },
    methods: {
      hideModal: function() {
        this.$refs.confirmModal.hide()
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
        title = "Error!", text = "Oops...Your code is wrong. Please check mail again!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      confirm: async function() {
        await this.$store.dispatch('confirmEmail',this.code)
        var status = this.$store.state.user.status
        if ( status === this.$getConst('STATUS_OK')){
          localStorage.setItem('token', this.user.confirm_token)
          this.hideModal()
          this.alertSuccess()
        }
        else {
          this.alertError()
        }
      }
    }
  }
</script>