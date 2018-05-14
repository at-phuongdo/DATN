<template>
  <div class="user-content">
    <h2 class="text-center">All account</h2>
    <paginate name="accountPerPage" :list="listAllAccount" :per="10">
      <b-btn variant="primary" @click="openNewModal">New User</b-btn>
      <table class="account-table">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>First name</th>
          <th>Last name</th>
          <th>Role</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Birthday</th>
          <th>Gender</th>
          <th>Action</th>
        </tr>
        <tr v-for="account in paginated('accountPerPage')" :key="account.id">
          <td>{{account.id}}</td>
          <td>{{account.username}}</td>
          <td>{{account.first_name}}</td>
          <td>{{account.last_name}}</td>
          <td>{{account.role}}</td>
          <td>{{account.email}}</td>
          <td>{{account.phone}}</td>
          <td>{{account.birthday}}</td>
          <td>{{account.gender}}</td>
          <td>
            <b-btn @click="openEditModal(account)">Edit</b-btn>
            <b-btn @click="openDeleteModal(account)">Delete</b-btn>
          </td>
        </tr>
      </table>
    </paginate>
    <div class="paginate">
      <paginate-links for="accountPerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
    </div>
    <new-user></new-user>
    <edit-user :user="selectedUser"></edit-user>
    <delete-user :user="selectedUser"></delete-user>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  import NewUser from './NewModal.vue'
  import EditUser from './EditModal.vue'
  import DeleteUser from './DeleteModal.vue'
  export default {
    components: {
      NewUser,
      EditUser,
      DeleteUser
    },
    data() {
      return {
        listAllAccount: [],
        paginate: ['accountPerPage'],
        selectedUser: {}
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
      openNewModal() {
        this.$root.$emit('bv::show::modal', 'newModal')
      },
      openEditModal(account) {
        this.selectedUser = account
        this.$root.$emit('bv::show::modal', 'editModal')
      },
      openDeleteModal(account) {
        this.selectedUser = account
        this.$root.$emit('bv::show::modal', 'deleteModal')
      }
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

  ul {
    padding-right: 30px;
  }

  .account-table {
    width: 100%;
    text-align: center;
    margin-top: 20px;
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