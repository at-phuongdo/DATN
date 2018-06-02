<template>
  <b-modal id="deleteModal" ref="deleteModal" title="Delete Convenient" hide-footer>
    <p>Are you sure to delete this convenient?</p>
    <div class="btn-control">
      <b-btn variant="danger" @click="deleteConvenient">Delete</b-btn>
      <b-btn variant="primary" @click="hideModel">Cancel</b-btn>
    </div>
  </b-modal>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['convenientId'],
    data() {
      return {
        convenientToDelete: null
      }
    },
    computed: {
      ...mapState({
        deleteStatus:state => state.adminConvenient.deleteStatus
      })
    },
    methods: {
      ...mapActions ({
        'delete': 'adminConvenient/deleteConvenient',
        'fetch': 'adminConvenient/getAllConvenients'
      }),
      deleteConvenient() {
        this.delete(this.convenientToDelete)
        this.hideModel()
      },
      hideModel() {
        this.$refs.deleteModal.hide()
      }
    },
    watch: {
      convenientId() {
        this.convenientToDelete = this.convenientId
      },
      deleteStatus() {
        this.fetch()
      }
    }
  }
</script>
<style>

</style>