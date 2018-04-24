<template>
  <div>
    <b-modal id="orderModal" ref= "orderModal" hide-footer hide-header>
      <div v-if="officeOrder.type">
        <b-form>
          <h1><span class="decorate-span">Available reserve</span></h1> 
          <h3>{{officeOrder.type.name}}</h3>
          <p>Your name</p>
          <b-form-input v-model="name"></b-form-input>
          <span>Number of people: </span>
          <select v-model="quantity">
            <option v-for="option in numberPeople" v-bind:value="option" :key="option">
              {{ option }}
            </option>
          </select>
          <p>Start time</p>
          <b-row>
            <b-col md="6">
              <el-time-select v-model="startTime" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}" placeholder="Open time">
              </el-time-select>
            </b-col>
            <b-col md="6">
              <b-form-input type="date" v-model="startDate"></b-form-input>
            </b-col>
          </b-row>
          <p>End time</p>
          <b-row>
            <b-col md="6">
              <el-time-select v-model="endTime" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}" placeholder="Open time">
              </el-time-select>
            </b-col>
            <b-col md="6">
              <b-form-input type="date" v-model="endDate"></b-form-input>
            </b-col>
          </b-row>
          <div class="button-control">
            <b-button @click="orderWorkspace" variant="primary" >Save</b-button>
            <b-btn variant="danger" @click="hideModal" >Close</b-btn>
          </div>
        </b-form>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['officeOrder'],
    data() {
      return {
        name: '',
        startTime: '',
        endTime: '',
        numberPeople: null, 
        quantity: 1,
        startDate: '',
        endDate: ''
      }
    },
    created() {
      this.getCurrentUser()
    },
    computed: {
      ...mapState({
        currentUser:state => state.user.currentUser,
        createdOrder:state => state.order.newOrder
      })
    },
    methods: {
      ...mapActions({
        'createOrder': 'order/newOrder',
        'getAllOrders': 'order/getAllOrder',
        'getCurrentUser': 'user/getCurrentUser',
        'getWaitingOrder': 'order/getWaitingOrder'
      }),
      hideModal() {
        this.$refs.orderModal.hide()
      },
      orderWorkspace() {
        var orderParams = {
          name: this.name,
          time_start: this.startTime + ' ' + this.startDate,
          time_end: this.endTime + ' ' + this.endDate,
          quantity: this.quantity,
          workspace_type_id: this.officeOrder.id,
          workspace_id: this.officeOrder.workspace_id,
          user_id: this.currentUser.id
        };
        this.createOrder(orderParams)
        this.hideModal()
      }
    },
    watch: {
      officeOrder: function() {
        this.numberPeople = this.officeOrder.number_of_people
      }
    }
  }
</script>
<style>

</style>