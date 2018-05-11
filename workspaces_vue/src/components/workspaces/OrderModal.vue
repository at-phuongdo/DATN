<template>
  <div>
    <b-modal id="orderModal" ref= "orderModal" hide-footer hide-header>
      <div v-if="officeOrder.type">
        <b-form>
          <h1><span class="decorate-span">Available reserve</span></h1> 
          <h3>{{officeOrder.type.name}}</h3>
          <b-row>
            <p>Your name</p>
            <b-form-input v-model="name"></b-form-input>
          </b-row>
          <!-- Open planroom -->
          <div v-if="officeOrder.type.id == 3">
            <b-row>
              <b-col md="4">
                <span>Number of people </span>
              </b-col>
              <b-col>
                <select v-model="quantity">
                  <option v-for="option in numberOfPeople" v-bind:value="option" :key="option">
                    {{ option }}
                  </option>
                </select>
              </b-col>
            </b-row>
            <b-row>
              <b-col md="4">
                <span>Date</span>
              </b-col>
              <b-col>
                <b-form-input type="date" v-model="startDate"></b-form-input>
              </b-col>
            </b-row>
            <b-row>
              <b-col md="4">
                <span>From</span>
              </b-col>
              <b-col>
                <el-time-select v-model="startTime" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}" placeholder="From">
                </el-time-select>
              </b-col>
            </b-row>
            <b-row>
              <b-col md="4">
                <span>To</span>
              </b-col>
              <b-col>
                <el-time-select v-model="endTime" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}" placeholder="To">
                </el-time-select>
              </b-col>
            </b-row>
          </div>
          <!-- Else -->
          <div v-else>
            <b-row>
              <p>Date</p>
              <el-date-picker
              v-model="valueDateTimeOrder"
              type="daterange"
              align="right"
              unlink-panels
              range-separator="To"
              start-placeholder="Start date"
              end-placeholder="End date"
              :picker-options="pickerOptions">
            </el-date-picker>
          </b-row>
        </div>
        <div class="button-control">
          <b-button @click="orderWorkspace" variant="primary" >Reserve</b-button>
          <b-btn variant="danger" @click="hideModal" >Close</b-btn>
        </div>
      </b-form>
    </div>
  </b-modal>
</div>
</template>
<script>
  import { mapState, mapActions, mapGetters } from 'vuex'
  import moment from 'moment'
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
        endDate: '',
        numberPeopleOrdered: 0,
        valueDateTimeOrder: '',
        range: [],
        orderById: [],
        pickerOptions:{}
      }

    },
    computed: {
      ...mapState({
        currentUser:state => state.user.currentUser,
        createdOrder:state => state.order.newOrder,
        allOrders:state => state.order.allOrder
      }),
      ...mapGetters("order", [
        "getOrderByOfficeId"
        ]),
      numberOfPeople() {
        return this.officeOrder.available
      }
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
      alert(options) {
        swal(options)
      },
      alertSuccess({
        title = "Success!", 
        text = "Thanks for reserve our workspace. Please check mail to check we accept your order", 
        timer = 2000, 
        showConfirmationButton = false
      } = {}) {
        this.alert({
          title: title,
          text: text,
          timer: timer,
          button: showConfirmationButton,
          icon: 'success'
        });
      },
      alertError({
        title = "Error!", text = "Oops...Sorry, this room had full as that time! Please choose another time!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      orderWorkspace() {
        if (this.officeOrder.type.id == 3) {
          this.endDate = this.startDate
        } else {
          this.startTime = ''
          this.endTime = ''
        }

        var orderParams = {
          name: this.name,
          time_start: moment(String(this.valueDateTimeOrder[0])).format('YYYY/MM/DD'),
          time_end: moment(String(this.valueDateTimeOrder[1])).format('YYYY/MM/DD'),
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
        this.getAllOrders(this.officeOrder.workspace_id)
      },
      allOrders() {
        this.orderById = this.getOrderByOfficeId(this.officeOrder.id)
        for (var i = 0; i < this.orderById.length; i++) {
          let newDate = new Date(this.orderById[i].time_start)
          let end = new Date(this.orderById[i].time_end)
          while (newDate <= end){
            this.range.push(moment(String(newDate)).format('YYYY/MM/DD'))
            newDate.setDate(newDate.getDate()+1)
          }
        }
        var self = this;
        this.pickerOptions = {
          disabledDate(time) {
            for (var i = 0; i < this.range.length; i++) {
              let date = new Date(this.range[i])
              return time.getTime() === date;
            }
          }
        }
      }
    }
  }
</script>
<style scoped>
  .button-control {
    text-align: center;
  }
  .el-date-editor {
    width: 100%;
  }
</style>