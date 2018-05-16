<template>
  <b-modal id="deleteModal" ref="deleteModal" title="Delete User" hide-footer>
    <p>Are you sure to delete this user?</p>
    <div class="btn-control">
      <b-btn variant="danger" @click="deleteWorkspace">Delete</b-btn>
      <b-btn variant="primary" @click="hideModel">Cancel</b-btn>
    </div>
  </b-modal>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['workspace'],
    data() {
      return {
        workspaceToDelete: {}
      }
    },
    computed: {
      ...mapState({
        deleteStatus:state => state.adminWorkspace.deleteStatus
      })
    },
    methods: {
      ...mapActions ({
        'delete': 'adminWorkspace/deleteWorkspace',
        'fetch': 'adminWorkspace/getAllWorkspace'
      }),
      deleteWorkspace() {
        this.delete(this.workspaceToDelete.id)
        this.hideModel()
      },
      hideModel() {
        this.$refs.deleteModal.hide()
      }
    },
    watch: {
      workspace() {
        this.workspaceToDelete = this.workspace
      },
      deleteStatus() {
        this.fetch()
      }
    }
  }
</script>
<style>
  .btn-control {
    float: right;
  }

</style>