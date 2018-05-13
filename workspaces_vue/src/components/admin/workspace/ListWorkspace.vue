temp<template>
<div class="workspace-content">
  <h2 class="text-center">All workspace</h2>
  <paginate name="workspacePerPage" :list="listAllWorkspace" :per="10">
    <table class="workspace-table">
      <thead>
        <th>ID</th>
        <th>Name</th>
        <th>Adress</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Website</th>
        <th>Action</th>
      </thead>
      <tbody>
        <tr v-for="workspace in paginated('workspacePerPage')" :key="workspace.id">
          <td>{{workspace.id}}</td>
          <td>{{workspace.name}}</td>
          <td>{{workspace.address}}</td>
          <td>{{workspace.email}}</td>
          <td>{{workspace.phone}}</td>
          <td>{{workspace.website}}</td>
          <td>
            <b-btn>Detail</b-btn>
            <b-btn>Edit</b-btn>
            <b-btn>Delete</b-btn>
          </td>
        </tr>
      </tbody>
    </table>
  </paginate>
  <div class="paginate">
    <paginate-links for="workspacePerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
  </div>
</div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        listAllWorkspace: [],
        paginate: ['workspacePerPage'],
      }
    },
    created() {
      this.getAllWorkspace()
    },
    computed: {
      ...mapState({
        allWorkspace:state => state.adminWorkspace.list
      })
    },
    methods: {
      ...mapActions({
        'getAllWorkspace': 'adminWorkspace/getAllWorkspace'
      }),
    },
    watch: {
      allWorkspace() {
        this.listAllWorkspace = this.allWorkspace
      }
    }
  }
</script>
<style>
  .workspace-content {
    width: 85%;
    float: right;
    padding-top: 20px;
  }

  .workspace-table {
    width: 100%;
    text-align: center;
    display: block;
    overflow-x: auto;
    white-space: nowrap;
  }

  .workspace-table th, td{
    border: 1px solid #e5e5e5;
  }

  .paginate {
    clear: both;
    display: table;
    margin: auto;
  }

  .pagination li.active {
    background-color: #303c58;
    color: white;
    border: 1px solid #303c58;
  }

  .fa-trash-alt {
    color: red;
  }

</style>