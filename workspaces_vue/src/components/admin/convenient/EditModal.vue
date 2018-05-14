<template>
  <b-modal id="editModal" ref="editModal" title="EditConvenient" hide-footer>
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
      <b-btn variant="primary" @click="editConvenient">Save</b-btn>
      <b-btn variant="danger" @click="hideModal">Cancel</b-btn>
    </div>
  </b-modal>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['convenient'],
    data() {
      return {
        name: '',
        description: ''
      }
    },
    computed: {
      ...mapState({
        editStatus:state => state.adminConvenient.editStatus
      })
    },
    methods: {
      ...mapActions({
        'edit': 'adminConvenient/editConvenient',
        'fetch': 'adminConvenient/getAllConvenients'
      }),
      editConvenient() {
        this.edit({'convenient': {
          id: this.convenient.id,
          name: this.name,
          description: this.description
        }})
        this.hideModal()
      },
      hideModal() {
        this.$refs.editModal.hide()
      }
    },
    watch: {
      convenient() {
        this.name = this.convenient.name
        this.description = this.convenient.description
      },
      editStatus() {
        this.fetch()
      },
    }
  }
</script>
<style>
  .btn-control {
    float: right;
  }
</style>