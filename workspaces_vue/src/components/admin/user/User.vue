<template>
  <div class="user-content">
    <h2 class="text-center">All account</h2>
    <paginate name="accountPerPage" :list="listAllAccount" :per="10">
      <table class="account-table">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Role</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Action</th>
        </tr>
        <tr v-for="account in paginated('accountPerPage')" :key="account.id">
          <td>{{account.id}}</td>
          <td>{{account.username}}</td>
          <td>{{account.role}}</td>
          <td>{{account.email}}</td>
          <td>{{account.phone}}</td>
          <td>
            <b-btn>Detail</b-btn>
            <b-btn>Edit</b-btn>
            <b-btn>Delete</b-btn>
          </td>
        </tr>
      </table>
    </paginate>
    <div class="paginate">
      <paginate-links for="accountPerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
    </div>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        listAllAccount: [],
        paginate: ['accountPerPage'],
      }
    },
    created() {
      this.getAllAccount()
    },
    computed: {
      ...mapState({
        allAccount:state => state.account.list
      })
    },
    methods: {
      ...mapActions({
        'getAllAccount': 'account/getAllAccount'
      }),
    },
    watch: {
      allAccount() {
        this.listAllAccount = this.allAccount
      }
    }
  }
</script>
<style>
  .user-content {
    width: 85%;
    float: right;
    padding-top: 20px;
  }

  .order {
    padding: 100px 0;
  }
  .account-table {
    width: 100%;
    text-align: center;
  }

  .account-table th, td{
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