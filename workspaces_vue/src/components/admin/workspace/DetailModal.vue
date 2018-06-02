<template>
  <b-modal id="detailModal" ref="detailModal" :title="workspace.name" size="lg">
    <div class="description">
      <p><span class="fa fa-map-marker"></span>{{workspace.address}}</p>
      <h4><span class="fa fa-bullseye"></span><strong> Overview</strong></h4>
      <div v-html="workspace.description"></div>
    </div>
    <div class="opening-hour">
      <h4><strong>Opening hour</strong></h4>
      <table class="opening-table">
        <thead>
          <tr>
            <th>Monday</th>
            <th>Tuesday</th>
            <th>Wednesday</th>
            <th>Thursday</th>
            <th>Friday</th>
            <th>Saturday</th>
            <th>Sunday</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{workspace.open_mon}}</td>
            <td>{{workspace.open_tue}}</td>
            <td>{{workspace.open_wed}}</td>
            <td>{{workspace.open_thurs}}</td>
            <td>{{workspace.open_fri}}</td>
            <td>{{workspace.open_sat}}</td>
            <td>{{workspace.open_sun}}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="amenities">
      <h4><span class="fa fa-gratipay"></span><strong> Amenities</strong></h4>
      <ul>
        <li v-for="amenity in workspace.convenient" :key="amenity.id">{{amenity.name}}</li>
      </ul>
    </div>
    <hr>
    <div class="room-type">
      <h4><span class="fa fa-building"></span><strong> Office type & Price</strong></h4>
      <table class="room-table">
        <tr>
          <th>Office type</th>
          <th>Name</th>
          <th>Number Of People</th>
          <th>Price Day</th>
          <th>Price Week</th>
          <th>Price Month</th>
          <th>Price Year</th>
        </tr>
        <tr v-for="row in workspace.workspace_types" :key="row.id">
          <td>{{row.type.name}}</td>
          <td>{{row.name}}</td>
          <td>{{row.number_of_people}}</td>
          <td>{{row.price_day}}</td>
          <td>{{row.price_week}}</td>
          <td>{{row.price_month}}</td>
          <td>{{row.price_year}}</td>
        </tr>
      </table>
    </div>
  </b-modal>
</template>
<script>
  export default {
    props: ['workspace'],
    data() {
      return {

      }
    },
    methods: {

    }
  }
</script>
<style>
  .opening-table,
  .room-table {
    width: 100%;
    text-align: center;
  }

  .opening-table th, td{
    border: 1px solid #e5e5e5;
  }

  .room-table th, td{
    border: 1px solid #e5e5e5;
  }

</style>