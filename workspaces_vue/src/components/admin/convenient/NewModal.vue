<template>
  <b-modal id="newModal" ref="newModal" title="New Convenient" hide-footer>
    <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Name"
      label-for="name">
      <b-form-input class="sm" name="name" type="text" v-model="name"></b-form-input>
    </b-form-group>
    <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Description"
      label-for="description">
      <b-form-input class="sm" name="description" type="text" v-model="description"></b-form-input>
    </b-form-group>
    <div class="btn-control">
      <b-btn variant="primary" @click="createConvenient">Save</b-btn>
      <b-btn variant="danger" @click="hideModal">Cancel</b-btn>
    </div>
  </b-modal>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        name: '',
        description: ''
      }
    },
    computed: {
      ...mapState({
        createStatus:state => state.adminConvenient.createStatus
      })
    },
    methods: {
      ...mapActions({
        'newConvenient': 'adminConvenient/newConvenient',
        'fetch': 'adminConvenient/getAllConvenients'
      }),
      createConvenient() {
        this.newConvenient({'convenient': {
          name: this.name,
          description: this.description
        }})
        this.hideModal()
      },
      hideModal() {
        this.$refs.newModal.hide()
      }
    },
    watch: {
      createStatus() {
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