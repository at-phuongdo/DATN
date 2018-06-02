<template>
  <div class="convenient-content">
    <h2 class="text-center">All convenients</h2>
    <paginate name="convenientPerPage" :list="listAllConvenients" :per="10">
      <b-btn variant="primary" @click="openNewModal">New Convenient</b-btn>
      <table class="convenient-table">
        <thead>
          <th>ID</th>
          <th>Name</th>
          <th>Description</th>
          <th>Action</th>
        </thead>
        <tbody>
          <tr v-for="convenient in paginated('convenientPerPage')" :key="convenient.id">
            <td>{{convenient.id}}</td>
            <td>{{convenient.name}}</td>
            <td>{{convenient.description}}</td>
            <td>
              <b-btn @click="editConvenient(convenient)">Edit</b-btn>
              <b-btn @click="deleletConvenient(convenient)">Delete</b-btn>
            </td>
          </tr>
        </tbody>
      </table>
    </paginate>
    <div class="paginate">
      <paginate-links for="convenientPerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
    </div>
    <new-convenient></new-convenient>
    <edit-convenient :convenient="convenientSelected"></edit-convenient>
    <delete-convenient :convenientId="convenientSelectedId"></delete-convenient>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  import NewConvenient from './NewModal.vue'
  import DeleteConvenient from './DeleteModal.vue'
  import EditConvenient from './EditModal.vue'
  export default {
    data() {
      return {
        listAllConvenients: [],
        paginate: ['convenientPerPage'],
        convenientSelectedId: null,
        convenientSelected: {}
      }
    },
    created() {
      this.getAllConvenient()
    },
    computed: {
      ...mapState({
        allConvenient:state => state.adminConvenient.list
      })
    },
    methods: {
      ...mapActions({
        'getAllConvenient': 'adminConvenient/getAllConvenients'
      }),
      openNewModal() {
        this.$root.$emit('bv::show::modal', 'newModal')
      },
      editConvenient(convenient) {
        this.convenientSelected = convenient
        this.$root.$emit('bv::show::modal', 'editModal')
      },
      deleletConvenient(convenient) {
        this.convenientSelectedId = convenient.id
        this.$root.$emit('bv::show::modal', 'deleteModal')
      }
    },
    watch: {
      allConvenient() {
        this.listAllConvenients = this.allConvenient
      }
    },
    components: {
      NewConvenient,
      DeleteConvenient,
      EditConvenient
    }
  }
</script>
<style>
  .convenient-content {
    width: 85%;
    float: right;
    padding-top: 20px;
  }

  .convenient-table {
    width: 100%;
    text-align: center;
    margin-top: 20px;
  }

  .convenient-table th, td{
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