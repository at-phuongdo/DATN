<template>
  <div class="container order">
    <h2 class="text-center">All order of your workspace</h2>
    <paginate name="orderPerPage" :list="allOrder" :per="10">
      <table class="order-table">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Office type</th>
          <th>Quantity</th>
          <th>From</th>
          <th>To</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
        <tr v-for="order in paginated('orderPerPage')" :key="order.id">
          <td>{{order.id}}</td>
          <td>{{order.name}}</td>
          <td>{{order.workspace_type.type.name}}</td>
          <td>{{order.quantity}}</td>
          <td>{{order.time_start}}</td>
          <td>{{order.time_end}}</td>
          <td><strong>{{order.status}}</strong></td>
          <td v-if="order.status=='waiting'">
            <button @click="acceptOrder(order.id)">Accept</button>
            <button @click="declineOrder(order.id)">Decline</button>
          </td>
          <td v-else></td>
        </tr>
      </table>
    </paginate>
    <div class="paginate">
      <paginate-links for="orderPerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
    </div>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        paginate: ['orderPerPage'],
        orderOfWorkspace: []
      }
    },
    created() {
      this.getCurrentUser(localStorage.getItem("token"))
    },
    computed: {
      ...mapState({
       allOrder:state => state.order.allOrder,
       userLogin:state => state.user.currentUser
     })
    },
    methods: {
      ...mapActions({
        'getCurrentUser': 'user/getCurrentUser',
        'getAllOrder': 'order/getAllOrder',
        'getWaitingOrder': 'order/getWaitingOrder',
        'changeStatus': 'order/changeStatus',
        'decline': 'order/declineOrder'
      }),
      acceptOrder(orderId) {
        this.changeStatus(orderId)
      },
      declineOrder(orderId) {
        this.decline(orderId)
      }
    },
    watch: {
      allOrder() {
        this.orderOfWorkspace = this.allOrder
        this.getWaitingOrder(this.userLogin.workspaces[0].id)
      },
      userLogin() {
        this.getAllOrder(this.userLogin.workspaces[0].id)
      }
    }
  }
</script>
<style>
  .order {
    padding: 100px 0;
  }
  .order-table {
    width: 100%;
    text-align: center;
  }

  .order-table th, td{
    border: 1px solid #e5e5e5;
  }

  .paginate {
    clear: both;
    display: table;
    margin: auto;
  }
</style>