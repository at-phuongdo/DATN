<template>
  <div>
    <b-modal id="orderModal" ref= "orderModal" hide-footer hide-header>
      <div>
        <b-form>
          <h1><span class="decorate-span">Available reserve</span></h1>
          <p>Name</p>
          <b-form-input v-model="name"></b-form-input>
          <p>Number of people</p>
          <select v-model="numberPeople">
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
              <b-form-input type="date"></b-form-input>
            </b-col>
          </b-row>
          <p>End time</p>
          <b-row>
            <b-col md="6">
              <el-time-select v-model="endTime" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}" placeholder="Open time">
              </el-time-select>
            </b-col>
            <b-col md="6">
              <b-form-input type="date"></b-form-input>
            </b-col>
          </b-row>
          <div class="button-control">
            <!-- <b-button @click="editComment" variant="primary" >Save</b-button> -->
            <!-- <b-btn variant="danger" @click="hideModal" >Close</b-btn> -->
          </div>
        </b-form>
      </div>
    </b-modal>
  </div>
</template>
<script>
  export default {
    props: ['officeOrder'],
    data() {
      return {
        name: '',
        startTime: '',
        endTime: '',
        numberPeople: null
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