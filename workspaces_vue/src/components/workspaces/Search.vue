<template>
  <div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    dependencies : ['workspaceService'],
    created() {
      this.workspaceService.searchByLocation = this.search
    },
    data() {
      return {

      }
    },
    computed: {

    },
    methods: {
      ...mapActions({
        searchByLocations: 'workspace/searchByLocation'
      }),
      search: function() {
        debugger
        console.log('p')
        this.searchByLocations()
      }
    }
  }
</script>
<style></style>
