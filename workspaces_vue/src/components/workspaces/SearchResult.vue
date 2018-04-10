<template>
  <div class="search-result clearfix">
    <div class="container">
      <ul>
        <li class="workspace-info clearfix" v-for="workspace in list" :key="workspace.id">
          <div class="search-wrapper" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
          </div>
          <div class="content">
            <h5 class="workspace-name"><strong>{{workspace.name}}</strong></h5>
            <span v-bind:class="[workspace.rating > 0 ? checkedStar : uncheckStar]"></span>
            <span v-bind:class="[workspace.rating > 1 ? checkedStar : uncheckStar]" ></span>
            <span v-bind:class="[workspace.rating > 2 ? checkedStar : uncheckStar]" ></span>
            <span v-bind:class="[workspace.rating > 3 ? checkedStar : uncheckStar]" ></span>
            <span v-bind:class="[workspace.rating > 4 ? checkedStar : uncheckStar]" ></span>
            <span>( {{workspace.reviewed}} Reviewed)</span>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    data() {
      return {
        list: [],
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked'
      }
    },
    computed: {
      ...mapState({
        listResult:state => state.workspace.listWorkspaces
      })
    },
    methods: {
      ...mapActions({
        searchWorkspace: 'workspace/searchByLocation'
      })
    },
    created: function() {
      this.searchWorkspace()
      console.log(this.$route.params)
    },
    watch: {
      listResult: function() {
        this.list = this.listResult
      }
    }
  }
</script>
<style scoped>
  .clearfix:after {
    content: "";
    display: table;
    clear: both;
  } 

  .search-result {
    padding: 100px 0;
  }

  .workspace-info {
    float: left;
    width: 30%;
    margin: 10px;
    height: 400px;
    border: 1px solid #e6e6e6;
  }

  .search-wrapper {
    height: 200px;
    background-size: cover;
  }

  li {
    list-style-type: none;
  }

  .content {
    padding: 10px;
  }

  .checked {
    color: orange;
  }

</style>