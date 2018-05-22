<template>
  <div>
    <b-modal id="orderModal" ref= "orderModal" hide-footer hide-header>
      <div v-if="officeOrder.type">
        <b-form>
          <h1><span class="decorate-span">Available reserve</span></h1> 
          <h3>{{officeOrder.type.name}}</h3>
          <b-row>
            <p>Your name</p>
            <b-form-input v-validate="'required'" v-model="name" name="username"></b-form-input>
            <span v-show="errors.has('username')" class="is-danger">{{ errors.first('username') }}</span>
          </b-row>
          <!-- Open planroom -->
          <!-- <div v-if="officeOrder.type.id == 3"> -->
          <b-row v-if="officeOrder.type.id == 3">
            <span>Number of people </span>
            <b-col>
              <select v-model="quantity">
                <option v-for="option in officeOrder.number_of_people" v-bind:value="option" :key="option">
                  {{ option }}
                </option>
              </select>
            </b-col>
          </b-row>
          <!-- </div> -->
          <!-- Else -->
          <div>
            <b-row>
              <p>Date</p>
              <el-date-picker
              ref="picker"
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
      var self = this
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
        disabledDates: [],
        pickerOptions: {
          disabledDate(time) {
            let format_time = moment(time).format('YYYY-MM-DD');
            return self.disabledDates.indexOf(format_time)>-1 || time < Date.now() 
          }
        },
        OK_STATUS: 200
      }

    },
    computed: {
      ...mapState({
        currentUser:state => state.user.currentUser,
        createdOrder:state => state.order.newOrder,
        allOrders:state => state.order.allOrder,
        orderStatus:state => state.order.orderStatus
      }),
      ...mapGetters("order", [
        "getOrderByOfficeId"
        ])
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
        timer = 5000, 
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
      alertConfirm({
        title = "Error!", text = "Invalid name or time. Please try again!!"
      } = {}) {
        this.alert({
          title: title,
          text: text,
          icon: 'error'
        });
      },
      orderWorkspace() {
        if (this.name && this.valueDateTimeOrder[0] && this.valueDateTimeOrder[1]) {
          var orderParams = {
            name: this.name,
            time_start: moment(String(this.valueDateTimeOrder[0])).format('YYYY-MM-DD'),
            time_end: moment(String(this.valueDateTimeOrder[1])).format('YYYY-MM-DD'),
            quantity: this.quantity,
            workspace_type_id: this.officeOrder.id,
            workspace_id: this.officeOrder.workspace_id,
            user_id: this.currentUser.id
          };
          this.createOrder(orderParams)
          this.hideModal()
        } else {
          this.alertConfirm()
        }
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
          while (newDate <= end && newDate.getDate() < Date.now()){
            this.range.push(moment(String(newDate)).format('YYYY-MM-DD'))
            newDate.setDate(newDate.getDate()+1)
          }
        }
        this.disabledDates = this.range
        this.$refs.picker.unmountPicker();
        this.$refs.picker.mountPicker();
      },
      orderStatus() {
        if (this.orderStatus === this.OK_STATUS) {
          this.alertSuccess()
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