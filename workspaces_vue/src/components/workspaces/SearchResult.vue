<template>
  <div class="search-result clearfix">
    <div class="container">
      <ul v-if="list.length > 0">
        <paginate name="workspacePerPage" :list="list" :per="6">
          <li class="workspace-info clearfix" v-for="workspace in paginated('workspacePerPage')" :key="workspace.id">
            <div class="search-wrapper" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
            </div>
            <div class="content">
              <h5 class="workspace-name"><strong>{{workspace.name}}</strong></h5>
              <span v-bind:class="[workspace.rating > 0 ? checkedStar : uncheckStar]"></span>
              <span v-bind:class="[workspace.rating > 1 ? checkedStar : uncheckStar]" ></span>
              <span v-bind:class="[workspace.rating > 2 ? checkedStar : uncheckStar]" ></span>
              <span v-bind:class="[workspace.rating > 3 ? checkedStar : uncheckStar]" ></span>
              <span v-bind:class="[workspace.rating > 4 ? checkedStar : uncheckStar]" ></span>
              <span>( {{workspace.comments.length}} Reviews)</span>
              <h3 class="workspace-price">VND {{workspace.price_day}} /DAY</h3>
            </div>
          </li>
        </paginate>
        <div class="paginate">
          <paginate-links for="workspacePerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
        </div>
      </ul>
      <div v-else>
        <h1 class="text-center">Opps, Sorry we cannot found</h1>
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
        list: [],
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked',
        paginate: ['workspacePerPage'],
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
      this.searchWorkspace(this.$route.params.key)
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
    height: 350px;
    border: 1px solid #e6e6e6;
  }

  .search-wrapper {
    height: 200px;
    background-size: cover;
  }

  li {
    list-style-type: none;
  }

  li:hover {
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  }

  .content {
    padding: 10px;
  }

  .checked {
    color: orange;
  }

  .paginate {
    clear: both;
    display: table;
    margin: auto;
  }

  .pagination li {
    color: red;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    border: 1px solid #ddd;
  }

  .pagination li.active {
    background-color: #4CAF50;
    color: white;
    border: 1px solid #4CAF50;
  }
  .pagination a:hover:not(.active) {
    background-color: #ddd;
  }
</style>
