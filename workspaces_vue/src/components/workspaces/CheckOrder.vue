<template>
  <div class="container order">
    <h2 class="text-center">All order of your workspace</h2>
    <table class="order-table">
      <thead>
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
      </thead>
      <tbody>
        <tr v-for="order in orderOfWorkspace" :key="order.id">
          <td>{{order.id}}</td>
          <td>{{order.name}}</td>
          <td>{{order.workspace_type.type.name}}</td>
          <td>{{order.quantity}}</td>
          <td>{{order.time_start}}</td>
          <td>{{order.time_end}}</td>
          <td><strong>{{order.status}}</strong></td>
          <td v-if="order.status=='waiting'"><button @click="acceptOrder(order.id)">Accept</button></td>
          <td v-else></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        orderOfWorkspace: [],
        currentUser: {}
      }
    },
    created() {
      this.getcurrentUser()
    },
    computed: {
      ...mapState({
       currentuser:state => state.user.currentUser,
       allOrder:state => state.order.allOrder
     })
    },
    methods: {
      ...mapActions({
        'getcurrentUser': 'user/getCurrentUser',
        'getAllOrder': 'order/getAllOrder',
        'changeStatus': 'order/changeStatus'
      }),
      acceptOrder(orderId) {
        this.changeStatus(orderId)
      }
    },
    watch: {
      currentuser() {
        this.currentUser = this.currentuser
        this.getAllOrder(this.currentUser.workspaces[0].id)
      },
      allOrder() {
        this.orderOfWorkspace = this.allOrder
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
</style>