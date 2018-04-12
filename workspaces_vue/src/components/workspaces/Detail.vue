<template>
  <div class="detail">
    <div class="avatar" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
    </div>
    <div class="container">
      <div class="description">
        <h1><strong>{{workspaceDetail.name}}</strong></h1>
        <p><span class="fa fa-map-marker"></span>{{workspaceDetail.address}}</p>
        <hr>
        <div v-html="workspaceDetail.description"></div>
      </div>
      <div class="opening-hours">
      </div>
    </div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    data() {
      return {
        workspaceDetail: {}
      }
    },
    created() {
      this.getDetail(this.$route.params.name)
    },
    computed: {
      ...mapState({
        workspace:state => state.workspace.workspaceDetail
      })
    },
    methods: {
      ...mapActions({
        getDetail: 'workspace/getDetail'
      })
    },
    watch: {
      workspace: function() {
        this.workspaceDetail = this.workspace
      }
    }
  }
</script>
<style scoped>
  .avatar{
    height: 500px;
    background-size: cover;
  } 
</style>