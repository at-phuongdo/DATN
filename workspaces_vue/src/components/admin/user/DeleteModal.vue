<template>
  <b-modal id="deleteModal" ref="deleteModal" title="Delete User" hide-footer>
    <p>Are you sure to delete this user?</p>
    <div class="btn-control">
      <b-btn variant="danger" @click="deleteUser">Delete</b-btn>
      <b-btn variant="primary" @click="hideModel">Cancel</b-btn>
    </div>
  </b-modal>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['user'],
    data() {
      return {
        userToDelete: {}
      }
    },
    computed: {
      ...mapState({
        deleteStatus:state => state.account.deleteStatus
      })
    },
    methods: {
      ...mapActions ({
        'deleteAccount': 'account/deleteAccount',
        'fetch': 'account/getAllAccount'
      }),
      deleteUser() {
        this.deleteAccount(this.userToDelete.id)
        this.hideModel()
      },
      hideModel() {
        this.$refs.deleteModal.hide()
      }
    },
    watch: {
      user() {
        this.userToDelete = this.user
      },
      deleteStatus() {
        this.fetch()
      }
    }
  }
</script>
<style>

</style>